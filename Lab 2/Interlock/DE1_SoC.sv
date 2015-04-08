// Top Level module
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW); 
	 input CLOCK_50;
	 output reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
	 output [9:0] LEDR; 
	 input [3:0] KEY; 
	 input [9:0] SW; 

	 //user input wire assignments
	 wire spacecraftArriving   = SW[0];
	 wire spacecraftDeparting  = SW[1];
	 wire reset 					= KEY[0];
	 wire pressurizeChamber    = KEY[1];
	 wire evacuateChamber 		= KEY[2];
	 
	 // Generate clk off of CLOCK_50, whichClock picks rate.
	 wire [31:0] clk;
	 //uses clock 6 to use the lowest whole number of Hz for exactly precise timing.
	 parameter whichClock = 6;
	 ClockDivider cdiv (CLOCK_50, clk);
	 
	 //clock 6 used in operation for the timer.
	 wire clock = clk[whichClock];
	 wire [8:0] numSeconds;
	 
	 //instantiates the timer to get the number of seconds
	 Timer secTimer (clock, reset, numSeconds);
	 
	 //eight minutes when numSeconds equals this
	 parameter uranusOpens = 9'b111100000;
	 //five minutes
	 parameter uranusFive  = 9'b100101100;
	 
	 //combinational logic
	 always @(*) begin
		
	 end
	 
	 
	 //assign LED's to user switches?
	 
	 
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