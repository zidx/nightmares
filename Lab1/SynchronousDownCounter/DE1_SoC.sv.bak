// Top Level module
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW); 
	 input CLOCK_50;
	 output reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
	 output [9:0] LEDR; 
	 input [3:0] KEY; 
	 input [9:0] SW; 
	 
	 // Generate clk off of CLOCK_50, whichClock picks rate.
	 wire [31:0] clk;
	 parameter whichClock = 25;
	 ClockDivider cdiv (CLOCK_50, clk);

	 SynchronousDown syncDown (SW[0], clk[whichClock], LEDR[3:0]);
	 
endmodule

module ClockDivider (clock, divided_clocks);
	 input clock;
	 output [31:0] divided_clocks;
	 reg [31:0] divided_clocks;

	 initial
	 divided_clocks = 0;

	 always @(posedge clock)
	 divided_clocks = divided_clocks + 1;
endmodule 