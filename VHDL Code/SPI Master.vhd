-- The following module implements a SPI Master driving a unique Slave
--
--  
-- The core of the SPI Transmission is the 8 bit Shift Register SPI_MasterShiftReg which can be
-- directly parallel loaded with the 8 Bits input Signal tx_frame when the input DataValid is set.
-- Also the contains of the Shift Register can be directly parallel read at the output rx_frame.
-- During SPI Trasnmission the Shift Register is used to received the Slave Data shifting bit 
-- according to the selected spi Clock edge.
--
-- With the generic 2 bits std_ulogic_vector mode the master is defined to be synthetisize and 
-- running in 4 possible SPI Configuration. mode(0) = CPOL and mode(1) = CPHA
--
--



-- ------------------------------------- Port Description ------------------------------------------
--  |								|																|
--  |			msb:					|	Define if the Data should be trasnmitted MSB first or LSB	|
--  |								|	first. msb = '1' then MSB first else LSB first.			|
--  |								|																|
--  |			SCLK_Freq:				|	Defines the Baudrate for a SPI Cycle as a u_unsigned 		|
--  |								|	vector. The vector length is given by the generic		|
--  |								|	MaxBaudrateCounterLength which default value is 10. So the	|
--  |								|	synthetisize module could divide the system clock down to	|
--  |								|	1024 its nominal value. Therefore for a system clock of 	|
--  |								|	50 MHz, the	minimum  Baudrate could be ~ 38.4 KBits/S.	|
--  |								|									|
--  |			DataValid:				|	Enable parallel load of the Shift register with new data  	|
--  |               	  					|	to be send.							|
--  |               	  					|									|
--  |			freigabe:				|	Enable an new SPI Cycle when set otherwise the Master is  	|
--  |               	  					|   	freezed and remain on state idle.				|
--  |							   	|	 								|
--  |			done:					|	Signalises that the SPI Master has finished a trasnmission,	|
--  |							   	|	the slave data could be read from the Shift Register.		|
--  |							   	|									|
--  |							   	|	 								|
--  |			tx_frame:		   		|	Use to load the Shift Register whenever the input DataValid	|
--  |							   	|	is set.								|
--  |								|									|
--  |			rx_frame:				|	The contains of the Shift Register are make available here	|
--  |								|	at the end of a cycle and are valid when done is asserted	|
--  |								|									|
--  |			SCLK_Freq:	   			|	Defines the Bit timing. Can only be set, when the		|
--  |							   	|	freigabe input is still not asserted before a transmis-   	|
--  |							   	|	sion is started, thus only when no Transaction is running 	|
--  |							   	|													  		  	|
--  |							   	|															  	|

Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity spi_master_M25P16 is
	generic(
		mode: std_ulogic_vector(1 downto 0):= "00";	-- mode(0) => CPOL, mode(1) => CPHA		
		MaxBaudrateCounterLength: positive:= 10;	-- Define the Bit length of r_BaudCounter
		MSB4FrameLength: positive:= 8);
		--NbrBit4BinaryBitCounter: positive:= 3);
	
	port(
		-- Config for a transmission 
		msb: in std_ulogic:= '1';	-- '0' LSB first, '1' MSB first
		SCLK_Freq: in u_unsigned(MaxBaudrateCounterLength - 1 downto 0);
		--tx_frame_bytelength: in u_unsigned(MSB4FrameLength - 1 downto 0);	-- Nbr of byte to send during a transmission
		--rx_frame_bytelength: in u_unsigned(MSB4FrameLength - 1 downto 0);	-- Nbr of byte to be expected from the Slave during a transmission
		
		-- active signal during a trasnmission
		clk: in std_ulogic;
		rst: in std_ulogic;
		DataValid: in std_ulogic;
		freigabe: in std_ulogic;
		done: out std_ulogic;		
		tx_frame: in std_ulogic_vector(MSB4FrameLength - 1 downto 0);	-- Data2Slave coming from Top Module
		rx_frame: out std_ulogic_vector(MSB4FrameLength - 1 downto 0);	-- DataFromSlave going to Top Module 
		
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
				" realised the desired Baudrate." &
				"Reduces the Baudrate"
				severity failure;
		 
end entity spi_master_M25P16;



architecture design of spi_master_M25P16 is

  function setup(s: std_ulogic_vector(1 downto 0)) return std_ulogic is
  begin
  
	if s(0) = '0' then
		return '0';
	else
		return '1';
	end if;
  end function;

  type master_fsm is (idle,activ);
  signal state: master_fsm:= idle;
  
  signal r_sclk: std_udlogic:= setup(mode);
  signal r_done,r_msb: std_ulogic:= '0';		
  signal SPI_MasterBuffer,SPI_MasterShiftReg: std_ulogic_vector(MSB4FrameLength - 1 downto 0):= (others => '0');
  
  signal r_bitCounter: u_unsigned(2 downto 0):= (others => '0');		
  signal r_BaudCounter: u_unsigned(MaxBaudrateCounterLength - 1 downto 0):= (others => '1');
  constant BaudCounterZero: u_unsigned(MaxBaudrateCounterLength - 1 downto 0):= (others => '0');
  
  signal SPI_MasterBuffer,SPI_MasterShiftReg: std_ulogic_vector(MSB4FrameLength - 1 downto 0):= (others => '0');

begin


FSM_State_Transition: process(clk,rst)
begin

  if rst = '1' then
  	state <= idle;
  
  elsif rising_edge(clk) then
  
	if state = idle and freigabe = '1' then
		state <= activ;
		
	elsif state = activ and r_bitCounter = "111" and r_BaudCounter = BaudCounterZero
		and freigabe = '0' then
		state <= idle;
			
	end if;
  end if;
end process FSM_State_Transition;
  
  
TransmissionControl: process(clk,rst)
begin

  if rst = '1' then
	r_BaudCounter <= (others => '0');
	r_done <= '0';
	r_msb <= '0';
	r_sclk <= setup(mode);
  
  elsif rising_edge(clk) then
  
	case state is
	
		when idle =>
			r_BaudCounter <= SCLK_Freq;
			r_done <= '0';
			r_msb <= msb;
		
		when activ =>
			
			Baudrate:
			if r_BaudCounter = BaudCounterZero then
				r_BaudCounter <= SCLK_Freq;
				
			else
				r_BaudCounter <= r_BaudCounter - 1;
				
			end if Baudrate;
			
			SPI_Clock:
			if r_BaudCounter = BaudCounterZero then
				r_sclk <= not r_sclk;
				
			end if SPI_Clock;
			
			
			Bitzaehler:
			if r_BaudCounter = BaudCounterZero and r_bitCounter /= MSB4FrameLength - 1 then
				r_bitCounter <= r_bitCounter + 1;
				
			elsif r_BaudCounter = BaudCounterZero and r_bitCounter = MSB4FrameLength - 1 then
				r_bitCounter <= (others => '0');
								
			end if Bitzaehler;
			
			Output_Done:
			if r_BaudCounter = BaudCounterZero and r_bitCounter = MSB4FrameLength - 1 then
				r_done <= '1';
				
			else
				r_done <= '0';
				
			end if Output_Done;
		
		
		when others =>
			null;
			
			
	end case;
  end if;
	
end process TransmissionControl;



Core: block
begin

  SPI_Mode: if xnor mode generate
  
    ShiftingBits0: process(r_sclk,DataValid)
    begin
    
		if DataValid = '1' then
			SPI_MasterShiftReg <= tx_frame;
    	
		elsif rising_edge(r_sclk) then
			
			if r_msb = '1' then
				SPI_MasterShiftReg <= SPI_MasterShiftReg(MSB4FrameLength - 2 downto 0) & miso;
				
			else
				SPI_MasterShiftReg <= miso & SPI_MasterShiftReg(MSB4FrameLength - 1 downto 1);
				
			end if;
		end if;
    
    end process ShiftingBits0; 
	
  else generate
 
    ShiftingBits1: process(r_sclk,DataValid)
    begin
    
		if DataValid = '1' then
			SPI_MasterShiftReg <= tx_frame;
    	
		elsif falling_edge(r_sclk) then
			
			if r_msb = '1' then
				SPI_MasterShiftReg <= SPI_MasterShiftReg(MSB4FrameLength - 2 downto 0) & miso;
				
			else
				SPI_MasterShiftReg <= miso & SPI_MasterShiftReg(MSB4FrameLength - 1 downto 1);
				
			end if;
		end if;
		
    end process ShiftingBits1;
  
  end generate SPI_Mode;
  
end block Core;


Outputs: block
begin

  SlaveSelect <= '0' when state = activ else '1';

  mosi <= SPI_MasterShiftReg(MSB4FrameLength - 1) when r_msb = '1' and state = activ else
		  SPI_MasterShiftReg(0) when r_msb = '0' and state = activ else 'Z';

  sclk <= r_sclk;
	  
  done <= r_done;
  
  rx_frame <= SPI_MasterShiftReg;

end block Outputs;


end design;
