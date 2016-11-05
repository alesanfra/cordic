-------------------------------------------------------------------------------
--
-- Title       : Fub1
-- Design      : scheme
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Francesco\Dropbox\#becostaisereno\scheme2\scheme\src\Fub1.vhd
-- Generated   : Mon Dec 29 17:00:48 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {Fub1} architecture {Fub1}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity createAddr is 
	generic(M:integer:=6);
	 port(
		 U12Out : in STD_LOGIC_VECTOR(M-2 downto 0);
		 U14Out : in STD_LOGIC;
		 U19_U16 : out STD_LOGIC_VECTOR(M-1 downto 0)
	     );
end createAddr;

--}} End of automatically maintained section

architecture behavioural of createAddr is
begin

	 -- enter your statements here --
	 U19_U16(M-2 downto 0) <= U12Out;
	 U19_U16(M-1) <= U14Out;
end behavioural;
