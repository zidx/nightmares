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

`include "DownCounterSchematic.v"
`include "synchronousDownSchematicTester.v"

module testBench;
	wire rst, clk;
	wire [3:0] out;
	
	//declare instance of synchronous down counter.
	DownCounterSchematic mySynchronousDown (rst, 
											clk, 
											out);
										
	// declare an instance of the Tester module
	SynchronousDownSchematicTester aTester (rst, clk, out);

	// generate file for gtkwave
	initial
	begin
		$dumpfile("mySynchronousDownSchematic.vcd");
		$dumpvars(1,mySynchronousDown);
	end
endmodule 