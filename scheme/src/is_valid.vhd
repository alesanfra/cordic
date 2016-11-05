library IEEE;
use IEEE.std_logic_1164.all;

entity is_valid is
	generic (
		N : integer := 34
		);
		
	port (
		x_n 			: IN 	std_logic_vector(N-2 downto 0);
		soc				: IN	std_logic;
		last_iteration 	: IN 	std_logic;
		valid 			: OUT  	std_logic; -- dice se il dato è rappresentabile su N-1 bit, NON se è finita la conversione
		eoc				: OUT	std_logic;
		rho				: OUT	std_logic_vector(N-3 downto 0)
		);
end is_valid;

architecture bhv of is_valid is
begin
	process( soc, x_n, last_iteration )
	begin
		if ( soc = '1' ) then
			valid <= '0';
			eoc <= '0';
		elsif (last_iteration = '1') then
			-- calcolo il valid
			if (x_n(N-2) = x_n(N-3)) then
				valid <= '1';
			end if;
			eoc <= '1';
		end if;
		
		rho <= x_n(N-3 downto 0);
	end process;
end bhv;