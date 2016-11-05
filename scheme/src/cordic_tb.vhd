library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;
 
entity cordic_tb is
 
end cordic_tb;

architecture behav of cordic_tb is

	component blockCordic is
		generic(
		   N : integer := 34;
		   M : integer := 6
		);
		port(
		   clk : in STD_LOGIC;
		   rst : in STD_LOGIC;
		   soc : in STD_LOGIC;
		   x0 : in STD_LOGIC_VECTOR(N-3 downto 0);
		   y0 : in STD_LOGIC_VECTOR(N-3 downto 0);
		   eoc : out STD_LOGIC;
		   valid : out STD_LOGIC;
		   rho : out STD_LOGIC_VECTOR(N-3 downto 0);
		   zn : out STD_LOGIC_VECTOR(N-3 downto 0)
		);
	end component;
	
	----------------------------------------------------------------------------
	CONSTANT N       :  INTEGER  := 32;      -- Iputs Width
	CONSTANT MckPer  :  TIME     := 100 ns;  -- Master Clk period
	CONSTANT TestLen :  INTEGER  := 27;      -- No. of Count (MckPer/2) for test
	
	file file_TEST 		:	text;
	
	-- input signals
	signal	clk	:	STD_LOGIC:='0';
	signal	rst	:	STD_LOGIC:='0';
	signal	soc	:	STD_LOGIC:='0';
	signal	x0	:	STD_LOGIC_VECTOR(N-1 downto 0):=X"00000000";
	signal	y0	:	STD_LOGIC_VECTOR(N-1 downto 0):=X"00000000";
	
	--output signals
	
	signal	theta	:	STD_LOGIC_VECTOR(N-1 downto 0):=X"00000000";
	signal	rho		:	STD_LOGIC_VECTOR(N-1 downto 0):=X"00000000";
	signal	eoc		:	STD_LOGIC:='0';
	signal	valid	: 	STD_LOGIC:='0';
	signal 	clk_cycle: 	INTEGER;
	signal 	Testing	: 	Boolean := True;
	
begin
	C : blockCordic generic map(N=>34, M=>6)
		port map(clk, rst, soc, x0, y0, eoc, valid, rho, theta);
		
	-- Generates clk
	clk     <= NOT clk AFTER MckPer/2 WHEN Testing ELSE '0';
	
	Test_proc: process
		variable v_ILINE	:	line;
		variable v_OLINE	:	line;
		variable	v_x0	:	std_logic_vector(N-1 downto 0) := (others => '0');
		variable	v_y0	:	std_logic_vector(N-1 downto 0) := (others => '0');
		variable	v_rho	:	std_logic_vector(N-1 downto 0) := (others => '0');
		variable	v_theta	:	std_logic_vector(N-1 downto 0) := (others => '0');
		variable	v_valid	:	std_logic;
		variable	count	:	integer:=0;	 
		variable	h_rho	:	std_logic_vector(15 downto 0) := (others => '0');
		variable	h_theta	:	std_logic_vector(15 downto 0) := (others => '0');
		
		
	begin
		file_open(file_TEST, "test_cordic.txt", read_mode);	  

		rst <= '0';
		wait for 20 ns;
		rst <= '1';
		wait for 20 ns;
		
		while not endfile(file_TEST) loop 
			readline(file_TEST, v_ILINE);
			hread(v_ILINE, v_x0);	--reading first input
			hread(v_ILINE, v_y0);	--read second input
			hread(v_ILINE, v_theta);	--reading expected theta
			hread(v_ILINE, v_rho);	--reading expected rho
			read(v_ILINE, v_valid);	--reading valid bit
			
			x0 <= v_x0;
			y0 <= v_y0;
			
			wait for 10 ns;
			soc <= '1' after 0 ns, '0' after 10 ns;
			wait for 20 ns;
			 
			while eoc = '0' loop
				wait for 50 ns;
			end loop;
			
			write(v_OLINE, "rho ");
			hwrite(v_OLINE, rho);
			write(v_OLINE, " ");
			hwrite(v_OLINE, v_rho);
			write(v_OLINE, "  theta");
			write(v_OLINE, " ");
			hwrite(v_OLINE, theta);	   
			write(v_OLINE, " ");
			hwrite(v_OLINE, v_theta);
			write(v_OLINE, "  valid bit ");
			write(v_OLINE, valid);
			writeline(OUTPUT, v_OLINE);
			
			h_rho := rho(N-1 downto 16);
			h_theta := theta(N-1 downto 16);
			
			assert valid = v_valid
				report "Error on valid bit"
				severity ERROR;	  
				
			if v_valid = '1' then 
				assert h_rho = v_rho(N-1 downto 16)
					report "Error on rho"
					severity ERROR;
				
				assert h_theta  = v_theta(N-1 downto 16)
					report "Error on theta"
					severity ERROR;
			end if;
		end loop;
		
		file_close(file_TEST);
		write(v_OLINE,"Fine del test");	
		writeline(OUTPUT,v_OLINE);
		wait;
	end process;
end behav;