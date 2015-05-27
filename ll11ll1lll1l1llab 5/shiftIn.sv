module shiftIn ( out, clk, rst, in, counter );
	input clk, rst;
	input in;
	input [7:0] counter;
	output [7:0] out;
	wire myClock;
	
	
	assign myClock = clk && (counter <= 8'b10010000);
	
	wire in1, in2, in3, in4, in5, in6, in7, in8;
	DFlipFlop d1 (in1, in, myClock, rst);
	DFlipFlop d2 (in2, in1, myClock, rst);
	DFlipFlop d3 (in3, in2, myClock, rst);
	DFlipFlop d4 (in4, in3, myClock, rst);
	DFlipFlop d5 (in5, in4, myClock, rst);
	DFlipFlop d6 (in6, in5, myClock, rst);
	DFlipFlop d7 (in7, in6, myClock, rst);
	DFlipFlop d8 (in8, in7, myClock, rst);
	
	assign out = {in1, in2, in3, in4, in5, in6, in7, in8};

endmodule