-- This Module generate 2 Pulses which length is from the generics determinated.
-- VGA TIming for 640 x 480 @ 60Hz, clock = 21.175 Mhz
-- 	  Line 		 | Horizontal Pixels |		Time[µS]	
--  Whole Area	 |		800			 | 31.777557100298   |  () das sind die richtigen werte, Nandland hat die angepasst
-- Visible Area	 |		640			 | 25.422045680238   |
--  Front Porch	 |      18(16) 		 |(0.63555114200596) | time = nbr pixels / clock frequenz
--  Sync Pulse	 |		92(96)		 | (3.8133068520357) |
--  Back Porch	 |		50(48)		 | (1.9066534260179) | 
-- 	     		 |					 |                   |
--                                                      
-- 	  Line 		 | Vertical Line	 |		Time[mS]	  
--  Whole Area	 |		525			 | 16.683217477656   |
-- Visible Area	 |		480			 | 15.253227408143   | time = (nbr pixels of whole area   / clock frequenz) x nbr Line
--  Front Porch	 |		10			 | 0.31777557100298  |
--  Sync Pulse	 |		2			 | 0.063555114200596 |
--  Back Porch	 |		33			 | 1.0486593843098   |
                                                       
Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Sync_Pulse_Generator is
	generic( 
			active_Hor_length: natural:= 640;
			active_Ver_length: natural:= 480;
			Total_Hor_length: natural:= 800;
			Total_Ver_length: natural:= 525);	
	port(
		i_Clk,sw1: in std_logic;
		
		H_Sync: out std_logic;
		V_Sync: out std_logic);		
end Sync_Pulse_Generator; 

architecture description of Sync_Pulse_Generator is

  constant h_sync_max:	natural:= active_Hor_length - 1; 
  signal h_sync_counter:natural range 0 to Total_Hor_length - 1;	-- column counter
  
  --signal r_hsync,r_vsync: std_logic;

  constant v_sync_max:	natural:= active_Ver_length - 1; 
  signal v_sync_counter:natural range 0 to Total_Ver_length - 1; 	-- row counter
  
begin

  Gen: process(i_Clk,sw1)
  begin
  
  	if sw1 = '1' then
  		h_sync_counter <= 0;
  		v_sync_counter <= 0;
  		
  	elsif rising_edge(i_Clk) then
		-- h_sync_counter
		if h_sync_counter = Total_Hor_length - 1 then
			if v_sync_counter = Total_Ver_length - 1 then 
				v_sync_counter <= 0;
			else
				v_sync_counter <= v_sync_counter + 1;
			end if;
			
			h_sync_counter <= 0;
			
		else
			h_sync_counter <= h_sync_counter + 1;
			
		end if;
		--if h_sync_counter = Total_Hor_length - 1 then
		--	h_sync_counter <= 0;			
		--else
		--	h_sync_counter <= h_sync_counter + 1;
		--end if;
		--
		---- v_sync_counter
		--if (v_sync_counter = Total_Ver_length - 1) and (h_sync_counter = Total_Hor_length - 1) then 
		--	v_sync_counter <= 0;
		--	
		--elsif h_sync_counter = Total_Hor_length - 1 then
		--	v_sync_counter <= v_sync_counter + 1;
		--end if;
  	
  	end if;
  
  end process Gen;
  
  H_Sync <= '0' when sw1 = '1' or (h_sync_counter > h_sync_max) else '1';
  V_Sync <= '0' when sw1 = '1' or (v_sync_counter > v_sync_max) else '1'; 
  

end description;


--pragma translate_off
Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Sync_Pulse_Generator_testbench is

end entity;

architecture test of Sync_Pulse_Generator_testbench is

 signal clock,reset: std_logic:= '0';
 
 signal syncH,syncV: std_logic_vector(3 downto 0);
 
 type konfigs is array(syncH'range,1 to 4) of natural;	
						  --  1	    2    3     4
 constant konfig: konfigs:=((640 , 480, 800 , 525),	-- 3
							(640 , 350, 800 , 449),	-- 2
							(768 , 576, 976 , 597),	-- 1
							(1024, 768, 1264, 817));-- 0

begin

 clock <= not clock after 20 ns;
 reset <= '1' after 233 ns,'0' after 427 ns;

Inst:for i in konfig'range(1) generate
  dut:entity work.Sync_Pulse_Generator
 	 generic map(konfig(i,1),konfig(i,2),konfig(i,3),konfig(i,4))
 	 port map(i_Clk => clock,sw1 => reset,H_Sync => syncH(i),V_Sync => syncV(i));
  end generate;
  
end test;
--pragma translate_on