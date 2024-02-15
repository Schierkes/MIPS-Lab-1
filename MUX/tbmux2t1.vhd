-------------------------------------------------------------------------
-- Sophie Waterman Hines
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tbmux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the TPU MAC unit.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O


-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
entity tbmux2t1 is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tbmux2t1;

architecture mixed of tbmux2t1 is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component mux2t1 is
  port(i_S                         : in std_logic;
       i_D0			   : in std_logic;
	i_D1			   : in std_logic;
       o_O 		            : out std_logic);
end component;

signal CLK, reset : std_logic := '0';

-- TODO: change input and output signals as needed.
signal s_S   : std_logic := '0';
signal s_D0  : std_logic := '0';
signal s_D1 : std_logic := '0';
signal s_O   : std_logic;

begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: mux2t1
  port map(
            i_S     => s_S,
            i_D0       => s_D0,
            i_D1       => s_D1,
            o_O     => s_O);

  
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
  
  -- Assign inputs for each test case.
  -- TODO: add test cases as needed.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER/2; -- for waveform clarity, I prefer not to change inputs on clk edges

   
    s_S   <= '0';  
    s_D0   <= '0';
    s_D1 <= '0';
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;


    s_S	   <='1'; 
    s_D0   <= '0';
    s_D1 <= '0';
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;


    s_S	   <='0'; 
    s_D0   <= '1';
    s_D1 <= '0';
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

    s_S	   <='1'; 
    s_D0   <= '1';
    s_D1 <= '0';
    
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;


    s_S	   <='0'; 
    s_D0   <= '0';
    s_D1 <= '1';
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

    s_S	   <='1'; 
    s_D0   <= '0';
    s_D1 <= '1';
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;
    

    s_S	   <='0'; 
    s_D0   <= '1';
    s_D1 <= '1'; 
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;
 

    s_S	   <='1'; 
    s_D0   <= '1';
    s_D1 <= '1'; 
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;
   

    
  end process;
  

end mixed;
