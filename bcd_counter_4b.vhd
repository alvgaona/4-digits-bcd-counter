library IEEE;
use IEEE.std_logic_1164.all;

entity bcd_counter is
	port(clk, rst, enable: in std_logic;
		S: out std_logic_vector(3 downto 0);
		Max: out std_logic
	);
end;

architecture ffd_counter of bcd_counter is
	component ffd
	port (
		D, clk, enable, rst: in std_logic;
		Q: out std_logic
	);
	end component;
	signal Q: std_logic_vector(3 downto 0);
	signal D: std_logic_vector(3 downto 0) := (others => '0');
begin
	D(0) <= not Q(0);
	D(1) <= (Q(1) and (not Q(0))) or ((not Q(3)) and (not Q(1)) and Q(0));
	D(2) <= ((not Q(1)) and Q(2)) or (Q(2) and (not Q(0))) or ((not Q(2)) and Q(1) and Q(0));
	D(3) <= (Q(2) and Q(1) and Q(0)) or (Q(3) and (not Q(0)));
	ffd1: ffd port map(clk => clk, rst => rst, enable => enable, D => D(0), Q => Q(0));
	ffd2: ffd port map(clk => clk, rst => rst, enable => enable, D => D(1), Q => Q(1));
	ffd3: ffd port map(clk => clk, rst => rst, enable => enable, D => D(2), Q => Q(2));
	ffd4: ffd port map(clk => clk, rst => rst, enable => enable, D => D(3), Q => Q(3));
	Max <= Q(0) and Q(3);
	S <= Q;
end;
	
	
-----------------------------------------------------------------------------
--------------                 TESTBENCH                ---------------------
-----------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity bcd_counter_4b_test is
end;

architecture test01 of bcd_counter_4b_test is
	component bcd_counter
	port(
		clk, rst, enable: in std_logic;
		S: out std_logic_vector(3 downto 0);
		Max: out std_logic
	);
	end component;
	signal S: std_logic_vector(3 downto 0) := (others => '0');
	signal clk, rst: std_logic := '0';
	signal enable: std_logic := '1';
	signal max: std_logic;
begin
	inst_contador: bcd_counter port map(clk, rst, enable, S, max);
	rst <= '1', '0' after 50 ns;
	clk <= not clk after 10 ns;
	enable <= '0' after 100 ns, '1' after 200 ns;
end;