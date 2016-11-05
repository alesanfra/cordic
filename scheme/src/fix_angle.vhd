library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_SIGNED.all;

entity fix_angle is
	  generic (N:integer:=32);
	  port(	   
		  x		: in STD_LOGIC;
		  y		: in STD_LOGIC;
		  z		: in STD_LOGIC_VECTOR(N-1 downto 0);
		  reset	: in std_logic;
		  z_fixed : out STD_LOGIC_VECTOR(N-1 downto 0)
	  );
end fix_angle;


architecture bhv of fix_angle is

--counter signals
constant PI : std_logic_vector(N-1 downto 0) := X"03243F6B";

signal	x_n	:	std_logic;
signal	y_n	:	std_logic;

begin
	process(reset,z)
	begin
		if (reset = '0') then	
			x_n <= x;
			y_n <= y;
			z_fixed <= (others => '0');
		
		else
			--if (soc'EVENT and soc = '1') then
				--x_n <= x;
				--y_n <= y; 
			--end if;
			
			if (x_n = '1') then 
		         if(y_n = '0') then
		            z_fixed <= z + PI;
				 else
					z_fixed <= z - PI;
		         end if;
		   	else
				   z_fixed <= -z;
			end if;    
		end if;	
	end process;
end bhv;