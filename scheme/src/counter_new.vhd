library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity counter_new is
	  generic (N:integer:=6);
	  port(	   
	  	  clk 				: in STD_LOGIC;
		  reset 			: in STD_LOGIC;
		  count 			: out STD_LOGIC_VECTOR(N-2 downto 0);
		  first_iteration	: out std_logic;  -- attivo basso
		  last_iteration   	: out std_logic
	  );
end counter_new;


architecture bhv of counter_new is

constant start : unsigned(N-2 downto 0) := (others => '0');
constant stop : unsigned(N-2 downto 0) := B"11001";	-- 25
signal count_buf : unsigned(N-2 downto 0);

begin
	process(clk,reset)
	begin
		if (reset = '0') then 
			count_buf <= (others=>'0');
			count <= (others=>'1');	
			first_iteration <= '1';
			last_iteration <= '0';
			
	   	elsif(clk'EVENT AND clk='1') then
	         -- conto fino a stop
	         if(count_buf /= stop) then
	            count_buf <= count_buf + 1;
				last_iteration <= '0';
			 else
				last_iteration <= '1';
	         end if;
			 
			 if(count_buf = start) then
				 first_iteration <= '0';
			 else
				 first_iteration <= '1';
			 end if;
			 
			 -- metto l'uscita
			 count <= std_logic_vector(count_buf);
	   end if;
	end process;
end bhv;