library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
   generic (N : integer:=32);
   port( 
   		a		: in  std_logic_vector (N-1 downto 0);
   		s		: out std_logic_vector (N-1 downto 0)
	);   
end half_adder;

architecture behavioural of half_adder is
begin
    sum: process(a)
		variable c:	std_logic;
    begin
      	c := '1';
        for i in 0 to N-1 loop
         	-- calculate bit sum using carry from previous step, then carry out
        	s(i) <= a(i) xor c;
         	c := a(i) and c;
      	end loop;
	end process sum;
end behavioural;