//-----------------------------------------------------------
// Module name:
// Percents
//
// Description:
//	Returns the percent the buffer is filled through the/
// percent output. Allows the buffer to be flushed instead
// through the emptyBuffer input being high. Allows the
// buffer to be paused through the pasue input being high.
// Resets to 0.
// 
// Author(s):
// Cody Ohlsen
// Zach Nehrenberg
//
//----------------------------------------------------------- 
module Percents (clock, reset, emptyBuffer, pause, percent);
	input clock, reset, emptyBuffer, pause;
	output [3:0] percent;
	
	reg [3:0] percentFilled;
	reg [18:0] clkCounter;
	
	 //number of clock cycles to represent ten percent
	 parameter uranusHz = 19'b0011111111111111111;
	 parameter uranusKindaHz = 19'b0001111111111111111;
	
	 //after number of clock cycles, ten percent of the buffer has filled
	 always @(posedge clock) begin
		// On reset, return the percent filled to zero
		if(reset) begin
			clkCounter <= 19'b0000000000000000000;
			percentFilled <= 3'b000;
		end
		else if (pause) percentFilled <= percentFilled;
		else if (uranusHz == clkCounter) begin
			if (emptyBuffer) percentFilled <= percentFilled - 1'b1;
			else percentFilled <= percentFilled + 1'b1;
			clkCounter <= 19'b0000000000000000000;
		end
		else if (clkCounter == uranusKindaHz) begin
			if (emptyBuffer) percentFilled <= percentFilled - 1'b1;
			else percentFilled <= percentFilled;
			clkCounter <= clkCounter + 1'b1;
		end
		else begin
			clkCounter <= clkCounter + 1'b1;
		end
	 end
	 
	 assign percent = percentFilled;
	 
endmodule

//-----------------------------------------------------------
// Module name:
// PercentTestbench
//
// Description:
// Module implemented as part of testing system.
// Tests all possible states of Percent.
// 
// Author(s):
// Krista Holden
// Zach Nehrenberg
//
//----------------------------------------------------------- 
module PercentTestbench ();
	reg clock, rst;
	reg emptyBuffer, pause;
	wire [3:0] percent;
	
	
	reg helper;
	
	parameter tenPercent = 390625;
	parameter clkDur = 100;
	
	
	// Set up the clock. 
	initial clock=0;
	initial helper = 0;
	always begin 
		#(clkDur/2); 
		clock = ~clock; 
	end
	
	always begin
		#((clkDur * tenPercent) / 2)
		helper = ~helper;
	end
	initial rst = 0;
	
	Percents dut (clock, rst, emptyBuffer, pause, percent);
	
	initial begin
			rst = 0; pause = 0; 
			emptyBuffer = 0;		@(posedge helper);
		 	rst = 1;					@(posedge helper);
		 	rst = 0;					@(posedge helper);
										@(posedge helper);
										@(posedge helper);
										@(posedge helper);
										@(posedge helper);
										@(posedge helper);
			pause = 1;				@(posedge helper);
										@(posedge helper);
			pause = 0;				@(posedge helper);
										@(posedge helper);
										@(posedge helper);
			emptyBuffer = 1;		@(posedge helper);
										@(posedge helper);
										@(posedge helper);
										@(posedge helper);
		 	rst = 1;					@(posedge helper);
		 	rst = 0;					@(posedge helper);
		
		
		$stop; // End the simulation.
	end
endmodule
