LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY n_mux is
   generic (N : INTEGER:=32);
   port( a          : in  std_logic_VECTOR (N-1 downto 0);
   		 b          : in  std_logic_VECTOR (N-1 downto 0);
         s          : in  std_logic;
         y          : out std_logic_VECTOR (N-1 downto 0));
END n_mux;

architecture RTL of n_mux is
BEGIN	
	mux: for i in N-1 downto 0 generate
		y(i) <= (a(i) and not s) or (b(i) and s);
	end generate;
END RTL;