-------------------------------------------------------------------------------
--
-- Title       : Cordic
-- Design      : scheme
-- Author      : Windows User
-- Company     : ss
--
-------------------------------------------------------------------------------
--
-- File        : \\vmware-host\shared folders\scrivania\progetto\scheme2\scheme\compile\blockCordic.vhd
-- Generated   : Thu Mar 12 09:23:50 2015
-- From        : \\vmware-host\shared folders\scrivania\progetto\scheme2\scheme\src\blockCordic.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_unsigned.all;


entity blockCordic is
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
end blockCordic;

architecture blockCordic of blockCordic is

---- Component declarations -----

component adder
  generic(
       N : INTEGER := 32
  );
  port (
       a : in STD_LOGIC_VECTOR(N-1 downto 0);
       b : in STD_LOGIC_VECTOR(N-1 downto 0);
       s : out STD_LOGIC_VECTOR(N-1 downto 0)
  );
end component;
component counter_new
  generic(
       N : INTEGER := 6
  );
  port (
       clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       count : out STD_LOGIC_VECTOR(N-2 downto 0);
       first_iteration : out STD_LOGIC;
       last_iteration : out STD_LOGIC
  );
end component;
component createAddr
  generic(
       M : INTEGER := 6
  );
  port (
       U12Out : in STD_LOGIC_VECTOR(M-2 downto 0);
       U14Out : in STD_LOGIC;
       U19_U16 : out STD_LOGIC_VECTOR(M-1 downto 0)
  );
end component;
component divider
  generic(
       N : INTEGER := 34
  );
  port (
       x_n : in STD_LOGIC_VECTOR(N-1 downto 0);
       rho : out STD_LOGIC_VECTOR(N-2 downto 0)
  );
end component;
component extender
  generic(
       N : INTEGER := 34
  );
  port (
       i : in STD_LOGIC_VECTOR(N-3 downto 0);
       o : out STD_LOGIC_VECTOR(N-1 downto 0)
  );
end component;
component fix_angle
  generic(
       N : INTEGER := 32
  );
  port (
       reset : in STD_LOGIC;
       x : in STD_LOGIC;
       y : in STD_LOGIC;
       z : in STD_LOGIC_VECTOR(N-1 downto 0);
       z_fixed : out STD_LOGIC_VECTOR(N-1 downto 0)
  );
end component;
component inverter
  generic(
       N : INTEGER := 32
  );
  port (
       x : in STD_LOGIC_VECTOR(N-1 downto 0);
       y : out STD_LOGIC_VECTOR(N-1 downto 0)
  );
end component;
component is_valid
  generic(
       N : INTEGER := 34
  );
  port (
       last_iteration : in STD_LOGIC;
       soc : in STD_LOGIC;
       x_n : in STD_LOGIC_VECTOR(N-2 downto 0);
       eoc : out STD_LOGIC;
       rho : out STD_LOGIC_VECTOR(N-3 downto 0);
       valid : out STD_LOGIC
  );
end component;
component n_abs
  generic(
       N : INTEGER := 32
  );
  port (
       input : in STD_LOGIC_VECTOR(N-1 downto 0);
       output : out STD_LOGIC_VECTOR(N-1 downto 0)
  );
end component;
component n_mux
  generic(
       N : INTEGER := 4
  );
  port (
       a : in STD_LOGIC_VECTOR(N-1 downto 0);
       b : in STD_LOGIC_VECTOR(N-1 downto 0);
       s : in STD_LOGIC;
       y : out STD_LOGIC_VECTOR(N-1 downto 0)
  );
end component;
component n_register
  generic(
       N : INTEGER := 32
  );
  port (
       clk : in STD_LOGIC;
       d : in STD_LOGIC_VECTOR(N-1 downto 0);
       reset : in STD_LOGIC;
       q : out STD_LOGIC_VECTOR(N-1 downto 0)
  );
end component;
component n_shift
  generic(
       N : INTEGER := 32
  );
  port (
       a : in STD_LOGIC_VECTOR(N-1 downto 0);
       s : in STD_LOGIC_VECTOR(4 downto 0);
       b : out STD_LOGIC_VECTOR(N-1 downto 0)
  );
