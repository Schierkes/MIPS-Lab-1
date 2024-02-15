-------------------------------------------------------------------------
-- Sophie Waterman Hines
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- onesCompliment_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains the implementation for a onesCompliment machine
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity onesCompliment_N is
	generic(N : integer := 16); --Generic i/o data width
	port(	i_A	: in std_logic_vector(N-1 downto 0);
		o_F	: out std_logic_vector(N-1 downto 0));
end onesCompliment_N;

architecture struct of onesCompliment_N is

component invg is 
		port(i_A	: in std_logic;
		     o_F	: out std_logic);
end component;

begin

Nbit_onesCompliment: for i in 0 to N-1 generate
	onesComp: invg port map(
	i_A	=> i_A(i),
	o_F     => o_F(i));
end generate Nbit_onesCompliment;

end struct;
	