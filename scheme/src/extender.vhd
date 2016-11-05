LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY extender is
   generic (N : INTEGER:=34);
   port( i: in  std_logic_vector(N-3 downto 0);
         o: out std_logic_vector(N-1 downto 0));
END extender;

architecture BEHAVIOURAL of extender is
BEGIN
	o(N-1) <= i(N-3);
	o(N-2) <= i(N-3);
	o(N-3 downto 0) <= i(N-3 downto 0);
END BEHAVIOURAL;