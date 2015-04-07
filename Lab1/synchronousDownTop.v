//-----------------------------------------------------------
// Module name:
// testBench
//
// Description:
// Module implemented as part of testing system.
// Test synchronous down counter with Tester module.
// 
// Author(s):
// Zach Nehrenburg
// Cody Ohlsen
// Krista Holden
//-----------------------------------------------------------

`include "synchronousDown.v"
`include "synchronousDownTester.v"

module testBench;
	wire clk, rst;
	wire [3:0] out;
	
	//declare instance of synchronous down counter.
	SynchronousDown mySynchronousDown (rst, clk, out);

	// declare an instance of the Tester module
	SynchronousDownTester aTester (rst, clk, out);

	// generate file for gtkwave
	initial
	begin
		$dumpfile("mySynchronousDown.vcd");
		$dumpvars(1,mySynchronousDown);
	end
endmodule 