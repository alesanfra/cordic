-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : scheme
-- Author      : Windows User
-- Company     : ss
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\scheme\compile\blocks.vhd
-- Generated   : Mon Dec 22 14:50:36 2014
-- From        : c:\My_Designs\scheme\src\blocks.bde
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


entity blocks is
  port(
       y : in STD_LOGIC_VECTOR(31 downto 0)
  );
end blocks;

architecture blocks of blocks is

---- Component declarations -----

component dff
  port (
       clk : in STD_LOGIC;
       d : in STD_LOGIC;
       reset : in STD_LOGIC;
       q : out STD_LOGIC
  );
end component;

----     Constants     -----
constant DANGLING_INPUT_CONSTANT : STD_LOGIC := 'Z';

---- Signal declarations used on the diagram ----

signal clk : STD_LOGIC;
signal reset : STD_LOGIC;

---- Declaration for Dangling input ----
signal Dangling_Input_Signal : STD_LOGIC;

begin

----  Component instantiations  ----

initial : dff
  port map(
       clk => clk,
       d => Dangling_Input_Signal,
       reset => reset
  );


---- Dangling input signal assignment ----

Dangling_Input_Signal <= DANGLING_INPUT_CONSTANT;

end blocks;
