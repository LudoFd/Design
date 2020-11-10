Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity SevenSegmentDisplay is
	port(
		i_Clk: in std_logic;
		sw1: in std_logic;	-- reset
		binaryCode: in std_logic_vector(3 downto 0);
		
		Segment_A: out std_logic;
		Segment_B: out std_logic;
		Segment_C: out std_logic;
		Segment_D: out std_logic;
		Segment_E: out std_logic;
		Segment_F: out std_logic;
        Segment_G: out std_logic);
		
end SevenSegmentDisplay;


architecture description of SevenSegmentDisplay is

signal SegmentCode: std_logic_vector(7 downto 0):= (others => '0');
signal binaryCodeIn: std_logic_vector(3 downto 0):=(others => '0');


begin

-- Converts  a Nibble  Code into the corresponding 
-- seven Segement Display Code
sevenSegmentCode1: process(i_Clk,sw1)
  begin
  
  	if sw1 = '1' then
  		SegmentCode <= (others => '0');
  		binaryCodeIn <= (others => '0');
  		
  	elsif rising_edge(i_Clk) then
  		
  		if binaryCodeIn /= binaryCode then
  			binaryCodeIn <= binaryCode;
  		end if;
  	
  		case binaryCode is
  		
  			when "0000" =>
  				SegmentCode <= X"7E";
  			when "0001" =>
  				SegmentCode <= X"30"; 
  			when "0010" =>
  				SegmentCode <= X"6D";
  			when "0011" =>
  				SegmentCode <= X"79"; 
  			when "0100" =>
  				SegmentCode <= X"33";
  			when "0101" =>
  				SegmentCode <= X"5B"; 
  			when "0110" =>
  				SegmentCode <= X"5F";
  			when "0111" =>
  				SegmentCode <= X"70";
  			when "1000" =>
  				SegmentCode <= X"7F";
  			when "1001" =>
  				SegmentCode <= X"7B"; 
  			when "1010" =>
  				SegmentCode <= X"77";
  			when "1011" =>
  				SegmentCode <= X"1F"; 
  			when "1100" =>
  				SegmentCode <= X"4E";
  			when "1101" =>
  				SegmentCode <= X"3D"; 
  			when "1110" =>
  				SegmentCode <= X"4F";
  			when "1111" =>
  				SegmentCode <= X"47"; 
  			when others =>
  				null;
  		end case;
  	end if;
  	
    Segment_A <= not segmentCode(6);
    Segment_B <= not segmentCode(5);
    Segment_C <= not segmentCode(4);
    Segment_D <= not segmentCode(3);
    Segment_E <= not segmentCode(2);
    Segment_F <= not segmentCode(1);
    Segment_G <= not segmentCode(0);
    
  end process sevenSegmentCode1;
  
end  description;