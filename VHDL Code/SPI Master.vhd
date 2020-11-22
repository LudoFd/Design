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
  
  signal r_sclk: std_ulogic:= setup(mode);
  signal r_done,r_msb: std_ulogic:= '0';		
  
  signal r_bitCounter: u_unsigned(2 downto 0):= (others => '0');
  signal r_BaudCounter: u_unsigned(MaxBaudrateCounterLength - 1 downto 0):= (others => '1');
  constant BaudCounterZero: u_unsigned(MaxBaudrateCounterLength - 1 downto 0):= (others => '0');
  
  signal SPI_MasterShiftReg: std_ulogic_vector(MSB4FrameLength - 1 downto 0):= (others => '0');

begin


FSM_State_Transition: process(clk,rst)
begin

  if rst = '1' then
  	state <= idle;
  
  elsif rising_edge(clk) then
  
	if state = idle and freigabe = '1' then
		state <= activ;
		
	elsif state = activ and r_done = '1' and freigabe = '0' then
		state <= idle;
			
	end if;
  end if;
end process FSM_State_Transition;
  
  
TransmissionControl: process(clk,rst)
begin

  if rst = '1' then
	r_BaudCounter <= (others => '0');
	r_bitCounter <= (others => '0');
	r_done <= '0';
	r_msb <= '0';
	r_sclk <= setup(mode);
  
  elsif rising_edge(clk) then
  
	case state is
	
		when idle =>
			r_BaudCounter <= SCLK_Freq - 1;
			r_done <= '0';
			r_msb <= msb;
			r_sclk <= setup(mode);
			r_bitCounter <= (others => '0');
		
		when activ =>
			
			Baudrate:
			if r_BaudCounter = BaudCounterZero then
				r_BaudCounter <= SCLK_Freq - 1;
				
			else
				r_BaudCounter <= r_BaudCounter - 1;
				
			end if Baudrate;
			
			SPI_Clock:
			if r_BaudCounter = BaudCounterZero or r_BaudCounter = (SCLK_Freq sra 1) then
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
			
			SetBitforShiftRegister0:
			for i in SPI_MasterShiftReg'range loop

				if tx_frame(i) = '1' then
					SPI_MasterShiftReg(i) <= '1';
		
				else
					SPI_MasterShiftReg(i) <= '0';
		
				end if;

			end loop SetBitforShiftRegister0;

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
	    		SetBitforShiftRegister1:
			for i in SPI_MasterShiftReg'range loop
				
				if tx_frame(i) = '1' then
					SPI_MasterShiftReg(i) <= '1';
				
				else
					SPI_MasterShiftReg(i) <= '0';
				
				end if;
			end loop SetBitforShiftRegister1;
					
    	
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







Library ieee;
library Module;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test is  

end entity;

architecture testing of test is

 constant AnzDuts: positive:= 8;

 signal clk: std_ulogic:= '0';
 signal rst: std_ulogic:= '0';
 signal enable: std_ulogic;
 
 signal test_valid,test_fertig: std_ulogic_vector(1 to AnzDuts);
 
 type daten2xchange is array (1 to AnzDuts) of std_ulogic_vector(7 downto 0);
 signal frame2slave,frame2top: daten2xchange; 
 
 
 signal spi_clk,spi_ss,spi_mosi,spi_miso: std_ulogic_vector(1 to AnzDuts);
 
 type mode_spi is array (1 to AnzDuts) of std_ulogic_vector(1 downto 0);--(string("00"),string("01"),string("10"),string("11"));
 type msb_spi  is array (1 to AnzDuts) of std_ulogic; 
 constant mode_dut: mode_spi:= ("00","10","01","11","01","10","00","11");
 constant msb_dut: msb_spi:= ('0','0','0','0','1','1','1','1');
 
 component top_spi is	
	port(
		clock: in std_ulogic;
		reset: in std_ulogic;
		
		fertig_top:  in std_ulogic;
		frame_2_top: in std_ulogic_vector(7 downto 0);
		
		frame_2_slave: out std_ulogic_vector(7 downto 0);
		DataValid: out std_ulogic);
	
end component;

 component slave_spi is
 	generic(
 		mode: std_ulogic_vector(1 downto 0):= "00";
 		msb: std_ulogic:= '1');
 		
 	port(
 		spi_clk_slave: in std_ulogic;
 		reset: in std_ulogic;
 		
		spi_ss_slave: in std_ulogic;
 		spi_mosi_slave: in std_ulogic;
		spi_miso_slave: out std_ulogic);
 
 end component;	

