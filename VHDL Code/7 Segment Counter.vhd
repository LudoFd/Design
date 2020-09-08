-- This Module implements an Up Down counter which counts from 0 to F and vice versa
-- By pressing the Switch sw1/sw2 on the Go Board,it counts up/down.
Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity seven_segment_display is
	port(
		sw1: in std_logic;	-- count up
		sw2: in std_logic;	-- count down 
		sw3: in std_logic;	-- reset
		i_Clk: in std_logic;
		

		o_Segment2_A: out std_logic;
		o_Segment2_B: out std_logic;
		o_Segment2_C: out std_logic;
		o_Segment2_D: out std_logic;
		o_Segment2_E: out std_logic;
		o_Segment2_F: out std_logic;
        o_Segment2_G: out std_logic
		);
		
end entity seven_segment_display;


architecture rtl of seven_segment_display is

-- set for 250000 clock cycles = 10 ms
constant c_dbounce_max: integer:= 250000;

signal r_count_sw1: integer range 0 to c_dbounce_max;
signal r_count_sw2: integer range 0 to c_dbounce_max;
signal r_sw1_dbounce: std_logic;  
signal r_sw1_status: std_logic; 

signal r_sw2_dbounce: std_logic;  
signal r_sw2_status: std_logic; 

signal r_sw1_shift: std_logic_vector(1 downto 0); 
signal r_sw2_shift: std_logic_vector(1 downto 0); 

signal fall_sw1: std_logic; 
signal fall_sw2: std_logic; 
--signal rise: std_logic;

-- signal for switch_counter
signal r_switch_count: integer range 0 to 15;
signal fall_sw1_alt: std_logic;
signal fall_sw2_alt: std_logic;

--signals for 7segment display
		
signal binary_count_number: std_logic_vector(3 downto 0);
signal r_hex_number: std_logic_vector(7 downto 0);
 
begin

-- Debouncing of sw1
-- With the debounce module 3 funcntions has to be implemented.
-- 1) Synchronisation of swicht signal
-- 2) debouncing of swicht
-- 3) falling edge detection
-- Once a rising edge on switch sw1 is detected, a counter is started running for 10 ms. 
-- When the counter has reached it end value, the sw1 state is registred as a valid value. 
Eingang: process(i_Clk,sw3)
	begin
	if sw3 = '1' then
		r_count_sw1 <= 0;
		r_count_sw2 <= 0;
		r_sw1_status <= '0';
		r_sw2_status <= '0';
				
		r_sw1_shift <= "00";
		r_sw2_shift <= "00";
		fall_sw1 <= '0';
		fall_sw2 <= '0';
		
	elsif rising_edge(i_Clk) then
		
		-- synchronisation
		r_sw1_shift <= r_sw1_shift(0) & sw1;
		r_sw2_shift <= r_sw2_shift(0) & sw2;
		
		-- Debouncing
		-- sw1 is pressed to increment
		if (r_sw1_shift(1) /= r_sw1_status) and (r_count_sw1 < c_dbounce_max - 1) then
			r_count_sw1 <= r_count_sw1 + 1;
		
		elsif r_count_sw1 = c_dbounce_max - 1 then
			r_sw1_status <= r_sw1_shift(1);
			r_count_sw1 <= 0;
			
		else
			r_count_sw1 <= 0;
		end if;
		
		if (r_sw2_shift(1) /= r_sw2_status) and (r_count_sw2 < c_dbounce_max - 1)  then
			r_count_sw2 <= r_count_sw2 + 1;
			
		elsif r_count_sw2 = c_dbounce_max - 1 then
			r_sw2_status <= r_sw2_shift(1);
			r_count_sw2 <= 0;
			
		else 
			r_count_sw2 <= 0;
		end if;
		
		-- Delay for Edge detection
		r_sw1_dbounce <= r_sw1_status;
		r_sw2_dbounce <= r_sw2_status;
		
		-- Edge detection
		if not r_sw1_status = '1' and r_sw1_dbounce = '1' then
			fall_sw1 <= not fall_sw1;	-- Toggle output whenever a falling edge is detected on sw1
		end if;
		
		if not r_sw2_status = '1' and r_sw2_dbounce = '1' then
			fall_sw2 <= not fall_sw2;	-- Toggle output whenever a falling edge is detected on sw2
		end if;
			
	end if;
end process Eingang;
	

