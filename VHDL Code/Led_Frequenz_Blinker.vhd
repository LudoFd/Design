-- This Module makes the 4 Leds on the Go Board lighting at different frequencies
-- when the corresponding switch is pressed.
-- Switchtes sw1 --> Led1,sw2 --> Led2,sw3 --> Led3,sw4 --> Led4.
-- Pressing a switch 1x implies the corresponding Led to flash at 1 Hz
-- By a second touch  at 2 Hz, a third touch at 5Hz and a 4 touch at 10 Hz.
-- Pressing one Switch for more than 500 ms reset that Led which is no more flashing.
-- Pressing sw1 and sw2 for more than 500 ms  is reseting all Leds which will no more flash.
Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Led_blink_control is
	port(
		i_Clk: in std_logic;
		sw1: in std_logic;
		sw2: in std_logic;
		sw3: in std_logic;
		sw4: in std_logic;
		
		d1: out std_logic;
		d2: out std_logic;
		d3: out std_logic;
		d4: out std_logic);
	
end entity;


architecture description of Led_blink_control is

signal led1,led2,led3,led4: std_logic:= '0';

signal  r_sw1_delayed,r_sw2_delayed,r_sw3_delayed,r_sw4_delayed: std_logic:= '0';

signal  r_sw1_dbounce,r_sw2_dbounce,
		r_sw3_dbounce,r_sw4_dbounce: std_logic:= '0';
		
signal  r_sw1_sync,r_sw2_sync,
		r_sw3_sync,r_sw4_sync: std_logic_vector(1 downto 0):="00";
		
constant c_dbounce_max: integer:= 125000;	-- 5ms = 125.000 clock cycle
signal r_sw1_dbounce_counter: integer range 0 to c_dbounce_max:=0;
signal r_sw2_dbounce_counter: integer range 0 to c_dbounce_max:=0;
signal r_sw3_dbounce_counter: integer range 0 to c_dbounce_max:=0;
signal r_sw4_dbounce_counter: integer range 0 to c_dbounce_max:=0;


constant reset_max: integer:= 12500000;	-- 500 ms = 12.500.000 clock cycles
constant sys_rst_puffer: integer:=  6250000; -- 250 ms =  6.250.000 clock cycles
signal r_sw1_reset_counter:   integer range 0 to reset_max:=0;
signal r_sw2_reset_counter:   integer range 0 to reset_max:=0;
signal r_sw3_reset_counter:   integer range 0 to reset_max:=0;
signal r_sw4_reset_counter:   integer range 0 to reset_max:=0;
signal sw1_sys_reset_counter: integer range 0 to sys_rst_puffer:= sys_rst_puffer;
signal sw2_sys_reset_counter: integer range 0 to sys_rst_puffer:= sys_rst_puffer;

type state is (led1_passive,led2_passive,led3_passive,led4_passive,
			   led1_active,led2_active,led3_active,led4_active);
			   
signal led1_state: state:= led1_passive;
signal led2_state: state:= led2_passive; 
signal led3_state: state:= led3_passive;
signal led4_state: state:= led4_passive; 


signal sys_reset: std_logic:='0';
signal sw1_reset: std_logic:='0';
signal sw2_reset: std_logic:='0';
signal sw3_reset: std_logic:='0';
signal sw4_reset: std_logic:='0';
signal pre_sys_reset: std_logic:= '0';


constant for_1_hz:   integer:= 25000000;	-- 1hz   =>     1s = 25.000.000 clock cycles
constant for_2_hz:   integer:= 12500000;	-- 2hz   =>   0.5s = 12.500.000 clock cycles
constant for_5_hz:   integer:=  5000000;	-- 5hz   =>   0.2s =  5.000.000 clock cycles
constant for_10_hz:  integer:=  2500000;	-- 10hz  =>   0.1s =  2.500.000 clock cycles
--constant for_20_hz:  integer:= 1250000;	-- 20hz  =>  0.05s =  1.250.000 clock cycles
--constant for_50_hz:  integer:=  500000;	-- 50hz  =>  0.02s =    500.000 clock cycles
--constant for_100_hz: integer:=  250000;	-- 100hz =>  0.01s =    250.000 clock cycles

signal sw1_blink_counter_max: integer:= for_1_hz;
signal sw2_blink_counter_max: integer:= for_1_hz;
signal sw3_blink_counter_max: integer:= for_1_hz;
signal sw4_blink_counter_max: integer:= for_1_hz;

signal sw1_blink_counter:   integer range 0 to for_1_hz;
signal sw2_blink_counter:   integer range 0 to for_1_hz;
signal sw3_blink_counter:   integer range 0 to for_1_hz;
signal sw4_blink_counter:   integer range 0 to for_1_hz;
						  
