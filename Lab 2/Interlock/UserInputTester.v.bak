//-----------------------------------------------------------
// Module name:
// UserInputTester
//
// Description:
// Module implemented as part of testing system.
// Tests all possible states of UserInput.
// 
// Author(s):
// Krista Holden
//
//----------------------------------------------------------- 

module UserInputTester (clk, in, pressed);
	input pressed;
	output reg clk, rst;

  parameter stimDelay = 20;

  always begin
    #stimDelay clk = !clk;
  end
  
  initial // Response
  begin
    $display("\t\t out \t in \t clk \t Time ");
	$monitor("\t\t %b \t %b \t %b", out, in, clk, $time );
  end

  initial // Stimulus
  begin
    in = 0; clk = 0;
    #stimDelay in = 1;
    #(3 * stimDelay) in = 0;
    #(3 * stimDelay) in = 1;
	 #stimDelay in = 0;
	 #stimDelay in = 1;
    #(4*stimDelay); // needed to see END of simulation
    $finish; // finish simulation
  end
endmodule 