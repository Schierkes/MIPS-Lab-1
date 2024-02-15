-------------------------------------------------------------------------
-- Sophie Waterman Hines
-- CprE Student
-- Iowa State University
-------------------------------------------------------------------------
-- mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a datafow implementation of a 2:1 multiplexer
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1 is 
	port(i_S		: in std_logic;
	     i_D0		: in std_logic;
	     i_D1		: in std_logic;
	     o_O		: out std_logic);
end mux2t1;

architecture o_O of mux2t1 is
begin
	o_O <= '1' when (i_S = '0' AND i_D0 = '1') else
		'1' when (i_S = '1' AND i_D1 = '1') else
		'0';
	end o_O;