--signal sw1_2hz_counter:   integer range 0 to for_2_hz;
--signal sw2_2hz_counter:   integer range 0 to for_2_hz;
--signal sw3_2hz_counter:   integer range 0 to for_2_hz;
--signal sw4_2hz_counter:   integer range 0 to for_2_hz;
--						  
--signal sw1_5hz_counter:   integer range 0 to for_5_hz;
--signal sw2_5hz_counter:   integer range 0 to for_5_hz;
--signal sw3_5hz_counter:   integer range 0 to for_5_hz;
--signal sw4_5hz_counter:   integer range 0 to for_5_hz;
--
--signal sw1_10hz_counter:  integer range 0 to for_10_hz;
--signal sw2_10hz_counter:  integer range 0 to for_10_hz;
--signal sw3_10hz_counter:  integer range 0 to for_10_hz;
--signal sw4_10hz_counter:  integer range 0 to for_10_hz;

--signal sw1_20hz_counter:  integer range 0 to for_20_hz;
--signal sw2_20hz_counter:  integer range 0 to for_20_hz;
--signal sw3_20hz_counter:  integer range 0 to for_20_hz;
--signal sw4_20hz_counter:  integer range 0 to for_20_hz;
--						  
--signal sw1_50hz_counter:  integer range 0 to for_50_hz;
--signal sw2_50hz_counter:  integer range 0 to for_50_hz;
--signal sw3_50hz_counter:  integer range 0 to for_50_hz;
--signal sw4_50hz_counter:  integer range 0 to for_50_hz;
--
--signal sw1_100hz_counter: integer range 0 to for_100_hz;
--signal sw2_100hz_counter: integer range 0 to for_100_hz;
--signal sw3_100hz_counter: integer range 0 to for_100_hz;
--signal sw4_100hz_counter: integer range 0 to for_100_hz;

signal sw1_shift,sw2_shift,sw3_shift,sw4_shift: std_logic_vector(2 downto 0):="000";

begin


Debounce: process(i_Clk)
begin

	if rising_edge(i_Clk) then
		-- synchronisation
		r_sw1_sync <= r_sw1_sync(0) & sw1;
		r_sw2_sync <= r_sw2_sync(0) & sw2;
		r_sw3_sync <= r_sw3_sync(0) & sw3;
		r_sw4_sync <= r_sw4_sync(0) & sw4;
	
	
		-- Debounce switches
		if (r_sw1_sync(1) /= r_sw1_dbounce) and (r_sw1_dbounce_counter < c_dbounce_max - 1) then
			r_sw1_dbounce_counter <= r_sw1_dbounce_counter + 1;
		
		elsif r_sw1_dbounce_counter = c_dbounce_max - 1 then
			r_sw1_dbounce <= r_sw1_sync(1);
			r_sw1_dbounce_counter <= 0;
			
		else
			r_sw1_dbounce_counter <= 0;
		end if;
		
		if (r_sw2_sync(1) /= r_sw2_dbounce) and (r_sw2_dbounce_counter < c_dbounce_max - 1) then
			r_sw2_dbounce_counter <= r_sw2_dbounce_counter + 1;
		
		elsif r_sw2_dbounce_counter = c_dbounce_max - 1 then
			r_sw2_dbounce <= r_sw2_sync(1);
			r_sw2_dbounce_counter <= 0;
			
		else
			r_sw2_dbounce_counter <= 0;
		end if;
		
		if (r_sw3_sync(1) /= r_sw3_dbounce) and (r_sw3_dbounce_counter < c_dbounce_max - 1) then
			r_sw3_dbounce_counter <= r_sw3_dbounce_counter + 1;
		
		elsif r_sw3_dbounce_counter = c_dbounce_max - 1 then
			r_sw3_dbounce <= r_sw3_sync(1);
			r_sw3_dbounce_counter <= 0;
			
		else
			r_sw3_dbounce_counter <= 0;
		end if;
		
		if (r_sw4_sync(1) /= r_sw4_dbounce) and (r_sw4_dbounce_counter < c_dbounce_max - 1) then
			r_sw4_dbounce_counter <= r_sw4_dbounce_counter + 1;
		
		elsif r_sw4_dbounce_counter = c_dbounce_max - 1 then
			r_sw4_dbounce <= r_sw4_sync(1);
			r_sw4_dbounce_counter <= 0;
			
		else
			r_sw4_dbounce_counter <= 0;
		end if;
		
		-- Delay for Edge Detection
		r_sw1_delayed <= r_sw1_dbounce;
		r_sw2_delayed <= r_sw2_dbounce;
		r_sw3_delayed <= r_sw3_dbounce;
		r_sw4_delayed <= r_sw4_dbounce;
				
	end if;

