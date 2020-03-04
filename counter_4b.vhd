library IEEE;
use IEEE.std_logic_1164.all;

entity counter_4b is
	port(clk, rst, enable: in std_logic;
		S: out std_logic_vector(3 downto 0);
		Max: out std_logic
	);
end;

architecture counter of counter_4b is
	component contador_2b
	port(
		clk, rst, enable: in std_logic;
		S: out std_logic_vector(1 downto 0);
		Max: out std_logic
	);
	end component;
	signal Q: std_logic_vector(3 downto 0);
	signal enable_02: std_logic := '0';
	signal max1, max2: std_logic;
begin
	counter_01: contador_2b port map(clk => clk, rst => rst, enable => enable, S => Q(1 downto 0), Max => max1);
	enable_02 <= max1 and enable;
	counter_02: contador_2b port map(clk => clk, rst => rst, enable => enable_02, S => Q(3 downto 2), Max => max2);
	S <= Q;
	Max <= max1 and max2;
end;

-------------------------------------------------------------------------------
----------------                 TESTBENCH                ---------------------
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity counter_4b_test is
end;

architecture test01 of counter_4b_test is
	component counter_4b
	port(clk, rst, enable: in std_logic;
		S: out std_logic_vector(3 downto 0)
	);
	end component;
	signal S: std_logic_vector(3 downto 0) := (others => '0');
	signal clk, rst: std_logic := '0';
	signal enable: std_logic := '1';
begin
	inst_counter: counter_4b port map(clk, rst, enable, S);
	rst <= '1', '0' after 50 ns;
	clk <= not clk after 10 ns;
	enable <= '0' after 100 ns, '1' after 200 ns;
end;
	