-- counts from 0 to F each time swicth was pressed	
switch_counter: process(i_Clk,sw3)
begin
	if sw3 = '1' then
		r_switch_count <= 0;
		fall_sw1_alt <= '0';
		fall_sw2_alt <= '0';
		
	elsif rising_edge(i_Clk) then
		fall_sw1_alt <= fall_sw1;
		fall_sw2_alt <= fall_sw2;
		
		if fall_sw1_alt /= fall_sw1 then-- Counts up, if sw1 was pressed
			if r_switch_count = 15 then
				r_switch_count <= 0;
			else
				r_switch_count <= r_switch_count + 1;
			end if;
		elsif fall_sw2_alt /= fall_sw2 then	-- Counts down, if sw2 was pressed
			if r_switch_count = 0 then
				r_switch_count <= 15;
			else
				r_switch_count <= r_switch_count - 1;
			end if;
		end if;
	end if;

end process switch_counter;


-- codes binary value into 7 segment code
binary_count_number <= std_logic_vector(to_unsigned(r_switch_count,4));

sevenSegmentCode: process(i_Clk,sw3)
begin

	if sw3 = '1' then
		r_hex_number <= (others => '0');
		
	elsif rising_edge(i_Clk) then
		
		case binary_count_number is
		
			when "0000" =>
				r_hex_number <= X"7E";
			when "0001" =>
				r_hex_number <= X"30"; 
			when "0010" =>
				r_hex_number <= X"6D";
			when "0011" =>
				r_hex_number <= X"79"; 
			when "0100" =>
				r_hex_number <= X"33";
			when "0101" =>
				r_hex_number <= X"5B"; 
			when "0110" =>
				r_hex_number <= X"5F";
			when "0111" =>
				r_hex_number <= X"70";
			when "1000" =>
				r_hex_number <= X"7F";
			when "1001" =>
				r_hex_number <= X"7B"; 
			when "1010" =>
				r_hex_number <= X"77";
			when "1011" =>
				r_hex_number <= X"1F"; 
			when "1100" =>
				r_hex_number <= X"4E";
			when "1101" =>
				r_hex_number <= X"3D"; 
			when "1110" =>
				r_hex_number <= X"4F";
			when "1111" =>
				r_hex_number <= X"47"; 
			when others =>
				null;
		end case;
	end if;
end process sevenSegmentCode;

o_Segment2_A <= not r_hex_number(6);
o_Segment2_B <= not r_hex_number(5);
o_Segment2_C <= not r_hex_number(4);
o_Segment2_D <= not r_hex_number(3);
o_Segment2_E <= not r_hex_number(2);
o_Segment2_F <= not r_hex_number(1);
o_Segment2_G <= not r_hex_number(0);

end rtl;



--pragma translate_off
Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture test of testbench is

	signal sw_1,sw_2,reset: std_logic;
	signal clock: std_logic:= '0'; -- Es muss initialisert ansosnstens funktioniert es nicht
	
	signal	segment_a,segment_b,segment_c,segment_d,
			segment_e,segment_f,segment_g: std_logic;
	
	component seven_segment_display
		port(
			sw1,sw2,sw3,i_Clk:	in std_logic;
					
			--o_Segment1_A: out std_logic;
			--o_Segment1_B: out std_logic;
			--o_Segment1_C: out std_logic;
			--o_Segment1_D: out std_logic;
			--o_Segment1_E: out std_logic;
			--o_Segment1_F: out std_logic;
			--o_Segment1_G: out std_logic;
			o_Segment2_A: out std_logic;
			o_Segment2_B: out std_logic;
			o_Segment2_C: out std_logic;
			o_Segment2_D: out std_logic;
			o_Segment2_E: out std_logic;
			o_Segment2_F: out std_logic;
			o_Segment2_G: out std_logic
			);
	end component;

begin

inst1: seven_segment_display port map	(sw1 => sw_1,i_Clk => clock,sw2 => sw_2,sw3 => reset,
										o_Segment2_A => segment_a,o_Segment2_B => segment_b,
										o_Segment2_C => segment_c,o_Segment2_D => segment_d,
										o_Segment2_E => segment_e,o_Segment2_F => segment_f,
										o_Segment2_G => segment_g);