begin

 clk <= not clk after 10 ns;
 rst <= '1' after 133 ns, '0' after 304 ns;
 
 --frame2slave <= daten(0);
 enable <= '0','1' after 56 ns,'0' after 474 ns,'1' after 612 ns,'0' after 136 us, '1' after 149 us, '0' after 152 us;
 
 
DUT: for i in mode_spi'range generate  
 
 inst: entity module.spi_master_M25P16
 generic map(mode_dut(i),10)
 port map(msb_dut(i),"0110110010",clk,rst,test_valid(i),enable,test_fertig(i),
		  frame2slave(i),frame2top(i),spi_clk(i),spi_ss(i),spi_mosi(i),spi_miso(i));

 interactWithSPI_Master: top_spi
 port map(clk,rst,test_fertig(i),frame2top(i),frame2slave(i),test_valid(i));	-- 
 
 Slavemodell: slave_spi
 generic map(mode_dut(i),msb_dut(i))
 port map(spi_clk(i),rst,spi_ss(i),spi_mosi(i),spi_miso(i));
 
 end generate;

end testing;




Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_spi is
		
	port(
		clock: in std_ulogic;
		reset: in std_ulogic;
		
		fertig_top:  in std_ulogic;
		frame_2_top: in std_ulogic_vector(7 downto 0);
		
		frame_2_slave: out std_ulogic_vector(7 downto 0);
		DataValid: out std_ulogic);
	
end entity;


architecture top_spi_design of top_spi is

 type Datensatz is array (2 downto 0) of std_logic_vector(7 downto 0);
 signal daten: Datensatz:= ("01010110","00011101","10110100");
 
 signal shift: std_ulogic:= '0';
 signal valid_top: std_ulogic;
 
begin

 send: process(clock,reset)
 begin
	if reset = '1' then
		valid_top <= transport '1' after 73 ns;
		shift <= '0';
		
	elsif rising_edge(clock) then
		
		if fertig_top = '1' then
			daten <= (2 => frame_2_top, 1 => daten(2), 0 => daten(1));
			shift <= '1';
			
		elsif shift = '1' then 
			valid_top <= '1';
			shift <= '0';
			
		else 
			valid_top <= '0';
			
		end if;		
	end if;
 end process;
 
 DataValid <= valid_top;
 frame_2_slave <= daten(0);
 
end top_spi_design;
		


Library ieee;
use ieee.std_logic_1164.all;

entity slave_spi is
	generic(
		mode: std_ulogic_vector(1 downto 0):= "00";
		msb: std_ulogic:= '1');
		
	port(
		spi_clk_slave: in std_ulogic;
		reset: in std_ulogic;
		
		spi_ss_slave: in std_ulogic;
		spi_mosi_slave: in std_ulogic;
		spi_miso_slave: out std_ulogic);

end entity slave_spi;	


architecture slave_spi_design of slave_spi is

 signal slaveshiftegister: std_ulogic_vector(7 downto 0):= "00110101";
 
 
begin

modus: if xnor mode generate
	
 rx: process(spi_clk_slave,reset)
 begin
	if reset = '1' then
		slaveshiftegister <= "00110101";
		
	elsif rising_edge(spi_clk_slave) then
	
		if msb = '1' then
			slaveshiftegister <= slaveshiftegister(6 downto 0) & spi_mosi_slave;
			
		else 
			slaveshiftegister <= spi_mosi_slave & slaveshiftegister(7 downto 1);
			
		end if;
	
	end if;
 end process rx;
 
else generate

 rx: process(spi_clk_slave,reset)
 begin
	if reset = '1' then
		slaveshiftegister <= "00110101";
		
	elsif falling_edge(spi_clk_slave) then
	
		if msb = '1' then
			slaveshiftegister <= slaveshiftegister(6 downto 0) & spi_mosi_slave;
			
		else 
			slaveshiftegister <= spi_mosi_slave & slaveshiftegister(7 downto 1);
			
		end if;
	
	end if;
 end process rx;
 
end generate;
 
  spi_miso_slave <=	slaveshiftegister(7) when spi_ss_slave = '0' and msb = '1' else
					slaveshiftegister(0) when spi_ss_slave = '0' and msb = '0' else 'Z';


end architecture; 
