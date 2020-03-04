library IEEE;
use IEEE.std_logic_1164.all;

entity counter_and_enable is
	port(
		clk, rst: in std_logic;
		Q: out std_logic_vector(15 downto 0)
	);
end;

architecture counter_and_enable_arq of counter_and_enable is
	component counter_4x4 is
		port(
			clk, rst, enable: in std_logic;
			Sal: out std_logic_vector(15 downto 0)
		);
	end component;
	
	component enable_generator_1s is
		port(
			clk: in std_logic;
			enable: out std_logic
		);
		end component;
		signal enable: std_logic;
		signal o: std_logic_vector(15 downto 0);
begin
	
	inst_gen: enable_generator_1s port map (clk, enable);
	inst_counter_4x4: counter_4x4 port map (clk, rst, enable, o);
	Q <= o;
end;

-----------------------------------------------------------------------------
--------------                 TESTBENCH                ---------------------
-----------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity counter_block_test is
end;

architecture test01 of counter_block_test is
	component counter_and_enable is
	port(
		clk, rst: in std_logic;
		Q: out std_logic_vector(15 downto 0)
	);
	end component;
	signal clk, rst: std_logic := '0';
	signal s: std_logic_vector(15 downto 0);
begin
	inst_cont_gen: counter_and_enable port map(clk => clk, rst => rst, Q => S);
	-- Period 40 ns <=> frequency 25MHz.
	-- Should change every 2000000 nanoseconds.
	clk <= not clk after 20 ns;
	rst <= '1', '0' after 20 ns;
end;	