end component;
component rom64x32
  port (
       addr : in STD_LOGIC_VECTOR(5 downto 0);
       dout : out STD_LOGIC_VECTOR(31 downto 0)
  );
end component;
component sign
  generic(
       N : INTEGER := 32
  );
  port (
       a : in STD_LOGIC_VECTOR(N-1 downto 0);
       s : out STD_LOGIC
  );
end component;
component starter
  port (
       rst : in STD_LOGIC;
       soc : in STD_LOGIC;
       reset : out STD_LOGIC
  );
end component;

---- Signal declarations used on the diagram ----

signal first_iteration : STD_LOGIC;
signal NET14233 : STD_LOGIC;
signal NET9143 : STD_LOGIC;
signal NET9160 : STD_LOGIC;
signal reset : STD_LOGIC;
signal U14Out : STD_LOGIC;
signal backx : STD_LOGIC_VECTOR (N-1 downto 0);
signal backy : STD_LOGIC_VECTOR (N-1 downto 0);
signal backz : STD_LOGIC_VECTOR (N-3 downto 0);
signal U10_U4 : STD_LOGIC_VECTOR (N-1 downto 0);
signal U11_U10 : STD_LOGIC_VECTOR (N-1 downto 0);
signal U12Out : STD_LOGIC_VECTOR (M-2 downto 0);
signal U15_U18 : STD_LOGIC_VECTOR (N-3 downto 0);
signal U16_U15 : STD_LOGIC_VECTOR (N-3 downto 0);
signal U17_U11 : STD_LOGIC_VECTOR (N-1 downto 0);
signal U19_U16 : STD_LOGIC_VECTOR (M-1 downto 0);
signal U1Out : STD_LOGIC_VECTOR (N-1 downto 0);
signal U24Out : STD_LOGIC_VECTOR (N-1 downto 0);
signal U25Out : STD_LOGIC_VECTOR (N-1 downto 0);
signal U26_U27 : STD_LOGIC_VECTOR (N-2 downto 0);
signal U2_U17 : STD_LOGIC_VECTOR (N-1 downto 0);
signal U3_U6 : STD_LOGIC_VECTOR (N-1 downto 0);
signal U5Out : STD_LOGIC_VECTOR (N-1 downto 0);
signal U6_U9 : STD_LOGIC_VECTOR (N-1 downto 0);
signal U7_U24 : STD_LOGIC_VECTOR (N-1 downto 0);
signal U8_U13 : STD_LOGIC_VECTOR (N-1 downto 0);
signal U9_U8 : STD_LOGIC_VECTOR (N-1 downto 0);

begin

----  Component instantiations  ----

U1 : n_mux
  generic map (
       N => N
  )
  port map(
       a => U24Out( N-1 downto 0 ),
       b => backx( N-1 downto 0 ),
       s => first_iteration,
       y => U1Out( N-1 downto 0 )
  );

U10 : adder
  generic map (
       N => N
  )
  port map(
       a => U11_U10( N-1 downto 0 ),
       b => U5Out( N-1 downto 0 ),
       s => U10_U4( N-1 downto 0 )
  );

U11 : n_shift
  generic map (
       N => N
  )
  port map(
       a => U17_U11( N-1 downto 0 ),
       b => U11_U10( N-1 downto 0 ),
       s => U12Out( M-2 downto 0 )
  );

U12 : counter_new
  port map(
       clk => clk,
       count => U12Out( M-2 downto 0 ),
       first_iteration => first_iteration,
       last_iteration => NET14233,
       reset => reset
  );

U13 : n_register
  generic map (
       N => N
  )
  port map(
       clk => clk,
       d => U8_U13( N-1 downto 0 ),
       q => backx( N-1 downto 0 ),
       reset => reset
  );

U14 : sign
  generic map (
       N => N
  )
  port map(
       a => U5Out( N-1 downto 0 ),
       s => U14Out
  );

