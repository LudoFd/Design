Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Debounce is
	generic(
		DebounceTime: natural:= 250000;	-- clock frequenz/time for debouncing
		NbrSignal2Dbounce: natural:= 1);
		
	port(
		i_Clk: in std_logic;
		Signal2Dbounces: in std_logic_vector(NbrSignal2Dbounce - 1 downto 0);
		DbouncedSignals: out std_logic_vector(NbrSignal2Dbounce - 1 downto 0));
end entity Debounce;		

architecture DebounceRTL of Debounce is

	component DebounceUnit
		generic(
			DebounceTime: natural:= 250000);	
			
		port(
			i_Clk: in std_logic;
			Signal2Dbounce: in std_logic;
			DbouncedSignal: out std_logic);
	end component;


begin

	Inst: for j in 0 to NbrSignal2Dbounce - 1 generate
	
		UnitX: DebounceUnit 
				generic map(DebounceTime => DebounceTime)
				port map(i_Clk => i_Clk, Signal2Dbounce => Signal2Dbounces(j), DbouncedSignal => DbouncedSignals(j));
				
	end generate;


end DebounceRTL;



Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DebounceUnit is
	generic(DebounceTime: natural:= 250000);	-- clock frequenz/time for debouncing
		
	port(i_Clk: in std_logic; Signal2Dbounce: in std_logic; DbouncedSignal: out std_logic);
	
end entity DebounceUnit;

architecture DebounceUnitRTL of DebounceUnit is

  -- for Debouncing purpose
  signal r_dbounceCounter: natural range 0 to DebounceTime - 1;
  signal r_dbounced: std_logic:= '0';
  
  begin


  Debouncing:
  -- whenever there is an inconsistency between the debounced saved value the signal and its 
  -- actual value the Debounce counter is launched. If the counter reached its maximal value 
  -- given by the generic DebounceTime, the new value it saved and the counter is freezed until 
  -- the next inconsitency.
  process(i_Clk)
  	
  begin
  	
  	if rising_edge(i_Clk) then
  		
  		if (Signal2Dbounce /= r_dbounced) and (r_dbounceCounter < DebounceTime - 1) then
  			r_dbounceCounter <= r_dbounceCounter + 1;
  		
  		elsif r_dbounceCounter = DebounceTime - 1 then
  			r_dbounced <= Signal2Dbounce;
  			r_dbounceCounter <= 0;
  		else
  			r_dbounceCounter <= 0;
  		end if;
  		
  	end if;
  
  DbouncedSignal <= r_dbounced;
  	
  end process Debouncing;

end DebounceUnitRTL;
