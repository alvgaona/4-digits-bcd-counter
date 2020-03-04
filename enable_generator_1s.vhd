library IEEE;
use IEEE.std_logic_1164.all;

entity enable_generator_1s is
	port(
		clk: in std_logic;
		enable: out std_logic
	);
end;

architecture gen_arq of enable_generator_1s is
begin
	process(clk)
	variable count: integer := 0;
	begin
		if rising_edge(clk) then
			if (count = 50000000) then
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

entity enable_generator_1s_test is
end;

architecture test01 of enable_generator_1s_test is
	component enable_generator_1s
	port(
		clk: in std_logic;
		enable: out std_logic
	);
	end component;
	signal clk: std_logic := '0';
	signal s: std_logic;
begin
	inst_gen: enable_generator_1s port map(clk => clk, enable => s);
	Período 40 ns <=> frecuencia 25MHz.
	Debería cambiar cada 2 segundos.
	clk <= not clk after 20 ns;
end;	
