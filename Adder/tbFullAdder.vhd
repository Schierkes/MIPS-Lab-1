-------------------------------------------------------------------------
-- Sophie Waterman Hines
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tbFullAdderN
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the full n bit adder
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tbFullAdderN is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tbFullAdderN;

architecture mixed of tbFullAdderN is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;


component fullAdderN is
	generic(N : integer := 16);
  port(iA                         : in std_logic_vector(N-1 downto 0);
       iB		            : in std_logic_vector(N-1 downto 0);
       iC			    : in std_logic_vector(N-1 downto 0); 	
       oS 		            : out std_logic_vector(N-1 downto 0);
       oC                           : out std_logic_vector(N-1 downto 0));
end component;

signal CLK, reset : std_logic := '0';

signal s_iA  : std_logic_vector(15 downto 0) := (others => '0');
signal s_iB   : std_logic_vector(15 downto 0) := (others => '0');
signal s_iC   : std_logic_vector(15 downto 0) := (others => '0');
signal s_oS   : std_logic_vector(15 downto 0) := (others => '0');
signal s_oC   : std_logic_vector(15 downto 0) := (others => '0');

begin

  DUT0: fullAdderN
  port map(
            iA	     => s_iA,
            iB       => s_iB,
	    iC	     => s_iC,
            oC       => s_oC,
            oS       => s_oS);
  --You can also do the above port map in one line using the below format: http://www.ics.uci.edu/~jmoorkan/vhdlref/compinst.html

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

    wait for gCLK_HPER*2;
    -- Expect: s_W internal signal to be 10 after positive edge of clock

    -- 2
    s_iA <= "0000000011111111";
    s_iB <= "0000000011111111";
    s_iC(0) <= '1';
    wait for gCLK_HPER*2;

   -- 3
   s_iA <= "0101010101010101";
   s_iB <= "1010101010101010";
   s_iC <= "0000000000000000";
    
  end process;

end mixed;