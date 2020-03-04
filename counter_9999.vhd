library IEEE;
use IEEE.std_logic_1164.all;

entity counter_4_digits is
	port(
		clk, rst: in std_logic;
		Seg: out std_logic_vector(7 downto 0);
		An: out std_logic_vector(3 downto 0)
	);
	
	attribute loc: string;

	attribute loc of clk: signal is "B8";
	attribute loc of rst:	signal is "B18";
	attribute loc of An:  signal is "F15 C18 H17 F17";
	attribute loc of Seg:	signal is "L18 F18 D17 D16 G14 J17 H14 C17";
	
end;

architecture arq of counter_4_digits is

	component driver
	port(
		A, B, C, D: in std_logic_vector(3 downto 0);
		clk: in std_logic;
		anodes: out std_logic_vector(3 downto 0);
		segments: out std_logic_vector(7 downto 0)
	);
	end component;
	
	component counter_and_enable is
	port(
		clk, rst: in std_logic;
		Q: out std_logic_vector(15 downto 0)
	);
	end component;
	
	signal clock, reset: std_logic;
	signal out_4_4: std_logic_vector(15 downto 0);
	signal out_A, out_B, out_C, out_D: std_logic_vector(3 downto 0);
	signal out_An: std_logic_vector(3 downto 0);
	signal out_seg: std_logic_vector(7 downto 0);
	
begin
	clock <= clk;
	reset <= rst;
	
	inst_cont_en: counter_and_enable port map(clk => clock, rst => reset, Q => out_4_4);
	
	out_A <= out_4_4(3 downto 0);
	out_B <= out_4_4(7 downto 4);
	out_C <= out_4_4(11 downto 8); 
	out_D <= out_4_4(15 downto 12); 
	
	inst_driver: driver port map(
		A => out_A,
		B => out_B,
		C => out_C, 
		D => out_D, 
		clk => clock,
		anodes => out_An,
		segments => out_seg
		);
	
	Seg <= out_seg;
	An <= out_An;	
end;


---------------------------------------------------------------------------
------------                 TESTBENCH                ---------------------
---------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity counter_9999_test is
end;

architecture test01 of counter_9999_test is
	component counter_4_digits is
	port(
		clk, rst: in std_logic;
		Seg: out std_logic_vector(7 downto 0);
		An: out std_logic_vector(3 downto 0)
	);
end component;
	signal clk: std_logic := '0';
	signal rst: std_logic := '1';
	signal s: std_logic_vector(7 downto 0);
	signal a: std_logic_vector(3 downto 0);
begin
	inst_cont_final: counter_4_digits port map(clk => clk, rst => rst, Seg => s, An => a);
	clk <= not clk after 20 ns;
	rst <= '0' after 20 ns;
end;	