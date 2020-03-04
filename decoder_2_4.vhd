library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity decoder_2_4 is
	port(
		i: in std_logic_vector(1 downto 0);
		o: out std_logic_vector(3 downto 0)
	);
end;

architecture behaviour of decoder_2_4 is
begin
	o(3) <= not (i(1) and i(0));
	o(2) <= i(0) or (not i(1));
	o(1) <= (not i(0)) or i(1);
	o(0) <= i(1) or i(0);
end;

-----------------------------------------------------------------------------
--------------                 TESTBENCH                ---------------------
-----------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity decoder_2_4_test is
end;

architecture test01 of decoder_2_4_test is
	component decoder_2_4
	port(
		I: in std_logic_vector(1 downto 0);
		a: out std_logic_vector(3 downto 0)
	);
	end component;
	signal S: std_logic_vector(3 downto 0);
	signal i: std_logic_vector(1 downto 0);
begin
	inst_dec: decoder_2_4 port map(I => i, a => S);
	i <= b"00", b"01" after 20 ns, b"10" after 40 ns, b"11" after 60 ns;
	-- Should display:
	-- 1110
	-- 1101
	-- 1011
	-- 0111
end;	