end process Debounce;


-- reset Signal
-- each time a valid(debounce) rising transition on switches are detected the process Reset_signal monitors for 500 ms
-- the switches'state. If the switches state doesn't change within this period the corresponding 
-- switch'reset signal is asserted.
Reset_Signals: process(i_Clk)
begin

	if rising_edge(i_Clk) then 
			
		if (r_sw1_dbounce = '1' and r_sw1_delayed = '0') or (r_sw1_reset_counter = reset_max - 1) then	-- reset counter if a rising edge is detected or 
			r_sw1_reset_counter <= 0;																	-- it reached max value, reset_max - 1.
																										-- counter never sums over its max value. It' being reseted
		else
			r_sw1_reset_counter <= r_sw1_reset_counter + 1;
			
		end if;
			
		if (r_sw1_reset_counter = reset_max - 1) and r_sw1_dbounce = '1' then -- sw1 was not released for the last 500 ms since a rising edge was detected
			sw1_reset <= '1';
			
		elsif (r_sw1_dbounce = '0' and r_sw1_delayed = '1') then -- remove reset after the falling edge
			sw1_reset <= '0';
			
		end if;
		
		
		if (r_sw2_dbounce = '1' and r_sw2_delayed = '0') or (r_sw2_reset_counter = reset_max - 1) then	-- reset counter if a rising or falling edge is detected or 
			r_sw2_reset_counter <= 0;																	-- it reached max value, reset_max - 1.
																										-- counter never sums over its max value. It' being reseted
		else
			r_sw2_reset_counter <= r_sw2_reset_counter + 1;
			
		end if;
			
		if (r_sw2_reset_counter = reset_max - 1) and r_sw2_dbounce = '1' then -- sw2 was not released for the last 500 ms since a rising edge was detected
			sw2_reset <= '1';
			
		elsif (r_sw2_dbounce = '0' and r_sw2_delayed = '1') then -- remove reset after the falling edge
			sw2_reset <= '0';
			
		end if;
		
	
		if (r_sw3_dbounce = '1' and r_sw3_delayed = '0') or (r_sw3_reset_counter = reset_max - 1) then	-- reset counter if a rising or falling edge is detected or 
			r_sw3_reset_counter <= 0;																	-- it reached max value, reset_max - 1.
																										-- counter never sums over its max value. It' being reseted
		else
			r_sw3_reset_counter <= r_sw3_reset_counter + 1;
			
		end if;
			
		if (r_sw3_reset_counter = reset_max - 1) and r_sw3_dbounce = '1' then -- sw3 was not released for the last 500 ms since a rising edge was detected
			sw3_reset <= '1';
			
		elsif (r_sw3_dbounce = '0' and r_sw3_delayed = '1') then -- remove reset after the falling edge
			sw3_reset <= '0';
			
		end if;
		
		
		if (r_sw4_dbounce = '1' and r_sw4_delayed = '0') or (r_sw4_reset_counter = reset_max - 1) then	-- reset counter if a rising or falling edge is detected or 
			r_sw4_reset_counter <= 0;																	-- it reached max value, reset_max - 1.
																										-- counter never sums over its max value. It' being reseted
		else
			r_sw4_reset_counter <= r_sw4_reset_counter + 1;
			
		end if;
			
		if (r_sw4_reset_counter = reset_max - 1) and r_sw4_dbounce = '1' then -- sw2 was not released for the last 500 ms since a rising edge was detected
			sw4_reset <= '1';
			
		elsif (r_sw4_dbounce = '0' and r_sw4_delayed = '1') then -- remove reset after the falling edge
			sw4_reset <= '0';
			
		end if;
		
		-- system restart
		if r_sw1_dbounce = '1' and r_sw2_dbounce = '1' then
		
			if ((r_sw2_reset_counter + sys_rst_puffer) > r_sw1_reset_counter)
			or ((r_sw1_reset_counter + sys_rst_puffer) > r_sw2_reset_counter) then

				pre_sys_reset <= '1';
				
			end if;
			
			if pre_sys_reset = '1' and (((r_sw1_reset_counter = reset_max - 1) and r_sw1_dbounce = '1') or 
									   ((r_sw2_reset_counter = reset_max - 1) and r_sw2_dbounce = '1')) then
				sys_reset <= '1';
			
			end if;
			
		else 
			
			pre_sys_reset <= '0';			
			sys_reset <= '0';
								
		end if;
			
	end if;

