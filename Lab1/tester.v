//-----------------------------------------------------------
// Module name:
// Tester
//
// Description:
// Module implemented as part of testing system.
// Tests all possible states of all counters.
// Tests reset.
// 
// Author(s):
// Krista Holden
// Cody Ohlsen
//
//----------------------------------------------------------- 

module Tester (rst, clk, out);
	input [3:0] out;
	output reg clk, rst;

  // creates a clock with specified delay
  parameter stimDelay = 20;

  //clock changes every delay
  always begin
    #stimDelay clk = !clk;
  end
  
  initial // Response
  begin
    $display("\t\t out \t rst \t clk \t Time ");
	$monitor("\t\t %b \t %b \t %b", out, rst, clk, $time );
  end

  initial // Stimulus
  begin
    rst = 0; clk = 0;
    #stimDelay rst = 1;
    #(64 * stimDelay) rst = 0;
    #(3 * stimDelay) rst = 1;
    #(4*stimDelay); // needed to see END of simulation
    $finish; // finish simulation
  end
endmodule 
