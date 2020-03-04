library IEEE;
use IEEE.std_logic_1164.all;

entity enable_generator_200Hz is
	port(
		clk: in std_logic;
		enable: out std_logic
	);
end;

architecture enable_generator of enable_generator_200Hz is
begin
	process(clk)
	variable count: integer := 0;
	begin
		if rising_edge(clk) then
		-- Input clock has a frequency of 50 MHz.
		-- In order to scale it down to 200 Hz, we need to count:
		-- (50MHz / 200Hz) = 250000 pulses.
			if (count = 250000) then
				enable <= '1';
				count := 0;
			else
				enable <= '0';
				count := count + 1;
			end if;
		end if;
	end process;
end;


-----------------------------------------------------------------------------
--------------                 TESTBENCH                ---------------------
-----------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity enable_generator_200Hz_test is
end;

architecture test01 of enable_generator_200Hz_test is
	component enable_generator_200Hz
	port(
		clk: in std_logic;
		enable: out std_logic
	);
	end component;
	signal clk: std_logic := '0';
	signal s: std_logic;
begin
	inst_gen: enable_generator_200Hz port map(clk => clk, enable => s);
	clk <= not clk after 20 ns;
end;	