end process Reset_Signals;

FSM_transition: process(i_Clk)
begin
	if rising_edge(i_Clk) then
	
		if sys_reset = '1' then
			led1_state <= led1_passive;
			led2_state <= led2_passive;
			led3_state <= led3_passive;
			led4_state <= led4_passive;
		
		else
		
			if sw1_reset = '1' then
				led1_state <= led1_passive;
				
			elsif led1_state = led1_passive and (r_sw1_dbounce = '0' and r_sw1_delayed = '1') then -- if no reset occurs and fallinge edge is detected 
				led1_state <= led1_active;
			end if;
				
			if sw2_reset = '1' then
				led2_state <= led2_passive;
				
			elsif led2_state = led2_passive and (r_sw2_dbounce = '0' and r_sw2_delayed = '1') then -- if no reset occurs and fallinge edge is detected 
				led2_state <= led2_active; 
			end if;
				
			if sw3_reset = '1' then
				led3_state <= led3_passive;

			elsif led3_state = led3_passive and (r_sw3_dbounce = '0' and r_sw3_delayed = '1') then -- if no reset occurs and fallinge edge is detected
				led3_state <= led3_active;
			end if;
			
			if sw4_reset = '1' then
				led4_state <= led4_passive;
				
			elsif led4_state = led4_passive and (r_sw4_dbounce = '0' and r_sw4_delayed = '1') then -- if no reset occurs and fallinge edge is detected 
				led4_state <= led4_active;
			end if;
		
		end if;
	end if;

end process FSM_transition;