reset	<= '0','1' after 10 ns,'0' after 20 ns;
clock	<= not clock after 20 ns;
sw_1	<= '0','1' after 330 ns,'0' after 927 ns,'1' after 1.171 us,'0' after 1.942 us,'1' after 2.06 us,'0' after 2.924 us,'1' after 3.603 us,
		   '0' after 4.038 us,'1' after 4.289 us,'0' after 4.829 us,'1' after 5.495 us,'0' after 5.782 us,'1' after 6.781 us,'0' after 7.281 us,'1' after 7.395 us,	-- '1'
		   '0' after 1.230836007 sec,'1' after 1.230837267 sec,'0' after 1.230837624 sec,'1' after 1.230837783 sec,'0' after 1.230838624 sec,'1' after 1.230839045 sec,
		   '0' after 1.230839963 sec,'1' after 1.230840591 sec,'0' after 1.230850817 sec,'1' after 1.230850994 sec,'0' after 1.230951095 sec,'1' after 1.230951569 sec,
		   '0' after 1.230951846 sec, -- '0'
		   '1' after 2.000000876 sec,'0' after 2.432074295 sec,'1' after 2.432076983 sec,'0' after 2.432078200 sec,'1' after 2.432079543 sec,'0' after 2.432081986 sec,
		   '1' after 2.432082627 sec,'0' after 2.432083928 sec,'1' after 2.432084305 sec,'0' after 2.432084814 sec,'1' after 2.432086010 sec,'0' after 2.432089121 sec,
		   '1' after 2.432097523 sec,'0' after 2.432098888 sec,'1' after 2.433101646 sec,	-- '1'
		   '1' after 3.000123765 sec,'0' after 3.001003555 sec,'1' after 3.001102934 sec,'0' after 3.001103742 sec,'1' after 3.001105000 sec,'0' after 3.001105478 sec,
		   '1' after 3.001105903 sec,'0' after 3.001107585 sec,	-- '0'
		   '1' after 3.701120981 sec,'0' after 3.701130177 sec,'1' after 3.701131541 sec,'0' after 3.701131911 sec,'1' after 3.701135662 sec,'0' after 3.701136001 sec,
		   '1' after 3.701136777 sec,	-- '1'
		   '0' after 4.500333074 sec,'1' after 4.500336241 sec,'0' after 4.500336745 sec,'1' after 4.500338100 sec,'0' after 4.500340074 sec,'1' after 4.500347211 sec,
		   '0' after 4.500347600 sec,'1' after 4.500348277 sec,'0' after 4.510666211 sec,	-- 0
		   '1' after 5.783297109 sec,'0' after 5.783297800 sec,'1' after 5.783299589 sec,'0' after 5.783301405 sec,'1' after 5.783302411 sec,'0' after 5.783302862 sec,
		   '1' after 5.783303444 sec,	-- '1'
		   '0' after 6.500199012 sec,'1' after 6.500200711 sec,'0' after 6.500201439 sec,'1' after 6.500202833 sec,'0' after 6.500202995 sec,'1' after 6.500243007 sec,
		   '0' after 6.500246218 sec,'1' after 6.500248000 sec,'0' after 6.500252177 sec,	-- 0
		   '1' after 9.333857110 sec,'0' after 9.333859642 sec,'1' after 9.333859937 sec,'0' after 9.333861531 sec,'0' after 9.333864268 sec,'1' after 9.333873472 sec,
		   '1' after 9.333873922 sec, -- 1
		   '0' after 10.00249701 sec,'1' after 10.00253111 sec,'0' after 10.00255669 sec,'1' after 10.00257099 sec,'0' after 10.00259433 sec,'1' after 10.00261303 sec,
		   '0' after 10.00261819 sec,'1' after 10.00262699 sec,'1' after 10.00263108 sec, -- 0
		   '1' after 10.77243802 sec,'0' after 10.77245539 sec,'1' after 10.77245722 sec,'0' after 10.77246635 sec,'1' after 10.77248891 sec,'0' after 10.77248973 sec,
		   '1' after 10.77249555 sec, -- 1
		   '0' after 10.77249892 sec,'1' after 10.77250177 sec,'0' after 10.77250782 sec,'1' after 10.77250823 sec,'0' after 10.77250944 sec,'1' after 10.77251022 sec,
		   '0' after 10.77255318 sec;
		   
sw_2	<= '0','1' after 7.000000111 sec,'0' after 7.000002976 sec, '1' after 7.000003555 sec,'0' after 7.000005719 sec,'1' after 7.000599648 sec,'0' after 7.000782277 sec,
		   '1' after 7.000793579 sec,	-- 1
		   '0' after 8.500233777 sec,'1' after 8.500233938 sec,'0' after 8.500244122 sec,'1' after 8.500244727 sec,'0' after 8.500246111 sec,'1' after 8.500246655 sec,
		   '0' after 8.500247137 sec,	-- 0
		   '1' after 11.97039902 sec,'0' after 11.97040188 sec,'1' after 11.97040672 sec,'0' after 11.97040909 sec,'1' after 11.97042271 sec,'0' after 11.97042452 sec,
		   '1' after 11.970424881 sec; -- 1
		   
end test;		
--pragma translate_on
