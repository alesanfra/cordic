LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY sign is
   generic (N : INTEGER:=32);
   port( a: in  std_logic_VECTOR (N-1 downto 0);
         s: out std_logic);
END sign;

architecture BEHAVIOURAL of sign is
BEGIN
 		s <= a(N-1);
END BEHAVIOURAL;
