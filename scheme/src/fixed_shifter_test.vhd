LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY shift_tb IS

END shift_tb;

ARCHITECTURE shift_test OF shift_tb IS

   COMPONENT fixed_shift

   generic (N : INTEGER:=4;
   			K : INTEGER:=1);
   	PORT(	a	: in std_logic_VECTOR (N-1 downto 0);
			s	: in std_logic;
			b	: out std_logic_VECTOR (N-1 downto 0)
		);
		
   --END fixed_shift;	
   end component;

   ----------------------------------------------------------------------------
   CONSTANT N       :  INTEGER  := 4;       -- Bus Width
   CONSTANT MckPer  :  TIME     := 200 ns;  -- Master Clk period
   CONSTANT TestLen :  INTEGER  := 24;      -- No. of Count (MckPer/2) for test


-- I N P U T     S I G N A L S

   SIGNAL   clk  : std_logic := '0';
   SIGNAL   a    : std_logic_VECTOR (N-1 downto 0):="1001";
   SIGNAL   s    : std_logic:='0';

-- O U T P U T     S I G N A L S

   SIGNAL   b : std_logic_VECTOR (N-1 downto 0);

   SIGNAL clk_cycle : INTEGER;
   SIGNAL Testing: Boolean := True;

BEGIN

   I : fixed_shift GENERIC MAP(N=>4, K=>2)
             PORT MAP(a,s,b);

   ----------------------------------------------------------------------------

   -- Generates clk

      clk     <= NOT clk AFTER MckPer/2 WHEN Testing ELSE '0';

   -- Runs simulation for TestLen cycles;

   Test_Proc: PROCESS(clk)
      VARIABLE count: INTEGER:= 0;
   BEGIN	
	   if (clk'event and clk='1') then
     clk_cycle <= (count+1)/2;

     CASE count IS
          WHEN  11  => s <= '1';
		  when  12 => a<="1100";
          WHEN (TestLen - 1) =>   Testing <= False;
          WHEN OTHERS => NULL; 
		  
     END CASE;					   
	 

     count:= count + 1;	  
	 end if;
   END PROCESS Test_Proc;

END shift_test;