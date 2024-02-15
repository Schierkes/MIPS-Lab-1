-------------------------------------------------------------------------
-- Sophie Waterman Hines
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- fullAdderN.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains the implementation of a 
-- full adder using structural vhdl.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity fullAdderN is
	generic(N : integer := 16); 
	port(	iA	: in std_logic_vector(N-1 downto 0);
		iB	: in std_logic_vector(N-1 downto 0);
		iC	: in std_logic_vector(N-1 downto 0);   
		oC	: out std_logic_vector(N-1 downto 0); 
		oS	: out std_logic_vector(N-1 downto 0));
end fullAdderN;

architecture struct of fullAdderN is

	component fullAdder is 
		port(iA               	: in std_logic;
       		iB               	: in std_logic;
      		iC			: in std_logic;
      		oS			: out std_logic;
       		oC               	: out std_logic);
	end component;

begin

loop1 : for i in 0 to 0 generate
	rippleAdder : fullAdder port map(
	iA	=>	iA(i),
	iB	=>	iB(i),
	iC	=>	iC(i),
	oS	=>	oS(i),	
	oC	=>	oC(i));
end generate loop1;

loop2 : for j in 1 to N-1 generate
	rippleAdder2 : fullAdder port map(
	iA	=>	iA(j),
	iB	=>	iB(j),
	iC	=>	oC(j-1),
	oS	=>	oS(j),
	oC	=>	oC(j));
end generate loop2;

end struct;