-------------------------------------------------------------------------
-- Sophie Waterman Hines
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tbAdd_Sub.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the add/sub machine
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tbAdd_Sub is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tbAdd_Sub;

architecture mixed of tbAdd_Sub is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

component Add_Sub is
	generic(N : integer := 16); --Generic i/o data width
	port(	iA	: in std_logic_vector(N-1 downto 0);
		iB	: in std_logic_vector(N-1 downto 0);
		nAdd_Sub	: in std_logic;
		oSum	: out std_logic_vector(N-1 downto 0));
end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

signal s_iA  : std_logic_vector(15 downto 0) := (others => '0');
signal s_iB   : std_logic_vector(15 downto 0) := (others => '0');
signal s_nAdd_Sub : std_logic := '0'; 
signal s_oSum	: std_logic_vector(15 downto 0) := (others => '0');

begin

  DUT0: Add_Sub
  port map(
            iA	     => s_iA,
            iB       => s_iB,
	    nAdd_Sub	=> s_nAdd_Sub,
            oSum       => s_oSum);
            
  --You can also do the above port map in one line using the below format: http://www.ics.uci.edu/~jmoorkan/vhdlref/compinst.html

  
  --This first process is to setup the clock for the test bench
  P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;

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

    -- 1
    s_iA   <= "1111111111111111";
    s_iB   <= "1111111111111111";
    s_nAdd_Sub	<= '0';

    wait for gCLK_HPER*2;
    -- Expect: s_W internal signal to be 10 after positive edge of clock

    -- 2
    s_iA <= "0000000011111111";
    s_iB <= "0000000011111111";
    s_nAdd_Sub	<= '0';
   
    wait for gCLK_HPER*2;

   -- 3
   s_iA <= "0101010101010101";
   s_iB <= "1010101010101010";
   s_nAdd_Sub	<= '0';

    
   wait for gCLK_HPER*2; -- for waveform clarity, I prefer not to change inputs on clk edges

    -- 4
    s_iA   <= "1111111111111111";
    s_iB   <= "1111111111111111";
    s_nAdd_Sub	<= '1';


    wait for gCLK_HPER*2;
    -- Expect: s_W internal signal to be 10 after positive edge of clock

    -- 5
    s_iA <= "0000000011111111";
    s_iB <= "0000000011111111";
    s_nAdd_Sub	<= '1';
    
    wait for gCLK_HPER*2;

   -- 6
   s_iA <= "0101010101010101";
   s_iB <= "1010101010101010";
   s_nAdd_Sub	<= '1';
    
  end process;

end mixed;