library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity decoder_4_8 is
	port(
		i: in std_logic_vector(3 downto 0); --i(3) = A, i(2) = B, i(1) = C, i(0) = D
		o: out std_logic_vector(7 downto 0)
		-- o(7) = a
		-- o(6) = b
		-- o(5) = c
		-- o(4) = d
		-- o(3) = e
		-- o(2) = f
		-- o(1) = g
		-- o(0) = dp
		);
end;

architecture behaviour of decoder_4_8 is
begin
	o(7)<= (not i(1)) and ((i(2) and (not i(0))) or (i(0) and (not i(2)) and (not i(3))));
	o(6)<= i(2) and (i(1) xor i(0));
	o(5)<= not (i(3) or i(2) or (not i(1)) or i(0));
	o(4) <= ((not i(1)) or (i(2) and i(0))) and (i(1) or (i(2) xor i(0)));
	o(3)<= i(0) or ((i(3) or (not i(1))) and (i(2) or i(1)));
	o(2)<= ((not i(3)) and (not i(2)) and i(0)) or ((not i(2)) and i(1)) or (i(1) and i(0));
	o(1)<= (not (i(3) or i(2) or i(1))) or (i(2) and i(1) and i(0));
	o(0) <= '1';
end;

-----------------------------------------------------------------------------
--------------                 TESTBENCH                ---------------------
-----------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity decoder_4_8_test is
end;

architecture test01 of decoder_4_8_test is
	component decoder_4_8 is
	port(
		I: in std_logic_vector(3 downto 0);
		o: out std_logic_vector(7 downto 0)
	);
	end component;
	signal i: std_logic_vector(3 downto 0);
	signal o: std_logic_vector(7 downto 0);
begin
	inst_dec: decoder_4_8 port map(i, o);
	i <= b"0000", b"0001" after 20 ns, b"0010" after 40 ns, b"0011" after 60 ns,
		b"0100" after 80 ns, b"0101" after 100 ns, b"0110" after 120 ns, b"0111" after 140 ns,
		b"1000" after 160 ns, b"1001" after 180 ns, b"1010" after 200 ns, b"1011" after 220 ns,
		b"1100" after 240 ns, b"1101" after 260 ns, b"1110" after 280 ns, b"1111" after 300 ns;
end;
