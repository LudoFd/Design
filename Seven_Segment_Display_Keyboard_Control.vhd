-- This design implements an UART Interface betweeen the Go Board and the PC Keyboard.
-- By Pressing a Button on the PC Keyboard the corresponding ASCII Code is display
-- ont the 2 Seven Segment Display of the Go Board.
-- By connectiong the Go Boad via mini USB Contact on the PC it's recognisedas a COM Port.
-- This Port is then used via Tera Term to communicate with the Go Board.
-- On TERA TERM the UART comunications Settings are defined for the given COM Port 
-- (Baudrate: 115200, Data Bits: 8, Parity: None, Stop Bits: 1, No Flow Control)
-- Pressing a Button on the Keyboard is the transmit via  Tera Term to the Go Board
-- which first displays the corresponding ASCII-COde on it Seven Segment Display and 
-- Secondly transfers Back the received ASCII-COde to Tera Term.
Library ieee;
Library Module;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_2_7_seg_display is
	port(
		i_Clk: in std_logic;
		sw1: in std_logic;	-- reset
		i_UART_RX: in std_logic;	-- from the FTDI Chip on Go Board
		
		o_UART_TX: out std_logic;	-- to the FTDI Chip on GO board
		
		o_Segment1_A: out std_logic;
		o_Segment1_B: out std_logic;
		o_Segment1_C: out std_logic;
		o_Segment1_D: out std_logic;
		o_Segment1_E: out std_logic;
		o_Segment1_F: out std_logic;
		o_Segment1_G: out std_logic;
		
		o_Segment2_A: out std_logic;
		o_Segment2_B: out std_logic;
		o_Segment2_C: out std_logic;
		o_Segment2_D: out std_logic;
		o_Segment2_E: out std_logic;
		o_Segment2_F: out std_logic;
        o_Segment2_G: out std_logic);
		
end uart_2_7_seg_display;


architecture description of uart_2_7_seg_display is

signal Segment1Code,Segment2Code: std_logic_vector(7 downto 0);
signal rx_BinaryCode,tx_BinaryCode: std_logic_vector(7 downto 0);

signal sw1Debounced: std_logic:= '0';

subtype counterRange is natural range 0 to 1733;
signal counter: counterRange:= 0;


begin



-- Converts  a Nibble  Code into the corresponding 
-- seven Segement Display Code
sevenSegmentCode1: process(i_Clk,sw1Debounced)
begin

	if sw1Debounced = '1' then
		Segment1Code <= (others => '1');
		
	elsif rising_edge(i_Clk) then
		
		case rx_BinaryCode(7 downto 4) is
		
			when "0000" =>
				Segment1Code <= X"7E";
			when "0001" =>
				Segment1Code <= X"30"; 
			when "0010" =>
				Segment1Code <= X"6D";
			when "0011" =>
				Segment1Code <= X"79"; 
			when "0100" =>
				Segment1Code <= X"33";
			when "0101" =>
				Segment1Code <= X"5B"; 
			when "0110" =>
				Segment1Code <= X"5F";
			when "0111" =>
				Segment1Code <= X"70";
			when "1000" =>
				Segment1Code <= X"7F";
			when "1001" =>
				Segment1Code <= X"7B"; 
			when "1010" =>
				Segment1Code <= X"77";
			when "1011" =>
				Segment1Code <= X"1F"; 
			when "1100" =>
				Segment1Code <= X"4E";
			when "1101" =>
				Segment1Code <= X"3D"; 
			when "1110" =>
				Segment1Code <= X"4F";
			when "1111" =>
				Segment1Code <= X"47"; 
			when others =>
				null;
		end case;
	end if;
	
end process sevenSegmentCode1;


-- Converts  a Nibble  Code into the corresponding 
-- seven Segement Display Code
sevenSegmentCode2: process(i_Clk,sw1Debounced)
begin

	if sw1Debounced = '1' then
		Segment2Code <= (others => '0');
		
	elsif rising_edge(i_Clk) then
		
		case rx_BinaryCode(3 downto 0) is
		
			when "0000" =>
				Segment2Code <= X"7E";
			when "0001" =>
				Segment2Code <= X"30"; 
			when "0010" =>
				Segment2Code <= X"6D";
			when "0011" =>
				Segment2Code <= X"79"; 
			when "0100" =>
				Segment2Code <= X"33";
			when "0101" =>
				Segment2Code <= X"5B"; 
			when "0110" =>
				Segment2Code <= X"5F";
			when "0111" =>
				Segment2Code <= X"70";
			when "1000" =>
				Segment2Code <= X"7F";
			when "1001" =>
				Segment2Code <= X"7B"; 
			when "1010" =>
				Segment2Code <= X"77";
			when "1011" =>
				Segment2Code <= X"1F"; 
			when "1100" =>
				Segment2Code <= X"4E";
			when "1101" =>
				Segment2Code <= X"3D"; 
			when "1110" =>
				Segment2Code <= X"4F";
			when "1111" =>
				Segment2Code <= X"47"; 
			when others =>
				null;
		end case;
	end if;
	
end process sevenSegmentCode2;

-- This Process is Parallelizing the received Bits from TERA TERM
Parallizing: process(i_Clk)
begin

	if rising_edge(i_Clk) then
		
		if (tx_BinaryCode /= rx_BinaryCode) then
		
			counter <= counter + 1;
		else
			
			counter <= 0;
		end if;
		
		if (counter = counterRange'High) and (tx_BinaryCode /= rx_BinaryCode) then
		
			tx_BinaryCode <= rx_BinaryCode;
		end if;
	end if;

end process;


Debouncing:
entity module.DebounceUnit
generic map(125000)
port map(i_Clk,sw1,sw1Debounced);

-- UART Receiver. It's used to received the ASCII-Code from TERA TERM
UART_RX:
entity module.receiver
	generic map(
		ClkFreq2Bdrate => 217,	
		Nbr_data_bits => 8,
		EnParityCheck => '0',
		parity => open,
		stop_bits => 1)	

	port map(
		i_Clk => i_Clk,
		rx_data => i_UART_RX,
		error => open,
		Nutzframe => rx_BinaryCode);

-- UART Transmitter. It send back the received Character after the corresponding 
-- Byte was Parallelized		
UART_TX:
entity module.transmitter
	generic map(
		ClkFreq2Bdrate => 217,	
		Nbr_data_bits => 8,
		EnParityCheck => '0',
		parity => open,
		stop_bits => 1)	

	port map(
		i_Clk => i_Clk,
		tx_data => o_UART_TX,
		Nutzframe => tx_BinaryCode);
		

o_Segment1_A <= not Segment1Code(6);
o_Segment1_B <= not Segment1Code(5);
o_Segment1_C <= not Segment1Code(4);
o_Segment1_D <= not Segment1Code(3);
o_Segment1_E <= not Segment1Code(2);
o_Segment1_F <= not Segment1Code(1);
o_Segment1_G <= not Segment1Code(0);
								   
o_Segment2_A <= not Segment2Code(6);
o_Segment2_B <= not Segment2Code(5);
o_Segment2_C <= not Segment2Code(4);
o_Segment2_D <= not Segment2Code(3);
o_Segment2_E <= not Segment2Code(2);
o_Segment2_F <= not Segment2Code(1);
o_Segment2_G <= not Segment2Code(0);

end description;