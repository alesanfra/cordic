---------------------------------------------------------------------------------------------------
--
-- Title       : rom64x32
-- Design      : CORDIC Vector
-- Author      : Beco Mola Sanfra
--
---------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all;

entity rom64x32 is
	 port(
		 addr : in STD_LOGIC_VECTOR(5 downto 0);
		 dout : out STD_LOGIC_VECTOR(31 downto 0)
	     );
end rom64x32;
architecture structural of rom64x32 is	  
constant DIMROM: natural :=64;
constant DIMWORD: natural :=32;			  
type ROM_IMAGE  is array (natural range 0 to DIMROM-1) of STD_LOGIC_VECTOR(DIMWORD-1 downto 0);

constant ROM: ROM_IMAGE :=
(
	0 => X"FF36F025",
	1 => X"FF894E64",
	2 => X"FFC14914",
	3 => X"FFE02A45",
	4 => X"FFF00552",
	5 => X"FFF800AB",
	6 => X"FFFC0015",
	7 => X"FFFE0003",
	8 => X"FFFF0000",
	9 => X"FFFF8000",
	10 => X"FFFFC000",
	11 => X"FFFFE000",
	12 => X"FFFFF000",
	13 => X"FFFFF800",
	14 => X"FFFFFC00",
	15 => X"FFFFFE00",
	16 => X"FFFFFF00",
	17 => X"FFFFFF80",
	18 => X"FFFFFFC0",
	19 => X"FFFFFFE0",
	20 => X"FFFFFFF0",
	21 => X"FFFFFFF8",
	22 => X"FFFFFFFC",
	23 => X"FFFFFFFE",
	24 => X"FFFFFFFF",
	25 => X"00000000",
	26 => X"00000000",
	27 => X"00000000",
	28 => X"00000000",
	29 => X"00000000",
	30 => X"00000000",
	31 => X"00000000",
	32 => X"00C90FDB",
	33 => X"0076B19C",
	34 => X"003EB6EC",
	35 => X"001FD5BB",
	36 => X"000FFAAE",
	37 => X"0007FF55",
	38 => X"0003FFEB",
	39 => X"0001FFFD",
	40 => X"00010000",
	41 => X"00008000",
	42 => X"00004000",
	43 => X"00002000",
	44 => X"00001000",
	45 => X"00000800",
	46 => X"00000400",
	47 => X"00000200",
	48 => X"00000100",
	49 => X"00000080",
	50 => X"00000040",
	51 => X"00000020",
	52 => X"00000010",
	53 => X"00000008",
	54 => X"00000004",
	55 => X"00000002",
	56 => X"00000001",
	57 => X"00000000",
	58 => X"00000000",
	59 => X"00000000",
	60 => X"00000000",
	61 => X"00000000",
	62 => X"00000000",
	63 => X"00000000"
);	
begin
	dout<=ROM(conv_integer(addr));
end structural;
