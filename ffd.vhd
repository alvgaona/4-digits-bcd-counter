library IEEE;
use IEEE.std_logic_1164.all;

entity ffd is
	port(
		D, clk, enable, rst: in std_logic;
		Q: out std_logic
	);
end;

architecture ffd_arq of ffd is
	begin
		process(clk, rst)
			begin	
				if rst = '1' then
					Q <= '0';
				elsif rising_edge(clk) then
					if enable = '1' then
						Q <= D;
					end if;
				end if;
		end process;
end;

-----------------------------------------------------------------------------
--------------                 TESTBENCH                ---------------------
-----------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ffd_test is
end;

architecture test01 of ffd_test is
	component ffd
	port(
		D, clk, enable, rst: in std_logic;
		Q: out std_logic
	);
	end component;
	signal d, clk, rst: std_logic := '0';
	signal enable: std_logic := '1';
	signal s: std_logic;
begin
	inst_ffd: ffd port map(D => d, clk => clk, rst => rst, enable => enable, Q => s);
	rst <= '1', '0' after 50 ns;
	clk <= not clk after 10 ns;
	enable <= '0' after 100 ns, '1' after 200 ns;
	d <= not d after 25 ns;
end;