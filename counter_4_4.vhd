library IEEE;
use IEEE.std_logic_1164.all;

entity counter_4_4 is
	port(
		clk, rst, enable: in std_logic;
		Sal: out std_logic_vector(15 downto 0)
	);
end;

architecture cont_arq of counter_4_4 is
	component bcd_counter
	port(
		clk, rst, enable: in std_logic;
		S: out std_logic_vector(3 downto 0);
		Max: out std_logic
	);
	end component;
	
	signal Q: std_logic_vector(15 downto 0);
	signal enb: std_logic_vector(4 downto 0);
	signal maximos: std_logic_vector(4 downto 0);
	
begin
	enb(0) <= enable;
	maximos(0) <= '1';
	counters: for i in 0 to 3 generate
		enb(i+1) <= enb(i) and maximos(i);
		cont_inst: bcd_counter port map(	
			clk => clk,
			rst => rst,
			S => Q((4*i)+3 downto i*4),
			enable => enb(i+1),
			Max => maximos(i+1)
		);
	end generate;
	Sal <= Q;
end;

-----------------------------------------------------------------------------
--------------                 TESTBENCH                ---------------------
-----------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity test_4x4 is
end;

architecture prueba1 of test_4x4 is
	component counter_4_4
	port(
		clk, rst, enable: in std_logic;
		Sal: out std_logic_vector(15 downto 0)
	);
	end component;
	signal S: std_logic_vector(15 downto 0);
	signal clk, rst: std_logic := '0';
	signal enable: std_logic := '1';
begin
	inst_contador: counter_4_4 port map(clk, rst, enable, S);
	rst <= '1', '0' after 50 ns;
	clk <= not clk after 10 ns;
	enable <= '0' after 100 ns, '1' after 200 ns;
end;
	