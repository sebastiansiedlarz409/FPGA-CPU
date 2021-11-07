library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ram is
generic(
	N: integer := 32;  --how many bits width address is
	M: integer := 8;   --how many bits width one element is
	S: integer := 4096 --ram size * M
);
port(
	SCL: in std_logic; 				--clock
	RST: in std_logic := '1'; 			--reset
	RAM_IN: in std_logic_vector(M-1 DOWNTO 0);
	RAM_OUT: out std_logic_vector(M-1 DOWNTO 0);
	RAM_ADDR: in std_logic_vector(N-1 DOWNTO 0);
	RAM_RW: in std_logic 				--1 means read, 0 means write
);
end entity ram;

architecture Behavioral of ram is

type RAM_ARRAY is array (0 to S) of std_logic_vector(M-1 downto 0); -- 0 to 0x1000-1
signal RAM: RAM_ARRAY := (others=>x"00");

begin

process(SCL)
begin

if rising_edge(SCL) then

	if RAM_RW = '1' then --read
		RAM_OUT <= RAM(to_integer(unsigned(RAM_ADDR)));
	elsif RAM_RW = '0' then --write
		RAM(to_integer(unsigned(RAM_ADDR))) <= RAM_IN;
	end if;

end if;

end process;

end architecture Behavioral;