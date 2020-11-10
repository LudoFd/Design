-- This module determines the actual Position on a monitor based 
-- on Hsync and VSync both supplied by the module Sync Generator.
-- To this it counts the nbr of columns and rows and make both 
-- values available at its outputs.

Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Sync_2_Row_Column_Position is
	generic(
		Total_Hor_length: natural:= 800;
		Total_Ver_length: natural:= 525);

	port(
		i_Clk:	in std_logic;
		sw1:	in std_logic;	-- reset
		Hsync:	in std_logic;	-- for Column counter
		Vsync:	in std_logic;	-- for Row counter
		
		Hsync2RowCol: out std_logic;
		Vsync2RowCol: out std_logic;
		RowPos:	out natural range 0 to Total_Ver_length - 1;
		ColPos: out natural range 0 to Total_Hor_length - 1);
		
end entity Sync_2_Row_Column_Position;



architecture description of Sync_2_Row_Column_Position is

  signal r_Hsync,r_Vsync: std_logic:= '0';
  
  signal row_counter: natural range 0 to Total_Ver_length - 1:= 0;
  signal col_counter: natural range 0 to Total_Hor_length - 1:= 0;
  
  signal FrameStart: std_logic:= '0';	-- VsyncStart

begin


-- register for Edge Detection on Hsync and VSync
Reg: process(i_Clk,sw1)
  begin	
	if sw1 = '1' then
		r_Hsync <= '0';
		r_Vsync <= '0';
	elsif rising_edge(i_Clk) then
		r_Hsync <= Hsync;
		r_Vsync <= Vsync;
	end if;		
  end process ;  

  FrameStart <= not r_Vsync and Vsync; -- rising edge detection
  --VsyncStart <= not r_Vsync and Vsync; -- rising edge detection

  
counter: process(i_Clk,sw1)
  begin
	if sw1 = '1' then
		row_counter <= 0; 
		col_counter <= 0;
  
    elsif rising_edge(i_Clk) then
		
		if FrameStart = '1' then
			col_counter <= 0;
			row_counter <= 0;

		else
		
			if col_counter = Total_Hor_length - 1 then
				col_counter <= 0;			
				if row_counter = Total_Ver_length - 1 then
					row_counter <= 0;
				else
					row_counter <= row_counter + 1;
				end if;			
			else
				col_counter <= col_counter + 1;
			end if;
		end if;
	end if;	
		
	--	if col_counter = Total_Hor_length - 1 then  --if r_Hsync = '0' and Hsync = '1' then
	--		col_counter <= 0;
	--	else
	--		col_counter <= col_counter + 1;
	--	end if;
	--	
	--	if (row_counter = Total_Ver_length - 1) and  then	--if r_Vsync = '0' and VSync = '1' then
	--		row_counter <= 0;
	--	elsif col_counter = Total_Hor_length -1 then
	--		row_counter <= row_counter + 1;
	--	end if;
	--end if;	
  end process counter;
  
  -- synchronisation of Sync to Col & Row counter
  Hsync2RowCol <= r_Hsync;
  Vsync2RowCol <= r_Vsync; 
  
  RowPos <= row_counter;
  ColPos <= col_counter;

end description;




--pragma translate_off
Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Row_Column_Position_testbench is
end entity;

architecture test of Row_Column_Position_testbench is

  signal clk,rst: std_logic:='0';
  
  type Position is array (3 downto 0) of natural;
  signal rowCounter,ColCounter: Position;
  
  signal syncH,syncV: std_logic_vector(3 downto 0);	-- ,syncHout,syncVout
  
 type konfigs is array(syncH'range,1 to 4) of natural;	
 
						  --  1	    2    3     4
 constant konfig: konfigs:=((640 , 480, 800 , 525),	-- 3
							(640 , 350, 800 , 449),	-- 2
							(768 , 576, 976 , 597),	-- 1
							(1024, 768, 1264, 817));-- 0

begin
  
  clk <= not clk after 20 ns;
  rst <= '1' after 533 ns,'0' after 827 ns;


Inst:for i in konfig'range(1) generate

SyncGen:entity work.Sync_Pulse_Generator
	generic map(konfig(i,1),konfig(i,2),konfig(i,3),konfig(i,4))
	port map(i_Clk => clk,sw1 => rst,H_Sync => syncH(i),V_Sync => syncV(i));
  
PosCounter: entity work.Sync_2_Row_Column_Position
	generic map(konfig(i,3),konfig(i,4))
	port map(i_Clk => clk,sw1 => rst,Hsync => syncH(i),Vsync => syncV(i),	-- Hsync2RowCol => syncHout(i),Vsync2RowCol => syncVout(i)
			 RowPos => rowCounter(i),ColPos => ColCounter(i));  -- 
  
  end generate;
  


end test;
--pragma translate_on