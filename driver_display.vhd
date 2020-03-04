library IEEE;
use IEEE.std_logic_1164.all;

entity driver_display is
	port(
		A, B, C, D: in std_logic_vector(3 downto 0);
		clk: in std_logic;
		anodes: out std_logic_vector(3 downto 0);
		segments: out std_logic_vector(7 downto 0)
	);
end;

architecture display_arq of driver_display is
	component decoder_2_4 is
		port(
			I: in std_logic_vector(1 downto 0);
			a: out std_logic_vector(3 downto 0)
		);
	end component;

	component enable_generator_200Hz is
		port(
			clk: in std_logic;
			enable: out std_logic
		);
	end component;
	
	component decoder_4_8 is
		port(
			I: in std_logic_vector(3 downto 0);
			o: out std_logic_vector(7 downto 0)
		);		
	end component;
		
	component mux_4_1 is
		port(
			A, B, C, D: in std_logic_vector(3 downto 0);
			S: in std_logic_vector(1 downto 0);
			Z: out std_logic_vector(3 downto 0)
		);
	end component;
	
	component counter_2b is
		port(
			clk, rst, enable: in std_logic;
			S: out std_logic_vector(1 downto 0);
			Max: out std_logic
		);
	end component;
		
	signal enable: std_logic;
	signal b_2: std_logic_vector(1 downto 0);
	signal o: std_logic_vector(7 downto 0);
	signal out_an: std_logic_vector(3 downto 0);
	signal out_mux: std_logic_vector(3 downto 0);
	signal reset: std_logic;

begin
	inst_gen: enable_generator_200Hz port map (clk, enable);
	inst_counter_2b: counter_2b port map(clk, '0', enable, b2, open);
	inst_decoder_2_4: decoder_2_4 port map(b2, out_an);
	inst_mux: mux_4_1 port map (A, B, C, D, b2, out_mux);
	inst_decoder_4_8: decoder_4_8 port map(out_mux, o);

	anodes <= Sal_an;
	segments <= Sal;
end;