FSM: process(i_Clk)
begin
	if rising_edge(i_Clk) then
		
		case led1_state is
			
			when led1_passive =>
				sw1_blink_counter  <= 0;
				led1 <= '0';
				sw1_blink_counter_max <= for_1_hz;
				sw1_shift <= (others => '0');
				
			when led1_active =>
			
				if (r_sw1_dbounce = '0' and r_sw1_delayed = '1') or 
				   (sw1_blink_counter = sw1_blink_counter_max - 1) then	-- reset Counter eacht time a falling edge is detected
					sw1_blink_counter <= 0;
					
				else
					sw1_blink_counter <= sw1_blink_counter + 1;
					
				end if;
				
				if r_sw1_dbounce = '0' and r_sw1_delayed = '1' and sw1_shift = "111" then	-- if sw1 was already pressed 3 times, newly pressing sw1 
					sw1_blink_counter_max <= for_1_hz;										-- another time reinitialised the blinking freq to 1hz 
					sw1_shift <= "000";
					
				elsif r_sw1_dbounce = '0' and r_sw1_delayed = '1' and sw1_shift = "000" then -- switch has been pressed 1x  
					sw1_blink_counter_max <= for_2_hz;												
					sw1_shift <= sw1_shift(1 downto 0) & '1';				
									
				elsif r_sw1_dbounce = '0' and r_sw1_delayed = '1' and sw1_shift = "001" then -- switch has benn pressed 2x	
					sw1_blink_counter_max <= for_5_hz;
					sw1_shift <= sw1_shift(1 downto 0) & '1';
					
				elsif r_sw1_dbounce = '0' and r_sw1_delayed = '1' and sw1_shift = "011" then -- switch has benn pressed 3x	
					sw1_blink_counter_max <= for_10_hz;
					sw1_shift <= sw1_shift(1 downto 0) & '1';		
				
				end if;	
				
				if sw1_blink_counter = sw1_blink_counter_max - 1 then
					led1 <= not led1;
									
				end if;
						
			when others =>
				null;
		end case;
		
		
		case led2_state is
			
			when led2_passive =>
				sw2_blink_counter  <= 0;
				led2 <= '0';
				sw2_blink_counter_max <= for_1_hz;
				sw2_shift <= (others => '0');
			
			when led2_active =>
			
				if (r_sw2_dbounce = '0' and r_sw2_delayed = '1') or 
				   (sw2_blink_counter = sw2_blink_counter_max - 1) then	-- reset Counter eacht time a falling edge is detected
					sw2_blink_counter <= 0;
					
				else
					sw2_blink_counter <= sw2_blink_counter + 1;
					
				end if;
				
				if r_sw2_dbounce = '0' and r_sw2_delayed = '1' and sw2_shift = "111" then	-- if sw2 was already pressed 3 times, newly pressing sw1 
					sw2_blink_counter_max <= for_1_hz;										-- another time reinitialised the blinking freq to 1hz 
					sw2_shift <= "000";
					
				elsif r_sw2_dbounce = '0' and r_sw2_delayed = '1' and sw2_shift = "000" then -- switch has been pressed 1x  
					sw2_blink_counter_max <= for_2_hz;												
					sw2_shift <= sw2_shift(1 downto 0) & '1';				
									
				elsif r_sw2_dbounce = '0' and r_sw2_delayed = '1' and sw2_shift = "001" then -- switch has benn pressed 2x	
					sw2_blink_counter_max <= for_5_hz;
					sw2_shift <= sw2_shift(1 downto 0) & '1';
					
				elsif r_sw2_dbounce = '0' and r_sw2_delayed = '1' and sw2_shift = "011" then -- switch has benn pressed 3x	
					sw2_blink_counter_max <= for_10_hz;
					sw2_shift <= sw1_shift(1 downto 0) & '1';		
				
				end if;	
				
				if sw2_blink_counter = sw2_blink_counter_max - 1 then
					led2 <= not led2;
									
				end if;
				
			when others =>
				null;
		end case;
		
		
		case led3_state is
			
			when led3_passive =>
				sw3_blink_counter  <= 0;
				led3 <= '0';
				sw3_blink_counter_max <= for_1_hz;
				sw3_shift <= (others => '0');
				
			when led3_active =>
			
				if (r_sw3_dbounce = '0' and r_sw3_delayed = '1') or 
				   (sw3_blink_counter = sw3_blink_counter_max - 1) then	-- reset Counter eacht time a falling edge is detected
					sw3_blink_counter <= 0;
					
				else
					sw3_blink_counter <= sw3_blink_counter + 1;
					
				end if;
				
				if r_sw3_dbounce = '0' and r_sw3_delayed = '1' and sw3_shift = "111" then	-- if sw3 was already pressed 3 times, newly pressing sw1 
					sw3_blink_counter_max <= for_1_hz;										-- another time reinitialised the blinking freq to 1hz 
					sw3_shift <= "000";
					
				elsif r_sw3_dbounce = '0' and r_sw3_delayed = '1' and sw3_shift = "000" then -- switch has been pressed 1x  
					sw3_blink_counter_max <= for_2_hz;												
					sw3_shift <= sw3_shift(1 downto 0) & '1';				
									
				elsif r_sw3_dbounce = '0' and r_sw3_delayed = '1' and sw3_shift = "001" then -- switch has benn pressed 2x	
					sw3_blink_counter_max <= for_5_hz;
					sw3_shift <= sw3_shift(1 downto 0) & '1';
					
				elsif r_sw3_dbounce = '0' and r_sw3_delayed = '1' and sw3_shift = "011" then -- switch has benn pressed 3x	
					sw3_blink_counter_max <= for_10_hz;
					sw3_shift <= sw3_shift(1 downto 0) & '1';		
				
				end if;	
				
				if sw3_blink_counter = sw3_blink_counter_max - 1 then
					led3 <= not led3;
									
				end if;
				
			when	 others =>
				null;
		end case;
		
		
		case led4_state is
			
			when led4_passive =>
				sw4_blink_counter  <= 0;
				led4 <= '0';
				sw4_blink_counter_max <= for_1_hz;
				sw4_shift <= (others => '0');
				
			when led4_active =>
			
				if (r_sw4_dbounce = '0' and r_sw4_delayed = '1') or 
				   (sw4_blink_counter = sw4_blink_counter_max - 1) then	-- reset Counter eacht time a falling edge is detected
					sw4_blink_counter <= 0;
					
				else
					sw4_blink_counter <= sw4_blink_counter + 1;
					
				end if;
				
				if r_sw4_dbounce = '0' and r_sw4_delayed = '1' and sw4_shift = "111" then	-- if sw1 was already pressed 3 times, newly pressing sw1 
					sw4_blink_counter_max <= for_1_hz;										-- another time reinitialised the blinking freq to 1hz 
					sw4_shift <= "000";
					
				elsif r_sw4_dbounce = '0' and r_sw4_delayed = '1' and sw4_shift = "000" then -- switch has been pressed 1x  
					sw4_blink_counter_max <= for_2_hz;												
					sw4_shift <= sw4_shift(1 downto 0) & '1';				
									
				elsif r_sw4_dbounce = '0' and r_sw4_delayed = '1' and sw4_shift = "001" then -- switch has benn pressed 2x	
					sw4_blink_counter_max <= for_5_hz;
					sw4_shift <= sw4_shift(1 downto 0) & '1';
					
				elsif r_sw4_dbounce = '0' and r_sw4_delayed = '1' and sw4_shift = "011" then -- switch has benn pressed 3x	
					sw4_blink_counter_max <= for_10_hz;
					sw4_shift <= sw4_shift(1 downto 0) & '1';		
				
				end if;	
				
				if sw4_blink_counter = sw4_blink_counter_max - 1 then
					led4 <= not led4;
									
				end if;
			    	
			when others =>
				null;
		end case;
		
	end if;
