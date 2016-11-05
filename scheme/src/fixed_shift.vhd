LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY fixed_shift IS

	GENERIC (	N : INTEGER:=4;
				K : INTEGER:=1);
	PORT(	a	: in std_logic_VECTOR (N-1 downto 0);
			s	: in std_logic;
			b	: out std_logic_VECTOR (N-1 downto 0)
		);
		
END fixed_shift;

ARCHITECTURE behav OF fixed_shift IS

BEGIN
	SHIFT:PROCESS (a, s)
	BEGIN	
		if(s='1') then
			FOR i IN 0 TO N-K-1 LOOP
					b(i) <= a(i+K);
				
			end loop;
			for i in N-K to N-1 loop
				b(i)<=a(N-1);
			end loop;
		ELSE 
			FOR i IN 0 TO N-1 LOOP
				b(i)<=a(i);	
			end loop;
		END IF;
	END PROCESS	;
		
END behav;