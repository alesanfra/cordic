library ieee;
use ieee.std_logic_1164.all;

entity adder is
   generic (N : integer:=32);
   port( a	: in  std_logic_vector (N-1 downto 0);
         b	: in  std_logic_vector (N-1 downto 0);
         s	: out std_logic_vector (N-1 downto 0)
	);   
end adder;

architecture behavioural of adder is
begin
    sum: process(a,b)
		variable c:	std_logic;
    begin
      c:='0';
        for i in 0 to N-1 loop
         	-- calculate bit sum using carry from previous step, then carry out
        	s(i)<= a(i) xor b(i) xor c;
         	c:= (a(i) and b(i)) or (a(i) and c) or (b(i) and c);
      	end loop;
	end process sum;
end behavioural;
