-------------------------------------------------------------------------
-- Sophie Waterman Hines
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tbMux2t1_N
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the N bit wide 2 to 1 mutliplexer
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
entity tbMux2t1_N is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tbMux2t1_N;

architecture mixed of tbMux2t1_N is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
component mux2t1_N is
  generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

signal s_S : std_logic	:= '0';
signal s_D0 : std_logic_vector(15 downto 0)	:= (others => '0');
signal s_D1 : std_logic_vector(15 downto 0)	:= (others => '0');
signal s_O : std_logic_vector(15 downto 0)	:= (others => '0');


begin

  DUT0: mux2t1_N
  port map(
          i_S	=> s_S,
	   i_D0	=> s_D0,
	   i_D1	=> s_D1,
	   o_O	=> s_O);
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
  
  -- Assign inputs for each test case.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER/2; -- for waveform clarity, I prefer not to change inputs on clk edges

	s_S	<= '0';
	s_D0	<= "0000000000000001";
	s_D1	<= "0000000011110000";

	wait for gCLK_HPER*2;

	s_S	<= '1';
	s_D0	<= "0000000000000001";
	s_D1	<= "0000000011110000";

    wait for gCLK_HPER*2;

	s_S	<= '0';
	s_D0	<= "0101010101010101";
	s_D1	<= "1010101010101010";

    wait for gCLK_HPER*2;

  
  end process;

end mixed;