end process FSM;

d1 <= led1;
d2 <= led2;
d3 <= led3;
d4 <= led4;

end architecture;







--pragma translate_off
Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity test is
end entity test;

architecture sim of test is

	signal  sw_1,sw_2,sw_3,sw_4,
			led_1,led_2,led_3,led_4: std_logic;
			
	signal clock: std_logic:= '0';
	
	component Led_blink_control
		port(
			i_Clk: in std_logic;
			sw1: in std_logic;
			sw2: in std_logic;
			sw3: in std_logic;
			sw4: in std_logic;
			
			d1: out std_logic;
			d2: out std_logic;
			d3: out std_logic;
	        d4: out std_logic);
			
	end component Led_blink_control;

begin

led: Led_blink_control port map (
		sw1 => sw_1,sw2 => sw_2,
		sw3 => sw_3,sw4 => sw_4,
		d1 => led_1,d2 => led_2,
		d3 => led_3,d4 => led_4,
		i_Clk => clock); 

clock <= not clock after 20 ns;

sw_1 <= '0','1' after 614 ns,'0' after 823 ns,'1' after 2.351 us,'0' after 2.777 us,'1' after 2.942 us,'0' after 4.111 us,'1' after 4.446 us, -- 1
		'0' after 5.05311 ms,'1' after 5.05378 ms,'0' after 5.05420 ms,'1' after 5.05699 ms,'0' after 5.05747 ms,'1' after 5.05806 ms,'0' after 5.05877 ms, -- 0
		'1' after 10.0733 ms,'0' after 10.0734 ms,'1' after 10.0736 ms,'0' after 10.0737 ms,'1' after 10.0738 ms,'0' after 10.0740 ms,'1' after 10.0742 ms, -- 1
		'0' after 15.0796 ms,'1' after 15.0798 ms,'0' after 15.0799 ms,'1' after 15.0803 ms,'0' after 15.0804 ms,'1' after 15.0805 ms,'0' after 15.0807 ms, -- 0
		'1' after 20.0923 ms,'0' after 20.0924 ms,'1' after 20.0926 ms,'0' after 20.0927 ms,'1' after 20.0928 ms,'0' after 20.0940 ms,'1' after 20.0942 ms, -- 1
		'0' after 25.0998 ms,'1' after 25.0999 ms,'0' after 25.1005 ms,'1' after 25.1008 ms,'0' after 25.1011 ms,'1' after 25.1013 ms,'0' after 25.1014 ms, -- 0
		-- reset sw1
		'1' after 31.1071 ms,'0' after 31.1075 ms,'1' after 31.1076 ms,'0' after 31.1077 ms,'1' after 31.1081 ms, -- 1 for reset
		'0' after 610.723 ms,'1' after 610.724 ms,'0' after 610.727 ms,'1' after 610.729 ms,'0' after 610.730 ms, -- 0
		'1' after 618.111 ms,'0' after 618.237 ms,'1' after 618.289 ms,'0' after 618.296 ms,'1' after 618.458 ms,'0' after 618.770 ms,'1' after 618.771 ms, -- 1
		'0' after 625.000 ms,'1' after 625.194 ms,'0' after 625.198 ms,'1' after 625.444 ms,'0' after 625.882 ms,'1' after 626.318 ms,'0' after 626.754 ms, -- 0
		'1' after 640.508 ms,'0' after 640.527 ms,'1' after 640.578 ms,'0' after 641.006 ms,'1' after 641.449 ms,'0' after 641.933 ms,'1' after 642.005 ms, -- 1
		'0' after 647.123 ms,'1' after 647.739 ms,'0' after 647.758 ms,'1' after 647.796 ms,'0' after 647.935 ms,'1' after 648.353 ms,'0' after 648.545 ms, -- 0
		-- sys restart
		'1' after 671.358  ms,'0' after 671.360  ms,'1' after 671.361  ms,'0' after 671.733  ms,'1' after 671.752  ms, -- 1
		'0' after 1.35829 sec,'1' after 1.35850 sec,'0' after 1.35855 sec,'1' after 1.36211 sec,'0' after 1.36403 sec, -- 0
		'1' after 1.37108 sec,'0' after 1.37109 sec,'1' after 1.37115 sec,'0' after 1.37482 sec,'1' after 1.37491 sec,'0' after 1.37608 sec,'1' after 1.37633 sec, -- 1
		'0' after 1.37694 sec,'1' after 1.37747 sec,'0' after 1.37762 sec,'1' after 1.37767 sec,'0' after 1.37781 sec,'1' after 1.37799 sec,'0' after 1.38147 sec; -- 0  

