LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY n_register is
   generic (N : INTEGER:=32);
   port( d          : in  std_logic_VECTOR (N-1 downto 0);
         clk        : in  std_logic;
         reset      : in  std_logic;
         q          : out std_logic_VECTOR (N-1 downto 0));
END n_register;

architecture BEHAVIOURAL of n_register is
BEGIN
    DFF:process(clk, reset)
     begin
      IF (reset = '0') THEN			
	for i in 0 to N-1 loop
		  q(i) <= '0';
	end loop;		  
         
       ELSIF (clk'EVENT AND clk='1') THEN
         q <= d;
      END IF;
     END process DFF;
END BEHAVIOURAL;