module shiftIn ( out, clk, rst, in );
	input clk, rst;
	input in;
	output [7:0] out;
	
	wire in1, in2, in3, in4, in5, in6, in7, in8;
	
	DFlipFlop d1 (in1, in, clk, rst);
	DFlipFlop d2 (in2, in1, clk, rst);
	DFlipFlop d3 (in3, in2, clk, rst);
	DFlipFlop d4 (in4, in3, clk, rst);
	DFlipFlop d5 (in5, in4, clk, rst);
	DFlipFlop d6 (in6, in5, clk, rst);
	DFlipFlop d7 (in7, in6, clk, rst);
	DFlipFlop d8 (in8, in7, clk, rst);
	
	assign out = {in1, in2, in3, in4, in5, in6, in7, in8};

endmodule