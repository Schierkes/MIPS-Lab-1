-------------------------------------------------------------------------
-- Sophie Waterman Hines
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- Add_Sub.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: Contains an implementation of an add/sub machine
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Add_Sub is
	generic(N : integer := 16); --Generic i/o data width
	port(	iA	: in std_logic_vector(N-1 downto 0);
		iB	: in std_logic_vector(N-1 downto 0);
		nAdd_Sub	: in std_logic;
		oSum	: out std_logic_vector(N-1 downto 0));
end Add_Sub;

architecture struct of Add_Sub is

component mux2t1_N is
  generic(N : integer := 16); 
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

end component;

component onescompliment_N is
	generic(N : integer := 16); --Generic i/o data width
	port(	i_A	: in std_logic_vector(N-1 downto 0);
		o_F	: out std_logic_vector(N-1 downto 0));
end component;

component fullAdderN is
	generic(N : integer := 16); --Generic i/o data width
	port(	iA	: in std_logic_vector(N-1 downto 0);
		iB	: in std_logic_vector(N-1 downto 0);
		iC	: in std_logic_vector(N-1 downto 0);
		oC	: out std_logic_vector(N-1 downto 0);
		oS	: out std_logic_vector(N-1 downto 0));
end component;

signal invertedB : std_logic_vector(N-1 downto 0);
signal selectedB : std_logic_vector(N-1 downto 0);
signal carryIn : std_logic_vector(N-1 downto 0); 
signal carryOut : std_logic_vector(N-1 downto 0);

begin

	carryIn(0) <= nAdd_Sub;
invert: onescompliment_N 
	port map (
		i_A	=> iB,
		o_F	=> invertedB);

selectOp: mux2t1_N
	port map(i_S	=> nAdd_Sub,
		 i_D0	=> iB,
		 i_D1	=> invertedB,
		 o_O	=> selectedB); 

add: fullAdderN 
	port map(iA	=> iA,
		 iB	=> selectedB,
		 iC	=> carryIn,
		 oC	=> carryOut,
		 oS	=> oSum);

end struct;