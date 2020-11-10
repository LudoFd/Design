-- This Module generates Test Patterns to be displayed on the VGA Monitor.
-- Based on the actual Position on the Monitor given by the i_Hsync and  
-- i_Vsync inputs, it sets the outputs values for the signal Red, Grn and blu
-- according to the selected Test patterns to be displayed. The selection of a
-- particular pattern depends on the input value selPattern.
--
-- The module Row_Column_Position determines the actual Position on the monitor
-- based on the inputs i_Hsync and i_Vsync.
--
-- Available Patterns:
-- Pattern 0: Disables the Test Pattern Generator
-- Pattern 1: All Red
-- Pattern 2: All Green
-- Pattern 3: All Blue
-- Pattern 4: Checkerboard white/black
-- Pattern 5: Color Bars
-- Pattern 6: White Box with Border (2 pixels)

-- VGA TIming for 640 x 480 @ 60Hz
-- 	  Line 		 | Horizontal Pixels | Vertica Lines |
--  Whole Area	 |		800			 |		525		 |
-- Visible Area	 |		640			 |		480		 |
--  Front Porch	 |      18  		 |		10		 |
--  Sync Pulse	 |		92			 |	     2		 |
--  Back Porch	 |		50			 |		33		 |
-- 	     		 |					 |				 |
--
--

Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Test_Pattern_Generator is
	generic(
		NbrBits4RGB: integer:= 3;
		active_Hor_length: natural:= 640;
	    active_Ver_length: natural:= 480;
		Total_Hor_length: natural:= 8000;
		Total_Ver_length: natural:= 525);
		
	port(
		--i_Clk: in std_logic;
		--sw1: in std_logic;
		selPattern: in std_logic_vector(3 downto 0);	-- From Keyboard over UART
		--i_Hsync: in std_logic;
		--i_Vsync: in std_logic;
		
		RowPos: in natural range 0 to Total_Ver_length - 1;
		ColPos: in natural range 0 to Total_Hor_length - 1;
		
		--o_Hsync: out std_logic;
		--o_Vsync: out std_logic;		
		Red: out std_logic_vector(NbrBits4RGB - 1 downto 0);
		Grn: out std_logic_vector(NbrBits4RGB - 1 downto 0);
		Blu: out std_logic_vector(NbrBits4RGB - 1 downto 0));

end entity;

architecture rtl of Test_Pattern_Generator is

  -- Create a type that contains all Test Patterns.
  -- Patterns have 16 indexes (0 to 15) and can be NbrBits4RGB bits wide
  type t_Patterns is array (0 to 6) of std_logic_vector(NbrBits4RGB-1 downto 0);
  signal Pattern_Red : t_Patterns;
  signal Pattern_Grn : t_Patterns;
  signal Pattern_Blu : t_Patterns;
  
  --signal RowPos: natural range 0 to Total_Ver_length - 1;
  --signal ColPos: natural range 0 to Total_Hor_length - 1; 
  
  constant BarWidth: natural:= active_Hor_length/8;
  signal selBar: natural range 0 to 7;
  
  constant row_length: natural:= active_Ver_length/8;
  constant col_length: natural:= active_Hor_length/10;
  signal row_block: natural range 0 to row_length - 1;
  signal col_block: natural range 0 to col_length - 1;

begin

