library IEEE;
use IEEE.std_logic_1164.all;

entity inverter is
	generic (N : INTEGER:=32);
  	port(
       x: in 	STD_LOGIC_VECTOR(N-1 downto 0);
       y: out 	STD_LOGIC_VECTOR(N-1 downto 0)
  	);
end inverter;

architecture behavioural of inverter is
component half_adder
  generic(N : INTEGER := 32);
  port (
       a 		: in 	STD_LOGIC_VECTOR(N-1 downto 0);
       s 		: out 	STD_LOGIC_VECTOR(N-1 downto 0)
  );
end component;

-- links "not" to "half_adder" --
signal forward : STD_LOGIC_VECTOR (N-1 downto 0);

begin
	-- NOT --
	gen: FOR i IN N-1 DOWNTO 0 generate
		   	forward(i) <= not(x(i)); 
	end generate;
	
	-- INCREMENT --
	inc : half_adder
	  generic map (N=>N)
	  port map(
	       a => forward( N-1 downto 0 ),
	       s => y( N-1 downto 0 )
	  );
end behavioural;
