library IEEE;
use IEEE.std_logic_1164.all;

entity mux_4_2 is
	port(
		A, B, C, D: in std_logic_vector(3 downto 0);
		S: in std_logic_vector(1 downto 0);
		Z: out std_logic_vector(3 downto 0)
	);
end;

architecture behaviour of mux_4_2 is
	signal aux: std_logic_vector(3 downto 0);
begin		
	process(A,B,C,D,S)
	begin
		case S is
			when "00" => Z <= A; 
			when "01" => Z <= B; 
			when "10" => Z <= C;
			when "11" => Z <= D;
			when others => Z <= "0000";
		end case;
	end process;
end;

-------------------------------------------------------------------------------
----------------                 TESTBENCH                ---------------------
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux_4_2_test is
end;

architecture test02 of mux_4_2_test is
	component mux_4_2
	port(
		A, B, C, D: in std_logic_vector(3 downto 0);
		S: in std_logic_vector(1 downto 0);
		Z: out std_logic_vector(3 downto 0)
	);
	end component;
	signal A: std_logic_vector(3 downto 0) := b"0001";
	signal B: std_logic_vector(3 downto 0) := b"0010";
	signal C: std_logic_vector(3 downto 0) := b"0100";
	signal D: std_logic_vector(3 downto 0) := b"1000";
	signal Z: std_logic_vector(3 downto 0);
	signal S: std_logic_vector(1 downto 0);
begin
	inst_mux: mux_4_2 port map(A => A, B => B, C => C, D => D, S => S, Z => Z);
	S <= "00", "01" after 20 ns, "10" after 40 ns, "11" after 60 ns;
end;	