--  -- determines the actual position on the monitor
--Position: entity work.Row_Column_Position
--	generic map(Total_Hor_length,Total_Ver_length)
--  	port map(i_Clk,sw1,i_Hsync,i_Vsync,RowPos,ColPos);
  
  
  -- Generate Patterns.
  
  -- Pattern 0: Disables the Test Pattern Generator
  Pattern_Red(0) <= (others => '1');	-- when ((ColPos < active_Hor_length) and (RowPos < active_Ver_length)) else (others => '0');
  Pattern_Grn(0) <= (others => '1');	-- when ((ColPos < active_Hor_length) and (RowPos < active_Ver_length)) else (others => '0');
  Pattern_Blu(0) <= (others => '1');	-- when ((ColPos < active_Hor_length) and (RowPos < active_Ver_length)) else (others => '0');
  
  -- Pattern 1: Display Red
  Pattern_Red(1) <= (others => '1')	when ((ColPos < active_Hor_length) and (RowPos < active_Ver_length))
  									else (others => '0'); 
  Pattern_Grn(1) <= (others => '0'); 
  Pattern_Blu(1) <= (others => '0');
  
  -- Pattern 2: Display Green
  Pattern_Red(2) <= (others => '0');
  Pattern_Grn(2) <= (others => '1')	when ((ColPos < active_Hor_length) and (RowPos < active_Ver_length))
  									else (others => '0');  
  
  Pattern_Blu(2) <= (others => '0');
  
  -- Pattern 3: Display Blue
  Pattern_Red(3) <= (others => '0');
  Pattern_Grn(3) <= (others => '0'); 
  Pattern_Blu(3) <= (others => '1')	when ((ColPos < active_Hor_length) and (RowPos < active_Ver_length)) 
  									else (others => '0'); 
  
  -- Pattern 4: Checkerboard white/black
  row_block <=  0  when RowPos < row_length*1  else
				1  when RowPos < row_length*2  else
				2  when RowPos < row_length*3  else
				3  when RowPos < row_length*4  else
				4  when RowPos < row_length*5  else
				5  when RowPos < row_length*6  else
				6  when RowPos < row_length*7  else
				7;	
				
  col_block <=  0  when ColPos < col_length*1 else
                1  when ColPos < col_length*2 else
                2  when ColPos < col_length*3 else
                3  when ColPos < col_length*4 else
                4  when ColPos < col_length*5 else
                5  when ColPos < col_length*6 else
                6  when ColPos < col_length*7 else
                7  when ColPos < col_length*8 else
                8  when ColPos < col_length*9 else
				9 ;	
				
  Pattern_Red(4) <= (others => '0')	when (row_block + col_block) mod 2 = 1  else
					(others => '1');
										 
  Pattern_Grn(4) <= Pattern_Red(4);	-- ColPos + RowPos) mod 2 = 0
  Pattern_Blu(4) <= Pattern_Red(4);
  
  -- Pattern 5: Color Bars
  -- Divides active area into 8 Equal Bars and colors them accordingly
  -- Colors Each According to this Truth Table:
  -- R G B     selBar  	 Ouput Color
  -- 0 0 0       0        Black
  -- 0 0 1       1        Blue
  -- 0 1 0       2        Green
  -- 0 1 1       3        Turquoise
  -- 1 0 0       4        Red
  -- 1 0 1       5        Purple
  -- 1 1 0       6        Yellow
  -- 1 1 1       7        White
  
  selBar <= 0 when ColPos < BarWidth*1 else
  			1 when ColPos < BarWidth*2 else
  			2 when ColPos < BarWidth*3 else
  			3 when ColPos < BarWidth*4 else
  			4 when ColPos < BarWidth*5 else
  			5 when ColPos < BarWidth*6 else
  			6 when ColPos < BarWidth*7 else
  			7;
  
  Pattern_Red(5) <=	(others => '1') when (selBar > 3) else  (others => '0');
  Pattern_Grn(5) <=	(others => '1') when (selBar = 2 or selBar = 3 or selBar = 6 or selBar = 7) 
  					 else (others => '0');
  
  Pattern_Blu(5) <=	(others => '1') when (selBar = 1 or selBar = 3 or selBar = 5 or selBar = 7) 
  					 else (others => '0');
  
  -- Pattern 6: Black With White Border
  -- Creates a black screen with a white border 2 pixels wide around outside.
  Pattern_Red(6) <= (others => '1') when (row_block < 2 or row_block > 5) or 
										 ((col_block < 2 or col_block > 7) and (row_block > 2 or row_block < 5))
									else (others => '0');
  
  Pattern_Grn(6) <= Pattern_Red(6);
  Pattern_Blu(6) <= Pattern_Red(6);
  
  

TestPatternSelectRed:
  with selPattern select
	Red <=	Pattern_Red(0) when "0000", Pattern_Red(1) when "0001", Pattern_Red(2) when "0010", 
    		Pattern_Red(3) when "0011", Pattern_Red(4) when "0100", Pattern_Red(5) when "0101",
			Pattern_Red(6) when "0110", Pattern_Red(0) when others;
			
			 

TestPatternSelectGreen:
  with selPattern select
	Grn <=	Pattern_Grn(0) when "0000", Pattern_Grn(1) when "0001", Pattern_Grn(2) when "0010", 
			Pattern_Grn(3) when "0011", Pattern_Grn(4) when "0100", Pattern_Grn(5) when "0101",
			Pattern_Grn(6) when "0110", Pattern_Grn(0) when others;
 
