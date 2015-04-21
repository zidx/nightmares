//-----------------------------------------------------------
// Module name:
// TimerTester
//
// Description:
// Module implemented as part of testing system.
// Tests all possible states of UserInput.
// 
// Author(s):
// Krista Holden
//
//----------------------------------------------------------- 

module TimerTester (clock, reset, seconds);
	input [3:0] seconds;
	output reset, clock;

	
	parameter stimDelay = 20;
	parameter ZERO = 19'b0000000000000000000;
	parameter ONE = 19'b1011111010111100001;
	
	always begin
		#stimDelay clock = ZERO;
		#stimDelay clock = ONE;
	end
  
	initial // Response
	begin
		$display("\t\t seconds \t clock \t reset \t Time ");
		$monitor("\t\t %b \t %b \t %b", seconds, clock, reset, $time );
	end

	initial // Stimulus
	begin
					reset = 0; clock = ZERO;
		#stimDelay		reset = 1;
		#(stimDelay / 2) 	reset = 0;
		#(stimDelay / 2) 	reset = 1;
		#(16 * stimDelay) 	in = 0;
		#(16 * stimDelay) 	in = 1;
		
		#(4*stimDelay); // needed to see END of simulation
		$finish; // finish simulation
	end
endmodule

