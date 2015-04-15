//-----------------------------------------------------------
// Module name:
// testBench
//
// Description:
// Module implemented as part of testing system.
// Test synchronous up counter with Tester module.
// 
// Author(s):
// Krista Holden
//-----------------------------------------------------------

`include "SynchronousUp.v"
`include "SynchronousUpTester.v"

module testBench;
	wire clk, rst;
	wire [3:0] out;
	
	//declare instance of synchronous down counter.
	SynchronousUp mySynchronousUp (rst, clk, out);

	// declare an instance of the Tester module
	SynchronousUpTester aTester (rst, clk, out);

	// generate file for gtkwave
	initial
	begin
		$dumpfile("mySynchronousUp.vcd");
		$dumpvars(1,mySynchronousUp);
	end
endmodule 