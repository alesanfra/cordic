library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity starter is	
	 port(
		 soc : in STD_LOGIC;
		 rst : in STD_LOGIC;
		 reset : out STD_LOGIC
	     );
end starter;

architecture bhv of starter is
begin
	process(soc,rst)
	begin
		if (rst = '0') then
			reset <= '0';
		elsif (soc'EVENT and soc='1') then
			reset <= '0' after 0 ns, '1' after 10 ns;
		end if;
	end process;	
end bhv;
