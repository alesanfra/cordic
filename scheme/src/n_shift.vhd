LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY n_shift IS
	generic (
		N : integer := 32
		);	
	PORT(	a	: in std_logic_VECTOR (N-1 downto 0);
		s	: in std_logic_VECTOR (4 downto 0);
		b	: out std_logic_VECTOR (N-1 downto 0)
	);
		
END n_shift;

ARCHITECTURE behav OF n_shift IS

	COMPONENT fixed_shift
		GENERIC(N : INTEGER:=4;
			K : INTEGER:=2
		);
		PORT(	a	: in std_logic_VECTOR (N-1 downto 0);
			s	: in std_logic;
			b	: out std_logic_VECTOR (N-1 downto 0)
		);
		
	END COMPONENT;
	
	--constant N	:	INTEGER:=32;
	
	-- internal --
	SIGNAL	x1	: std_logic_VECTOR (N-1 downto 0);
	SIGNAL	x2	: std_logic_VECTOR (N-1 downto 0);
	SIGNAL	x3	: std_logic_VECTOR (N-1 downto 0);
	SIGNAL	x4	: std_logic_VECTOR (N-1 downto 0);
BEGIN
	-- chain of fixed shifter --
	shift5: fixed_shift GENERIC MAP(N=>N,K=>16)
				PORT MAP(a, s(4), x1); 
	shift4: fixed_shift GENERIC MAP(N=>N,K=>8)
				PORT MAP(x1, s(3), x2); 
	shift3: fixed_shift GENERIC MAP(N=>N,K=>4)
				PORT MAP(x2, s(2), x3); 
	shift2: fixed_shift GENERIC MAP(N=>N,K=>2)
				PORT MAP(x3, s(1), x4); 
	shift1: fixed_shift GENERIC MAP(N=>N,K=>1)
				PORT MAP(x4, s(0), b);
						
	
END behav;
		