sw_2 <= '0','1' after 277 ms,'0' after  277036 us,'1' after  277075 us,'0' after  277091 us,'1' after  277094 us,'0' after  277107 us,'1' after  277153 us, -- 1
        '0' after  284305 us,'1' after  284335 us,'0' after  284339 us,'1' after  284377 us,'0' after  284380 us,'1' after  284388 us,'0' after  284402 us, -- 0
        '1' after  290408 us,'0' after  290422 us,'1' after  291434 us,'0' after  293448 us,'1' after  293464 us,'0' after  295487 us,'1' after  295561 us, -- 1
        '0' after  302569 us,'1' after  302602 us,'0' after  304648 us,'1' after  307661 us,'0' after  309701 us,'1' after  310788 us,'0' after  311533 us, -- 0
        '1' after  317944 us,'0' after  317956 us,'1' after  317961 us,'0' after  320477 us,'1' after  321993 us,'0' after  322713 us,'1' after  323271 us, -- 1
        '0' after  329083 us,'1' after  329202 us,'0' after  329241 us,'1' after  331196 us,'0' after  333008 us,'1' after  334351 us,'0' after  335666 us, -- 0
		-- reset sw2
		'1' after 350.007 ms,'0' after 350.215 ms,'1' after 352.876 ms,'0' after 353.057 ms,'1' after 353.681 ms, -- 1 for reset
		'0' after 360.423 ms,'1' after 360.824 ms,'0' after 362.327 ms,'1' after 365.209 ms,'0' after 365.730 ms, -- 0
		'1' after 371.111 ms,'0' after 371.237 ms,'1' after 371.589 ms,'0' after 371.996 ms,'1' after 374.458 ms,'0' after 375.770 ms,'1' after 376.901 ms, -- 1
		'0' after 385.000 ms,'1' after 385.194 ms,'0' after 385.198 ms,'1' after 385.444 ms,'0' after 387.882 ms,'1' after 388.318 ms,'0' after 390.754 ms, -- 0
		'1' after 397.508 ms,'0' after 398.527 ms,'1' after 398.578 ms,'0' after 399.006 ms,'1' after 399.449 ms,'0' after 401.933 ms,'1' after 403.005 ms, -- 1
		'0' after 410.123 ms,'1' after 410.739 ms,'0' after 410.758 ms,'1' after 412.796 ms,'0' after 412.935 ms,'1' after 414.353 ms,'0' after 415.545 ms, -- 0
		---- sys restart
		'1' after 911.358  ms,'0' after 911.360  ms,'1' after 911.361  ms,'0' after 911.733  ms,'1' after 911.752  ms, -- 1
		'0' after 1.25829 sec,'1' after 1.25850 sec,'0' after 1.25855 sec,'1' after 1.26211 sec,'0' after 1.26403 sec, -- 0
		'1' after 1.37108 sec,'0' after 1.37109 sec,'1' after 1.37115 sec,'0' after 1.37482 sec,'1' after 1.37491 sec,'0' after 1.37608 sec,'1' after 1.37633 sec, -- 1
		'0' after 1.37694 sec,'1' after 1.37747 sec,'0' after 1.37762 sec,'1' after 1.37767 sec,'0' after 1.37781 sec,'1' after 1.37799 sec,'0' after 1.38147 sec; -- 0 


