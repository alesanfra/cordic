library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_SIGNED.all;

entity n_abs is
	  generic (N:integer:=32);
	  port(	   
		  input 	: in std_logic_vector(N-1 downto 0);
		  output   	: out std_logic_vector(N-1 downto 0)
	  );
end n_abs;


architecture bhv of n_abs is 
begin
	process(input)
	begin
		if (input(N-1) = '0')  then
			output <= input;
		else
			output <= -input;
		end if;
	end process;
end bhv;