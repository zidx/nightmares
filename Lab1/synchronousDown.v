//-----------------------------------------------------------
// Module name:
// SynchronousDown
//
// Description:
// Module implemented as a synchronous down counter.
// Includes inputs reset and clock, and outputs the count.
// 
// Author(s):
// Zach Nerhenberg
//
//----------------------------------------------------------- 

`include "flipflop.v"

module SynchronousDown(rst, clk, out);
	input clk, rst;
	output [3:0] out;
	
	wire d0, d1, d2, d3;
	wire qBar0, qBar1, qBar2, qBar3;
	
	DFlipFlop flip0(out[0], qBar0, d0, clk, rst);
	DFlipFlop flip1(out[1], qBar1, d1, clk, rst);
	DFlipFlop flip2(out[2], qBar2, d2, clk, rst);
	DFlipFlop flip3(out[3], qBar3, d3, clk, rst);
	
	// Assignments for flip flop entrances
	assign d0 = ~out[0];
	assign d1 = ~(out[0] ^ out[1]);
	assign d2 = (out[2] & (out[1] | out[0])) | ~(out[2] | out[1] | out[0]);
	assign d3 = (out[3] & (out[2] | out[1] | out[0])) | ~(out[3] | out[2] | out[1] | out[0]);
endmodule