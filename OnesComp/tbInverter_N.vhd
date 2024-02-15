-------------------------------------------------------------------------
-- Sophie Waterman Hines
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tbInverter_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for a Nbit inverter
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tbInverter_N is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tbInverter_N;

architecture mixed of tbInverter_N is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

component onescompliment_N is
  generic(N : integer := 16); --Generic i/o data width
	port(	i_A	: in std_logic_vector(N-1 downto 0);
		o_F	: out std_logic_vector(N-1 downto 0));

end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

signal s_A : std_logic_vector(15 downto 0)	:= (others => '0');
signal s_F : std_logic_vector(15 downto 0)	:= (others => '0');

begin

  DUT0: onescompliment_N
  port map(
          i_A	=> s_A,
	   o_F	=> s_F);
  --You can also do the above port map in one line using the below format: http://www.ics.uci.edu/~jmoorkan/vhdlref/compinst.html

  
  --This first process is to setup the clock for the test bench
  P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;

  -- This process resets the sequential components of the design.
  -- It is held to be 1 across both the negative and positive edges of the clock
  -- so it works regardless of whether the design uses synchronous (pos or neg edge)
  -- or asynchronous resets.
  P_RST: process
  begin
  	reset <= '0';   
    wait for gCLK_HPER/2;
	reset <= '1';
    wait for gCLK_HPER*2;
	reset <= '0';
	wait;
  end process;  
  
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER/2; -- for waveform clarity, I prefer not to change inputs on clk edges

    -- 1:
	s_A <= "0101010101010101";
	wait for gCLK_HPER*2;
    
    -- 2:
	s_A <= "1010101010101010";
    wait for gCLK_HPER*2;

    -- 3:
	s_A <= "0000000011111111";
 	wait for gCLK_HPER/2;

    -- 4:
	s_A <= "1111111100000000";
 	wait for gCLK_HPER/2;

  end process;

end mixed;