sw_3 <= '0','1' after 414 ns,'0' after 583 ns,'1' after 1.512 us,'0' after 2.707 us,'1' after 2.942 us,'0' after 3.361 us,'1' after 4.946 us, -- 1
        '0' after 6.05371 ms,'1' after 6.05378 ms,'0' after 6.05426 ms,'1' after 6.05692 ms,'0' after 6.05747 ms,'1' after 6.05846 ms,'0' after 6.05877 ms, -- 0
        '1' after 11.0733 ms,'0' after 11.0734 ms,'1' after 11.0736 ms,'0' after 11.0737 ms,'1' after 11.0738 ms,'0' after 11.0740 ms,'1' after 11.0742 ms, -- 1
        '0' after 18.0796 ms,'1' after 18.0798 ms,'0' after 18.0799 ms,'1' after 18.0803 ms,'0' after 18.0804 ms,'1' after 18.0805 ms,'0' after 18.0807 ms, -- 0
        '1' after 26.0923 ms,'0' after 26.0924 ms,'1' after 26.0926 ms,'0' after 26.0927 ms,'1' after 26.0928 ms,'0' after 26.0940 ms,'1' after 26.0942 ms, -- 1
        '0' after 32.0998 ms,'1' after 32.0999 ms,'0' after 32.1005 ms,'1' after 32.1008 ms,'0' after 32.1011 ms,'1' after 32.1013 ms,'0' after 32.1014 ms, -- 0
		-- reset sw3
		'1' after 38.1071 ms,'0' after 38.1075 ms,'1' after 38.1076 ms,'0' after 38.1077 ms,'1' after 38.1081 ms, -- 1 for reset
		'0' after 710.723 ms,'1' after 710.724 ms,'0' after 710.727 ms,'1' after 710.729 ms,'0' after 710.730 ms, -- 0
		'1' after 718.111 ms,'0' after 718.237 ms,'1' after 718.289 ms,'0' after 718.296 ms,'1' after 718.458 ms,'0' after 718.770 ms,'1' after 718.771 ms, -- 1
		'0' after 725.000 ms,'1' after 725.194 ms,'0' after 725.198 ms,'1' after 725.444 ms,'0' after 725.882 ms,'1' after 726.318 ms,'0' after 726.754 ms, -- 0
		'1' after 740.508 ms,'0' after 740.527 ms,'1' after 740.578 ms,'0' after 741.006 ms,'1' after 741.449 ms,'0' after 741.933 ms,'1' after 742.005 ms, -- 1
		'0' after 747.123 ms,'1' after 747.739 ms,'0' after 747.758 ms,'1' after 747.796 ms,'0' after 747.935 ms,'1' after 748.353 ms,'0' after 748.545 ms; -- 0


sw_4 <= '0','1' after 956 ns,'0' after 1.223 us,'1' after 1.751 us,'0' after 2.357 us,'1' after 2.802 us,'0' after 3.111 us,'1' after 3.746 us, -- 1
        '0' after 8.05311 ms,'1' after 8.05378 ms,'0' after 8.05420 ms,'1' after 8.05699 ms,'0' after 8.05747 ms,'1' after 8.05806 ms,'0' after 8.05877 ms, -- 0
        '1' after 14.0733 ms,'0' after 14.0734 ms,'1' after 14.0736 ms,'0' after 14.0737 ms,'1' after 14.0738 ms,'0' after 14.0740 ms,'1' after 14.0742 ms, -- 1
        '0' after 20.0796 ms,'1' after 20.0798 ms,'0' after 20.0799 ms,'1' after 20.0803 ms,'0' after 20.0804 ms,'1' after 20.0805 ms,'0' after 20.0807 ms, -- 0
        '1' after 26.0923 ms,'0' after 26.0924 ms,'1' after 26.0926 ms,'0' after 26.0927 ms,'1' after 26.0928 ms,'0' after 26.0940 ms,'1' after 26.0942 ms, -- 1
        '0' after 35.0998 ms,'1' after 35.0999 ms,'0' after 35.1005 ms,'1' after 35.1008 ms,'0' after 35.1011 ms,'1' after 35.1013 ms,'0' after 35.1014 ms, -- 0
		-- reset sw4
		'1' after 55.1007 ms,'0' after 55.1015 ms,'1' after 55.1076 ms,'0' after 55.1077 ms,'1' after 55.1081 ms, -- 1 for reset
		'0' after 580.723 ms,'1' after 580.724 ms,'0' after 580.727 ms,'1' after 580.729 ms,'0' after 580.730 ms, -- 0
		'1' after 588.111 ms,'0' after 588.237 ms,'1' after 588.289 ms,'0' after 588.296 ms,'1' after 588.458 ms,'0' after 588.770 ms,'1' after 588.771 ms, -- 1
		'0' after 595.000 ms,'1' after 595.194 ms,'0' after 595.198 ms,'1' after 595.444 ms,'0' after 595.882 ms,'1' after 596.318 ms,'0' after 596.754 ms, -- 0
		'1' after 601.508 ms,'0' after 601.527 ms,'1' after 601.578 ms,'0' after 602.006 ms,'1' after 602.449 ms,'0' after 602.933 ms,'1' after 603.005 ms, -- 1
		'0' after 609.123 ms,'1' after 609.739 ms,'0' after 609.758 ms,'1' after 609.796 ms,'0' after 609.935 ms,'1' after 610.353 ms,'0' after 610.545 ms; -- 0

end sim;
--pragma translate_on