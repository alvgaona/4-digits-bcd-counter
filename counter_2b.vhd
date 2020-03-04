library IEEE;
use IEEE.std_logic_1164.all;

entity counter_2b is
	port(
		clk, rst, enable: in std_logic;
		S: out std_logic_vector(1 downto 0);
		Max: out std_logic
	);
end;

architecture counter of counter_2b is
	component ffd
	port(
		D, clk, enable, rst: in std_logic;
		Q: out std_logic
	);
	end component;
	signal Q: std_logic_vector(1 downto 0);
	signal D: std_logic_vector(1 downto 0);
begin
	D(1) <= Q(0) xor Q(1);
	D(0) <= not Q(0);
	ffd1: ffd port map(clk => clk, rst => rst, enable => enable, D => D(0), Q => Q(0));
	ffd2: ffd port map(clk => clk, rst => rst, enable => enable, D => D(1), Q => Q(1));
	S <= Q;
	Max <= Q(0) and Q(1);
end;

-----------------------------------------------------------------------------
--------------                 TESTBENCH                ---------------------
-----------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity counter_2b_test is
end;

architecture prueba of counter_2b_test is
	component counter_2b
	port(clk, rst, enable: in std_logic;
		 S: out std_logic_vector(1 downto 0)
	);
	end component;
	signal S: std_logic_vector(1 downto 0);
	signal clk, rst: std_logic := '0';
	signal enable: std_logic := '1';
begin
	inst_contador: counter_2b port map(clk, rst, enable, S);
	rst <= '1', '0' after 50 ns;
	clk <= not clk after 10 ns;
	enable <= '0' after 100 ns, '1' after 200 ns;
end;
	