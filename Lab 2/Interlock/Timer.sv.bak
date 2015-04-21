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
	reg        clk, rst;
	wire [3:0] seconds;
	Timer dut (clk, rst, seconds);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial clk = 1;

	always begin 
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end
	
	initial rst = 0;
	
	initial begin
		#(CLOCK_PERIOD)		reset = 1;
		#(CLOCK_PERIOD / 2) 	reset = 0;
		#(CLOCK_PERIOD / 2) 	reset = 1;
		#(16 * CLOCK_PERIOD) 				in = 0;
		#(16 * CLOCK_PERIOD) 				in = 1;
		#(CLOCK_PERIOD);
		
		$stop; // End the simulation.
	end
endmodule
