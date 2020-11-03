-- The following module implements a SPI Master driving a unique Slave
--
--  
-- The new Frame to be send is loaded in master buffer only when the Master
-- is not currently perfoming Data Transmission, ie SlaveSelect signal is low.
-- 


-- ----------------------------- Main Porperties SPI Master ---------------------------------
--	|		Instances	  		|					Utility								  	|		
--	|					  		|														  	|
--	| 	  SPI_MasterBuffer:		|   Buffer for Loading SPI Master Shift Register. Its	  	|
--  | 					  		|   contains is uploaded with the new data to be send from 	|
--  |               	  		|   input Data2Transfer. Uploading this Register results	|
--  |               	  		|   into a start of Data Transmission to the slave.	The 	|
--  |               	  		|	Data received from the slave are made available for 	|
--	|					  		|	reading outside of the module in this Register at the 	|
--	|					  		|	the End of a SPI Cycle.									|
--  |               	  		|														  	|
--  |               	  		|														  	|
--  | 	SPI_MasterShiftReg:		|	It is the register used for SPI Data exchange. Its	  	|
--  | 			     	  		|	trasnmits to the slave the contains of the SPI_Master 	|
--  |               	  		|	Buffer and receives Data from the slave.			  	|
--  |               	  		|														  	|
--  | 	  Quit_ValidData:		|	Use either to declare valid data for Master to start  	|
--  |               	  		|   a new trasnmission or to acknoledge the data read at  	|
--  |               	  		|	end of trasnmission. 			 					  	|
--  |  							|             	  				 					  		|
--  |               	  		|														  	|
--  | 	read_SPI_MasterBuffer:	|	To acknowledge that Data from SPI Master Buffer at the 	|
--  |               	  		|	end of a Trasnsaction has been read.				  	|
--	|							|															|
--  | 		Master_done:		|	this Output signalises that the SPI Master has finish a	|
--  |							|	trasnmission and is waiting for an Acknowledge from the	|
--  |							|	Master Top Module.										|
--  |							|															|
--  |							|															|
--  |		Data2Transfer:		|	Use for Bidirectional trasnmission betweeen SPI Master	|
--	|							|	and its Top Module, when the used FPGA provides Tri-	|
--	|							|	state also on inner Module, Otherwise use the in and	|
--	|							|	out Pin TX_Frame and RX_Frame on Master module			|
--	|							|															|
--	|			Bidir:			|	Defines it the 2 Pins TX_Frame and RX_Frame are to be	|
--	|							|	use or instead the bidirection pin Data2Transfer is to	|							|	(Bidir1)														|
--	|							|	be used, (Bidir = '1').									|
--	|							|															|
--	|		SCLK_Freq:			|	Defines the Bit timing. Can only be set, when the		|
--	|							|	Quit_ValidData input is still not asserted, Thus only 	|
--	|							|	when no Transaction is running.							|
--	|							|															|
--	|							|															|

Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity spi_master is
	generic(
		mode: std_ulogic_vector(1 downto 0):= "00";	-- mode(0) => CPOL, mode(1) => CPHA	
		msb: std_ulogic:= '1';	-- '0' LSB first, '1' MSB first
		MaxBaudrateCounterLength: positive:= 16;
		MSB4FrameLength: positive:= 8;
		NbrBit4BinaryBitCounter: positive:= 3);
	
	port(
		clk: in std_ulogic;
		rst: in std_ulogic;
		Bidir: in std_ulogic:= '0';	-- select with Data Input to consider
		Quit_ValidData: in std_ulogic;	-- 
		read_SPI_MasterBuffer: in std_ulogic:= '0';	-- Handshake, optional
		SCLK_Freq: in u_unsigned;-- unresolved_unsigned
		Master_done: out std_ulogic;					-- Handshake		
		Data2Transfer: inout std_logic_vector(MSB4FrameLength -1 downto 0);
		TX_Frame: in std_logic_vector(MSB4FrameLength -1 downto 0);		-- Data2Slave coming from Top Module
		RX_Frame: out std_logic_vector(MSB4FrameLength -1 downto 0);	-- DataFromSlave going to Top Module 
		
	    --	Bus signals
		sclk: out std_ulogic;
		SlaveSelect: out std_ulogic;	-- signalise a busy master outside
		mosi: out std_ulogic;
		miso: in std_ulogic
	);
	begin
	
		Desired_Baudrate_is_reachable_with_counter_max_value: 
		assert MaxBaudrateCounterLength > SCLK_Freq'high
			report "SCLK_Freq to high: " &
				"The Instantiated SPI Master Module cannot" &
				" realised the desired SCLK_Freq." &
				"Reduces the SCLK_Freq"
				severity failure;
		
		Check_NbrBits2Send_and_MSB4FrameLength:
		assert (2**NbrBit4BinaryBitCounter) <= MSB4FrameLength
			report "The Actual Total Number of Bits to Send via the "&
				   "instantiated module cannot be reached."&
				   "For the Generic NbrBit4BinaryBitCounter\"&
				   "MSB4FrameLength, choose a greather\lower Value."
				severity failure;
		 
