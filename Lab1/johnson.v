// Johnson Counter

`include "flipflop.v"

module Johnson(rst, clk, out);
	input clk, rst;
	output [3:0] out;

	wire qBar1, qBar2, qBar3, qBar4;
	
	DFlipFlop flip1(out[0], qBar1, qBar4, clk, rst);
	DFlipFlop flip2(out[1], qBar2, out[0], clk, rst);
	DFlipFlop flip3(out[2], qBar3, out[1], clk, rst);
	DFlipFlop flip4(out[3], qBar4, out[2], clk, rst);
endmodule