TestPatternSelectBlue:
  with selPattern select
	Blu <=	Pattern_Blu(0) when "0000", Pattern_Blu(1) when "0001", Pattern_Blu(2) when "0010",
			Pattern_Blu(3) when "0011", Pattern_Blu(4) when "0100", Pattern_Blu(5) when "0101",
			Pattern_Blu(6) when "0110", Pattern_Blu(0) when others;
	
-- Due to the process the outputs Red, Green and Blue are delayed compared to
-- pattern_xx signals

--TestPatternSelect: process(i_Clk,sw1) is
--  begin
--	
--	if sw1 = '1' then
--		Red <= (others => '0');
--		Grn <= (others => '0');
--	    Blu <= (others => '0');
--		
--	elsif rising_edge(i_Clk) then
--	
--		case selPattern is
--		
--			when "0000" =>
--				Red <= Pattern_Red(0);
--			    Grn <= Pattern_Grn(0);
--			    Blu <= Pattern_Blu(0);
--				
--			when "0001" =>
--				Red <= Pattern_Red(1);
--			    Grn <= Pattern_Grn(1); 
--			    Blu <= Pattern_Blu(1); 
--			
--			when "0010" =>
--				Red <= Pattern_Red(2);
--				Grn <= Pattern_Grn(2);
--				Blu <= Pattern_Blu(2);
--			
--			when "0011" =>
--				Red <= Pattern_Red(3);
--				Grn <= Pattern_Grn(3);
--				Blu <= Pattern_Blu(3);
--			
--			when "0100" =>
--				Red <= Pattern_Red(4);
--				Grn <= Pattern_Grn(4);
--				Blu <= Pattern_Blu(4);
--			
--			when "0101" =>
--				Red <= Pattern_Red(5);
--				Grn <= Pattern_Grn(5);
--				Blu <= Pattern_Blu(5);
--			
--			when "0110" =>
--				Red <= Pattern_Red(6);
--				Grn <= Pattern_Grn(6);
--				Blu <= Pattern_Blu(6);
--			
--			when others =>
--				Red <= Pattern_Red(0);
--				Grn <= Pattern_Grn(0);
--				Blu <= Pattern_Blu(0);
--				
--		end case;	  
--  end if;
--end process TestPatternSelect;

end rtl;






--pragma translate_off
Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity patternGenerator_Testbench is

end entity;


architecture testing of patternGenerator_Testbench is

  signal clk,rst: std_logic:='0';
  
  signal syncH,syncV: std_logic_vector(3 downto 0);	-- r_syncH,r_syncV

  type pattern_array is array (3 downto 0) of std_logic_vector(3 downto 0);   
									--	2	  4		  5		6
  signal sel_pattern: pattern_array:= ("0010","0100","0101","0110");
  
  --signal o_Hsync,o_Vsync: std_logic;
  type color_array is array (3 downto 0) of std_logic_vector(2 downto 0);
  signal RedBits,GreenBits,BlueBits: color_array; 
  
  type Position is array (3 downto 0) of natural;
  signal RowPos,ColPos: Position;
  
  type konfigs is array(syncH'range,1 to 4) of natural;	
  
 						  --  1	    2    3     4
  constant konfig: konfigs:=((640 , 480, 800 , 525),	-- 3
							(640 , 350, 800 , 449),	-- 2
							(768 , 576, 976 , 597),	-- 1
							(1024, 768, 1264, 817));-- 0

begin

clk <= not clk after 20 ns;

rst <= '0', '1' after 449 ns, '0' after 687 ns;

sel_pattern <= ("0010","0100","0101","0110"), ("0011","0001","0101","0000") after 20 ms;

Inst:for i in konfig'range(1) generate

SyncGen:entity work.Sync_Pulse_Generator
	generic map(konfig(i,1),konfig(i,2),konfig(i,3),konfig(i,4))
	port map(i_Clk => clk,sw1 => rst,H_Sync => syncH(i),V_Sync => syncV(i));


--RowColPosition:entity work.Sync_2_Row_Column_Position
--	generic map(konfig(i,3),konfig(i,4))
--	port map(clk,rst,syncH(i),syncV(i),RowPos(i),ColPos(i)); 	-- 

		
PattternGen: entity work.Test_Pattern_Generator
	generic map(3,konfig(i,1),konfig(i,2),konfig(i,3),konfig(i,4))
	port map(sel_pattern(i),RowPos(i),ColPos(i),RedBits(i),GreenBits(i),BlueBits(i));	-- clk,rst,syncH(i),syncV(i)
	
  end generate;

end testing;
--pragma translate_on