end entity spi_master;


architecture master_design of spi_master is

  --constant max_bitrateCounter: 
  constant MSB_4_Frame: positive:= MSB4FrameLength - 1;
  --constant MSB_4_BitCounter: positive:= MSB4BitCounter - 1;
  
  constant Baudratezero: u_unsigned(MaxBaudrateCounterLength - 1 downto 0):= (others => '0'); 
  constant BitCounterMax: u_unsigned(NbrBit4BinaryBitCounter - 1 downto 0):= u_unsigned(to_unsigned(MSB_4_Frame,NbrBit4BinaryBitCounter)); 

  signal r_BitrateCounter,r_baudrate: u_unsigned(Baudratezero'range);	
  signal r_Master_BitCounter: u_unsigned(NbrBit4BinaryBitCounter - 1 downto 0):= (others => '0');

  --signal MasterReadFlag: std_ulogic:= '1';	--r_SlaveSelect
  signal r_sclk,r_done,r_LoadShiftRegister: std_ulogic:= '0';
  signal SPI_MasterBuffer,SPI_MasterShiftReg: std_ulogic_vector(Data2Transfer'range):= (others => '0');
  signal Frame2Slave: std_ulogic_vector(Data2Transfer'range); 

  type fsm is (master_idle,master_activ,master_waiting4Ackn);
  signal master_state: fsm:= master_idle;


begin

  
  Read_Data2Transfer: Frame2Slave <= Data2Transfer when Bidir else TX_Frame; --  -- Value of Data2Transfer is permanently read 
  Drive_Data2Transfer: Data2Transfer <= SPI_MasterBuffer when not (Quit_ValidData or read_SPI_MasterBuffer) else (others =>'Z');
  RX_Frame <= SPI_MasterBuffer;

TransitionControl:
process(clk,rst)
begin

	if rst = '1' then
    	master_state <= master_idle;
    	
    elsif rising_edge(clk) then
	
		if master_state = master_idle and SPI_MasterBuffer /= Frame2Slave and
		   Quit_ValidData = '1' then
			master_state <= master_activ;
		
		-- Return to idle State when all Bits defined by inputs NbrBits2Send 
		-- and the Bit time leght defined by input SCLK_Freq are reached
		elsif (master_state = master_activ) and ((r_BitrateCounter = Baudratezero) and 
			  (r_Master_BitCounter = BitCounterMax)) then
			master_state <= master_waiting4Ackn;
			
		elsif (master_state = master_waiting4Ackn) and (Quit_ValidData = '1' or read_SPI_MasterBuffer = '1') then
			master_state <= master_idle;

		end if;
	end if;
end process TransitionControl; 



DataTransmissionControl:
process(clk,rst)
begin

	if rst = '1' then
		SPI_MasterBuffer <= (others => '0');
		--r_SlaveSelect <= '1';
		--MasterReadFlag <= '1';
		r_LoadShiftRegister <= '0';
		r_done <= '0';
		r_baudrate <= (others => '0');
		
		r_BitrateCounter <= (others => '0');
		r_Master_BitCounter <= (others => '0');
		r_sclk <= '1' and mode(0);
		
	elsif rising_edge(clk) then
	
		case master_state is
		
			when master_idle =>
				
				SaveBaudrateValue:
				r_baudrate <= to_unsigned(to_integer(SCLK_Freq - 1),MaxBaudrateCounterLength);
				
				RessetingMAster_done: r_done <= '0';
				--------- Setting SelectSignal activ -----------------	
				if SPI_MasterBuffer /= Frame2Slave and Quit_ValidData = '1' then	-- Latch Value of Data2Transfer
					SPI_MasterBuffer <= Frame2Slave;
					
					Bit_timing_counter_initialization:
					r_BitrateCounter <= r_baudrate;					
					
					--r_SlaveSelect <= '0';
					r_LoadShiftRegister <= '1';
					
				end if;
					


			when master_activ =>
			
				--r_SlaveSelect <= '0';
				r_LoadShiftRegister <= '0';
				
				GenSPIClock:
				if (r_BitrateCounter = (r_baudrate sra 1) + 1) or (r_BitrateCounter = Baudratezero) then	-- Divide SCLK_Freq per 2 and add 1
					r_sclk <= not r_sclk;
				
				end if GenSPIClock;
				
				Counter4BitTiming:				
				if r_BitrateCounter = Baudratezero then
					r_BitrateCounter <= r_baudrate;
					
				else
					r_BitrateCounter <= r_BitrateCounter - 1;
					
				end if Counter4BitTiming;
						
				TotalNbrOfSendBitsTracking:
				if r_BitrateCounter = Baudratezero and r_Master_BitCounter /= BitCounterMax then
					r_Master_BitCounter <= r_Master_BitCounter + 1;		-- keep actual nbr of sent bits
					
				-- End of Transmission
				elsif r_BitrateCounter = Baudratezero and r_Master_BitCounter = BitCounterMax then
					r_Master_BitCounter <= (others => '0');
															
				end if TotalNbrOfSendBitsTracking;
				
			
				
			when master_waiting4Ackn =>
				
				--SPI_MasterBuffer <= SPI_MasterShiftReg;
				
				SettingMaster_done:
				if Quit_ValidData or read_SPI_MasterBuffer then
					r_done <= '0';
					
				else
					r_done <= '1' ;
					SPI_MasterBuffer <= SPI_MasterShiftReg;
					
				--elsif read_SPI_MasterBuffer or Quit_ValidData  then
				--	r_done <= '0';
					
				end if SettingMaster_done;


				
			when others =>
				null;
				
		end case;
	end if;
end process DataTransmissionControl;


------------------- SPI Transmission --------------------
SPI_Mode: if (xnor mode = '1') and msb = '0' generate	-- mode "00" or "11" <=> (cpol = 0 and cpha = 0) or (cpol = 1 and cpha = 1)

  SPI_Transmission1A:
  process(r_sclk,r_LoadShiftRegister) --SlaveSelect_Fal_Edge
  begin
  	
  	if r_LoadShiftRegister = '1' then	      				    
  		Initialize_Shift_Register: SPI_MasterShiftReg <= SPI_MasterBuffer;
  	
  	elsif rising_edge(r_sclk)  then	-- Read Slave value			 
  		SPI_MasterShiftReg <= miso & SPI_MasterShiftReg(MSB_4_Frame downto 1);
		
	end if;
  
  end process SPI_Transmission1A;


elsif (xnor mode = '1') and msb = '1' generate

  SPI_Transmission1B:
  process(r_sclk,r_LoadShiftRegister) --SlaveSelect_Fal_Edge
  begin
  	
  	if r_LoadShiftRegister = '1' then	      		
  		Initialize_Shift_Register: SPI_MasterShiftReg <= SPI_MasterBuffer;
  	
  	elsif rising_edge(r_sclk) then	-- Read Slave value			 
  		SPI_MasterShiftReg <= SPI_MasterShiftReg(MSB_4_Frame -1 downto 0) & miso;
  	
	end if;
  
  end process SPI_Transmission1B;


elsif xor mode = '1' and msb = '0' generate

  SPI_Transmission2A:
  process(r_sclk,r_LoadShiftRegister) --SlaveSelect_Fal_Edge
  begin
  	
  	if r_LoadShiftRegister = '1' then	 																				
  		Initialize_Shift_Register: SPI_MasterShiftReg <= SPI_MasterBuffer;	-- ror NbrBits2Send;
  		
  	elsif falling_edge(r_sclk) then	-- Read Slave value			 
  		SPI_MasterShiftReg <= miso & SPI_MasterShiftReg(MSB_4_Frame downto 1);
		
	end if; 
  end process SPI_Transmission2A;
  
elsif (xor mode = '1') and msb = '1' generate
 
   SPI_Transmission2B:
   process(r_sclk,r_LoadShiftRegister) --SlaveSelect_Fal_Edge
   begin
   	
   	if r_LoadShiftRegister = '1' then		 		
   		Initialize_Shift_Register: SPI_MasterShiftReg <= SPI_MasterBuffer;
   		
   	elsif falling_edge(r_sclk)  then	-- Read Slave value			 
   		SPI_MasterShiftReg <= SPI_MasterShiftReg(MSB_4_Frame -1 downto 0) & miso;
   	
	end if; 
   end process SPI_Transmission2B;
  
end generate SPI_Mode;




  sclk <= ('1' and mode(0)) when master_state /= master_activ else r_sclk;

  Gen_mosi: if msb = '0' generate
	mosi <= SPI_MasterShiftReg(0) when r_done = '0' else 'Z'; -- master_state = master_activ 

  else generate 
	mosi <= SPI_MasterShiftReg(MSB_4_Frame) when r_done = '0'  else 'Z'; -- master_state = master_activ
	
  end generate Gen_mosi;
  
  SlaveSelect <= '0' when master_state = master_activ else '1';
  Master_done <= r_done;
  
end master_design;











-- The following module implements a SPI Slave 
--
--  
-- The new Frame to be send is loaded in slave buffer only when the Slave
-- is not currently perfoming Data Transmission, ie SlaveSelect signal is low.
-- 

-- ----------------------------- Main Porperties SPI Slave ---------------------------------
--	|		Instances	  		|					Utility								  	|		
--	|					  		|														  	|
--	| 	  SPI_SlaveBuffer:		|   Buffer for Loading SPI Master Shift Register. Its	  	|
--  | 					  		|   contains is uploaded with the new data to be send from 	|
--  |               	  		|   input Data2Transfer. Uploading this Register results	|
--  |               	  		|   into a start of Data Transmission to the slave.	The 	|
--  |               	  		|	Data received from the slave are made available for 	|
--	|					  		|	reading outside of the module in this Register at the 	|
--	|					  		|	the End of a SPI Cycle.									|
--  |               	  		|														  	|
--  |               	  		|														  	|
--  | 	SPI_SlaveShiftReg:		|	It is the register used for SPI Data exchange. It	  	|
--  | 			     	  		|	trasnmits to the Master the contains of the SPI_Slave 	|
--  |               	  		|	Buffer and receives Data from the Master.			  	|
--  |               	  		|														  	|
--  | 	  Quit_ValidData:		|	Use either to declare valid data for Slave to start  	|
--  |               	  		|   a new trasnmission or to acknoledge the data read at  	|
--  |               	  		|	end of trasnmission. 			 					  	|
--  |  							|             	  				 					  		|
--  |               	  		|														  	|
--  | 	read_SPI_SlaveBuffer:	|	To acknowledge that Data from SPI Slave Buffer at the 	|
--  |               	  		|	end of a Trasnsaction has been read.				  	|
--	|							|															|
--  | 		Slave_done:			|	this Output signalises that the SPI Slave has finish a	|
--  |							|	trasnmission and is waiting for an Acknowledge from the	|
--  |							|	Master Top Module.										|
--  |							|															|
--  |							|															|
--  |		Data2Transfer:		|	Use for Bidirectional trasnmission betweeen SPI Slave	|
--	|							|	and its Top Module, when the used FPGA provides Tri-	|
--	|							|	state also on inner Module, Otherwise use the in and	|
--	|							|	out Pin TX_Frame and RX_Frame on Slave module			|
--	|							|															|
--	|			Bidir:			|	Defines it the 2 Pins TX_Frame and RX_Frame are to be	|
--	|							|	use or instead the bidirection pin Data2Transfer is to	|																			|
--	|							|	be used, (Bidir = '1').									|
--	|							|															|
--	|							|															|
--	|							|															|
--	|							|															|
--	|							|															|
--	|							|															|



Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity spi_slave is
	generic(
		mode: std_logic_vector(1 downto 0):= "00";	-- mode(0) => CPOL, mode(1) => CPHA	
		msb: std_logic:= '1';	-- '0' LSB first, '1' MSB first
		MSB4FrameLength: positive:= 8
	);
	
	port(
		clk: in std_ulogic;
	    rst: in std_ulogic;
		Bidir: in std_ulogic;	-- select with Data Input to consider
		Quit_ValidData: in std_ulogic;
		read_SPI_SlaveBuffer: in std_ulogic;	
		Slave_done: out std_ulogic;
		Data2Transfer: inout std_logic_vector(MSB4FrameLength -1 downto 0);
		RX_Frame: in std_ulogic_vector(MSB4FrameLength -1 downto 0);	-- Data2Master coming from Top Module
		TX_Frame: out std_ulogic_vector(MSB4FrameLength -1 downto 0);	-- Data From Master going to Top Module
	    --	Bus signals
		sclk: in std_ulogic;
		SlaveSelect: in std_ulogic;
		mosi: in std_ulogic;
		miso: out std_ulogic
	);
end entity spi_slave;

architecture slave_design of spi_slave is

  constant MSB_4_Frame: natural:= MSB4FrameLength - 1;
  
  signal r_done,r_LoadSlaveShiftRegister: std_ulogic:= '0';
  signal r_SlaveSelect: std_logic:= '1';
 -- signal NewFrame2Master: std_logic;
  
  signal SPI_SlaveBuffer,SPI_SlaveShiftReg: std_logic_vector(Data2Transfer'range):= (others => '0');
  signal Frame2Master: std_logic_vector(Data2Transfer'range);
  signal rise,fall,En_Data2Transfer: std_ulogic;

  type fsm is (slave_idle,slave_activ,slave_waiting4Ackn);
  signal slave_state: fsm:= slave_idle;


begin

  TristateControl: En_Data2Transfer <= '1' when r_done = '1' else '0'; 
  -- Value of Data2Transfer is permanently read  
  Read_Data2Transfer: Frame2Master <= Data2Transfer when Bidir else RX_Frame ;	--  -- Value of Data2Transfer is permanently read 
  Drive_Data2Transfer: Data2Transfer <= SPI_SlaveBuffer when En_Data2Transfer else (others =>'Z');
  TX_Frame <= SPI_SlaveBuffer;

  SaveValueSlaveSelect:process(clk, rst)
  begin
  
  	if rst = '1' then
  		r_SlaveSelect <= '1';
  		
  	elsif rising_edge(clk) then
  		r_SlaveSelect <= SlaveSelect;
  		
  	end if;	
  end process SaveValueSlaveSelect;
  
  FallingEdgeOnSlaveSelect: fall <= r_SlaveSelect and (not SlaveSelect); 
  RsingEdgeOnSlaveSelect: rise <= SlaveSelect and (not r_SlaveSelect);

  TransitionControl:
  process(clk,rst)
  begin
  
  	if rst = '1' then
      	slave_state <= slave_idle;
      	
      elsif rising_edge(clk) then
	  
  		if fall = '1' then -- slave_state = slave_idle and 
  			slave_state <= slave_activ;
  				
  		elsif rise = '1' then	-- rslave_state = slave_activ and 
  			slave_state <= slave_waiting4Ackn;
			
		elsif slave_state = slave_waiting4Ackn and r_done = '0' then	
			slave_state <= slave_idle;
  			
  		end if;
  	end if;
  end process TransitionControl; 



  
  TransmissionControl:
  process(clk,rst)
  begin
  
  	if rst = '1' then
  		SPI_SlaveBuffer <= (others =>'0');
		--SlaveReadFlag <= '1';
		r_done <= '0';
		r_LoadSlaveShiftRegister <= '0';
  		
  	elsif rising_edge(clk) then
  	
  		case slave_state is
  		
  			when slave_idle =>

				if (SPI_SlaveBuffer /= Frame2Master) and Quit_ValidData = '1' then	
					SPI_SlaveBuffer <= Frame2Master;
					r_LoadSlaveShiftRegister <= '1';
					
				else
					r_LoadSlaveShiftRegister <= '0';
					
   				end if;
  					
  
  
  			when slave_activ =>
				
				r_LoadSlaveShiftRegister <= '0';
				
  				Load_SPI_SlaveBuffer:	-- when Master Transmission is finished
  				if rise = '1' then
  					SPI_SlaveBuffer <= SPI_SlaveShiftReg;
					r_done <= '1';
  					--SlaveReadFlag <= '0';
					
  				end if Load_SPI_SlaveBuffer;
				
				
				
			when slave_waiting4Ackn =>
				
				SettingSlave_done:
				if read_SPI_SlaveBuffer = '1' or Quit_ValidData = '1' then
					r_done <= '0';
					
				end if SettingSlave_done;
  
  				
  			when others =>
  				null;
  				
  		end case;
  	end if;
  end process TransmissionControl;

	
SPI_Transmission:
if mode = "00" and msb = '0' generate
  
DataTransmissionControllA:
  process(sclk,r_LoadSlaveShiftRegister)
  begin
	
	if r_LoadSlaveShiftRegister = '1' then 
		Initialize_Shift_Register:	SPI_SlaveShiftReg <= SPI_SlaveBuffer;
  		
  	elsif rising_edge(sclk) then
		SPI_SlaveShiftReg <= mosi & SPI_SlaveShiftReg(MSB_4_Frame downto 1);

  	end if;
  end process DataTransmissionControllA;
	
elsif mode = "00" and msb = '1' generate

DataTransmissionControllB:
  process(sclk,r_LoadSlaveShiftRegister)
  begin
  
  	if r_LoadSlaveShiftRegister = '1' then 
		Initialize_Shift_Register:	SPI_SlaveShiftReg <= SPI_SlaveBuffer;
  		
  	elsif rising_edge(sclk) then
		SPI_SlaveShiftReg <= SPI_SlaveShiftReg(MSB_4_Frame - 1 downto 0) & mosi;

  	end if;
  end process DataTransmissionControllB;
  
elsif mode = "01" and msb = '0' generate

DataTransmissionControl2A:
  process(sclk,r_LoadSlaveShiftRegister)
  begin
  
  	if r_LoadSlaveShiftRegister = '1' then
		Initialize_Shift_Register:	SPI_SlaveShiftReg <= SPI_SlaveBuffer;
  		
  	elsif falling_edge(sclk) then
		SPI_SlaveShiftReg <= mosi & SPI_SlaveShiftReg(MSB_4_Frame downto 1);

  	end if;
  end process DataTransmissionControl2A; 
  
elsif mode = "01" and msb = '1' generate
  
DataTransmissionControl2B:
  process(sclk,r_LoadSlaveShiftRegister)
  begin
  
  	if r_LoadSlaveShiftRegister = '1' then 
		Initialize_Shift_Register:	SPI_SlaveShiftReg <= SPI_SlaveBuffer;
  		
  	elsif falling_edge(sclk) then
		SPI_SlaveShiftReg <= SPI_SlaveShiftReg(MSB_4_Frame - 1 downto 0) & mosi;

  	end if;
  end process DataTransmissionControl2B;
  
elsif mode = "10" and msb = '0' generate
  
DataTransmissionControl3A:
  process(sclk,r_LoadSlaveShiftRegister)
  begin
  
  	if r_LoadSlaveShiftRegister = '1' then 
		Initialize_Shift_Register:	SPI_SlaveShiftReg <= SPI_SlaveBuffer;
  		
  	elsif falling_edge(sclk) then
		SPI_SlaveShiftReg <= mosi & SPI_SlaveShiftReg(MSB_4_Frame downto 1);

  	end if;
  end process DataTransmissionControl3A;
	
elsif mode = "10" and msb = '1' generate

DataTransmissionControl3B:
  process(sclk,r_LoadSlaveShiftRegister)
  begin
  
  	if r_LoadSlaveShiftRegister = '1' then 
		Initialize_Shift_Register:	SPI_SlaveShiftReg <= SPI_SlaveBuffer;
  		
  	elsif falling_edge(sclk) then
		SPI_SlaveShiftReg <= SPI_SlaveShiftReg(MSB_4_Frame - 1 downto 0) & mosi;

  	end if;
  end process DataTransmissionControl3B;
  
elsif mode = "11" and msb = '0' generate

DataTransmissionControl4A:
  process(sclk,r_LoadSlaveShiftRegister)
  begin
  
  	if r_LoadSlaveShiftRegister = '1' then 
		Initialize_Shift_Register:	SPI_SlaveShiftReg <= SPI_SlaveBuffer;
  		
  	elsif rising_edge(sclk) then
		SPI_SlaveShiftReg <= mosi & SPI_SlaveShiftReg(MSB_4_Frame downto 1);

  	end if;
  end process DataTransmissionControl4A; 
  
elsif mode = "11" and msb = '1' generate
  
DataTransmissionControl4B:
  process(sclk,r_LoadSlaveShiftRegister)
  begin
  
  	if r_LoadSlaveShiftRegister = '1' then 
		Initialize_Shift_Register:	SPI_SlaveShiftReg <= SPI_SlaveBuffer;
  		
  	elsif rising_edge(sclk) then
		SPI_SlaveShiftReg <= SPI_SlaveShiftReg(MSB_4_Frame - 1 downto 0) & mosi;

  	end if;
  end process DataTransmissionControl4B;


end generate SPI_Transmission;


  Gen_mosi: if msb = '0' generate
	miso <= SPI_SlaveShiftReg(0) when slave_state = slave_activ  else 'Z'; 
  
  else generate 
	miso <= SPI_SlaveShiftReg(MSB_4_Frame) when slave_state = slave_activ else 'Z';
  
  end generate Gen_mosi;

  Slave_done <= r_done;
  
  
end slave_design;