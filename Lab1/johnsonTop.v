// johnsonTop.v
`include "johnson.v"

module testBench;
  // connect the two modules
  wire clk, rst;
  wire [3:0] out;

  // declare an instance of the Johnson
  Johnson myJohnson (rst, clk, out);

  // declare an instance of the testIt module
  Tester aTester (rst, clk, out);

  // file for gtkwave
  initial
  begin
    $dumpfile("johnson.vcd");
    $dumpvars(1,myJohnson);
    end
endmodule 

// johnsonTop.v cont.
module Tester (rst, clk, out);
	input [3:0] out;
	output reg clk, rst;

  parameter stimDelay = 20;

  initial // Response
  begin
    $display("\t\t out \t rst \t clk \t Time ");
		$monitor("\t\t %b \t %b \t %b", out, rst, clk, $time );
  end

  initial // Stimulus
  begin
    clk = 0; rst = 0;
    #stimDelay clk = 1; rst = 1;
    #stimDelay clk = 0; 
    #stimDelay clk = 1; 
    #stimDelay clk = 0;
    #stimDelay clk = 1; 
    #stimDelay clk = 0;
    #stimDelay clk = 1; 
    #stimDelay clk = 0;
    #stimDelay clk = 1; 
    #stimDelay clk = 0;
    #stimDelay clk = 1; 
    #stimDelay clk = 0;
    #stimDelay clk = 1; 
    #stimDelay clk = 0;
    #stimDelay clk = 1; 
    #stimDelay clk = 0;
    #stimDelay clk = 1;  
    #stimDelay clk = 0; 
    #stimDelay clk = 1;
    #stimDelay clk = 0;
    #stimDelay clk = 1; rst = 0;
    #stimDelay clk = 0;
	#stimDelay clk = 1; rst = 1;
    #stimDelay clk = 0;
	#stimDelay clk = 1;
    #stimDelay clk = 0;

    #(2*stimDelay); // needed to see END of simulation
    $finish; // finish simulation
  end
endmodule 
