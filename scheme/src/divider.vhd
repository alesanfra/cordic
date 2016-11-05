library IEEE;
--library SYNOPSYS;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_SIGNED.all;

entity divider is
	  generic (N:integer:=34);
	  port(	   
		  x_n				: in STD_LOGIC_VECTOR(N-1 downto 0);
		  rho 				: out STD_LOGIC_VECTOR(N-2 downto 0)
	  );
end divider;


architecture bhv of divider is

--counter signals
constant A_n_inverted : signed(N-3 downto 0) := X"009B74ED"; -- costante giusta! 

begin  
	--wait for 1 ns;
	process(x_n)
	variable x_signed: signed(N-3 downto 0);
	variable division : std_logic_vector(2*N-5 downto 0);
	begin
		x_signed := conv_signed(conv_integer(x_n(N-1 downto 2)), N-2); 
		division (2*N-5 downto 0) := x_signed * A_n_inverted;	   
		rho(N-2 downto 0) <= division(2*N-14 downto 22);	
	end process;
end bhv;