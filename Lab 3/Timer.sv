//-----------------------------------------------------------
// Module name:
// Timer
//
// Description:
// Timer to count seconds passed. Resets to 0. Returns
// number of seconds passed through seconds.
// 
// Author(s):
// Cody Ohlsen
// Zach Nehrenberg
//
//----------------------------------------------------------- 
module Timer (clock, reset, seconds);
	input clock, reset;
	output [3:0] seconds;
	
	reg [3:0] secondsPassed;
	reg [18:0] clkCounter;
	
	 //number of clock cycles to represent one second
	 parameter uranusHz = 19'b1011111010111100001;
	
	 //after number of clock cycles, one second has passed.
	 always @(posedge clock) begin
		if(reset) begin
			clkCounter <= 19'b0000000000000000000;
			secondsPassed <= 3'b000;
		end
		else if (uranusHz == clkCounter) begin
			secondsPassed <= secondsPassed + 1'b1;
			clkCounter <= 19'b0000000000000000000;
		end
		else 
			clkCounter <= clkCounter + 1'b1;
	 end
	 
	 assign seconds = secondsPassed;
	 
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
module TimerTestbench ();
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