U15 : adder
  generic map (
       N => N-2
  )
  port map(
       a => U16_U15( N-3 downto 0 ),
       b => backz( N-3 downto 0 ),
       s => U15_U18( N-3 downto 0 )
  );

U16 : rom64x32
  port map(
       addr => U19_U16( M-1 downto 0 ),
       dout => U16_U15( N-3 downto 0 )
  );

U17 : n_mux
  generic map (
       N => N
  )
  port map(
       a => U2_U17( N-1 downto 0 ),
       b => U1Out( N-1 downto 0 ),
       s => U14Out,
       y => U17_U11( N-1 downto 0 )
  );

U18 : n_register
  generic map (
       N => N-2
  )
  port map(
       clk => clk,
       d => U15_U18( N-3 downto 0 ),
       q => backz( 31 downto 0 ),
       reset => reset
  );

U19 : createAddr
  generic map (
       M => M
  )
  port map(
       U12Out => U12Out( M-2 downto 0 ),
       U14Out => U14Out,
       U19_U16 => U19_U16( M-1 downto 0 )
  );

U2 : inverter
  generic map (
       N => N
  )
  port map(
       x => U1Out( N-1 downto 0 ),
       y => U2_U17( N-1 downto 0 )
  );

U20 : fix_angle
  generic map (
       N => N-2
  )
  port map(
       reset => reset,
       x => NET9143,
       y => NET9160,
       z => backz( 31 downto 0 ),
       z_fixed => zn( N-3 downto 0 )
  );

U21 : sign
  generic map (
       N => N
  )
  port map(
       a => U7_U24( N-1 downto 0 ),
       s => NET9143
  );

U22 : sign
  generic map (
       N => N
  )
  port map(
       a => U25Out( N-1 downto 0 ),
       s => NET9160
  );

U23 : starter
  port map(
       reset => reset,
       rst => rst,
       soc => soc
  );

U24 : n_abs
  generic map (
       N => N
  )
  port map(
       input => U7_U24( N-1 downto 0 ),
       output => U24Out( N-1 downto 0 )
  );

U25 : extender
  generic map (
       N => N
  )
  port map(
       i => y0( N-3 downto 0 ),
       o => U25Out( N-1 downto 0 )
  );

U26 : divider
  port map(
       rho => U26_U27( N-2 downto 0 ),
       x_n => backx( N-1 downto 0 )
  );

U27 : is_valid
  generic map (
       N => N
  )
  port map(
       eoc => eoc,
       last_iteration => NET14233,
       rho => rho( N-3 downto 0 ),
       soc => soc,
       valid => valid,
       x_n => U26_U27( N-2 downto 0 )
  );

U3 : inverter
  generic map (
       N => N
  )
  port map(
       x => U5Out( N-1 downto 0 ),
       y => U3_U6( N-1 downto 0 )
  );

U4 : n_register
  generic map (
       N => N
  )
  port map(
       clk => clk,
       d => U10_U4( N-1 downto 0 ),
       q => backy( N-1 downto 0 ),
       reset => reset
  );

U5 : n_mux
  generic map (
       N => N
  )
  port map(
       a => U25Out( N-1 downto 0 ),
       b => backy( N-1 downto 0 ),
       s => first_iteration,
       y => U5Out( N-1 downto 0 )
  );

U6 : n_mux
  generic map (
       N => N
  )
  port map(
       a => U5Out( N-1 downto 0 ),
       b => U3_U6( N-1 downto 0 ),
       s => U14Out,
       y => U6_U9( N-1 downto 0 )
  );

U7 : extender
  generic map (
       N => N
  )
  port map(
       i => x0( N-3 downto 0 ),
       o => U7_U24( N-1 downto 0 )
  );

U8 : adder
  generic map (
       N => N
  )
  port map(
       a => U1Out( N-1 downto 0 ),
       b => U9_U8( N-1 downto 0 ),
       s => U8_U13( N-1 downto 0 )
  );

U9 : n_shift
  generic map (
       N => N
  )
  port map(
       a => U6_U9( N-1 downto 0 ),
       b => U9_U8( N-1 downto 0 ),
       s => U12Out( M-2 downto 0 )
  );


end blockCordic;
