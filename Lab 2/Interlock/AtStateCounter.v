//-----------------------------------------------------------
// Module name:
// AtStateCounter
//
// Description:
// Uses a 4-bit ripple up counter with reset active low
// to track if the counter is at five, seven, or eight.
// 
// Author(s):
// Krista Holden
//
//----------------------------------------------------------- 

`include "SynchronousUp.v"

module AtStateCounter(rst, clk, out);
	input clk, rst;
	output [2:0] out;
	
	wire atFive, atSeven, atEight;
	wire [3:0] count;
	
	parameter five = 4'b0101;
	parameter seven = 4'b0111;
	parameter eight = 4'b1000;
	
	assign out = {atFive, atSeven, atEight};
	
	SynchronousUp counter(rst, clk, count);
	
	assign atFive = (count == five);
	assign atSeven = (count == seven);
	assign atEight = (count == eight);
	
endmodule
