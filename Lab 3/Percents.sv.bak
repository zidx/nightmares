//-----------------------------------------------------------
// Module name:
// Timer
//
// Description:
// Counts the percent done of a camera. Resets to 0. Returns
// amount of percent done through percent.
// 10 is done, etc.
// 
// Author(s):
// Cody Ohlsen
// Zach Nehrenberg
//
//----------------------------------------------------------- 
module Percents (clock, reset, countDirection, pause, percent);
	input clock, reset, countDirection, pause;
	output [3:0] percent;
	
	reg [3:0] percentPassed;
	reg [18:0] clkCounter;
	
	 //number of clock cycles to represent one second
	 parameter uranusHz = 19'b1011111010111100001;
	
	 //after number of clock cycles, one second has passed.
	 always @(posedge clock) begin
		if(reset) begin
			clkCounter <= 19'b0000000000000000000;
			percentPassed <= 3'b000;
		end
		else if (uranusHz == clkCounter) begin
			if (pause) percentPassed = percentPassed;
			else begin:
				if (countDirection) percentPassed <= percentPassed - 2'b10;
				else percentPassed <= percentPassed + 1'b1;
			end
			clkCounter <= 19'b0000000000000000000;
		end
		else 
			clkCounter <= clkCounter + 1'b1;
	 end
	 
	 assign seconds = percentPassed;
	 
endmodule

//-----------------------------------------------------------
// Module name:
// TimerTestbench
//
// Description:
// Module implemented as part of testing system.
// Tests all possible states of Timer.
// 
// Author(s):
// Krista Holden
//
//----------------------------------------------------------- 
module PercentTestbench ();
	reg        clock, rst;
	wire [3:0] seconds;
	
	
	reg helper;
	parameter oneSec = 390625;
	
	parameter clkDur = 100;
	
	
	// Set up the clock. 
	initial clock=0;
	initial helper = 0;
	always begin 
		#(clkDur/2); 
		clock = ~clock; 
	end
	
	always begin
		#((clkDur * oneSec) / 2)
		helper = ~helper;
	end
	initial rst = 0;
	
	Timer dut (clock, rst, seconds);
	
	initial begin
			rst = 0;		@(posedge helper);
		 	rst = 1;		@(posedge helper);
		 	rst = 0;		@(posedge helper);
							@(posedge helper);
							@(posedge helper);
							@(posedge helper);
							@(posedge helper);
							@(posedge helper);
							@(posedge helper);
							@(posedge helper);
							@(posedge helper);
		 	rst = 1;		@(posedge helper);
		 	rst = 0;		@(posedge helper);
		
		
		$stop; // End the simulation.
	end
endmodule
