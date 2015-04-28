//-----------------------------------------------------------
// Module name:
// leavingUranus
//
// Description:
// State machine for leaving the interlock. Returns output
// values to the DE_SoC1 to keep track of the current state.
// 
// Author(s):
// Zach Nehrenberg
//
//----------------------------------------------------------- 
module leavingUranus(rst, rstCounter, clock, innerPort, outerPort, leaving, evac, pressurize, counterVal, display, canOut, canIn);
	input clock, rst;
	input innerPort, outerPort, leaving, evac, pressurize;
	input [2:0] counterVal;

	output reg rstCounter, canOut, canIn;
	output reg [6:0] display;
	
	reg [2:0] ps;
	reg [2:0] ns;
	
	parameter 	 defaultState = 3'b000, 
				 exitingTimer = 3'b001, 
				 exitingState = 3'b010, 
				 evacuateTimer = 3'b011, 
				 evacuateState = 3'b100, 
				 outerOpenState = 3'b101, 
				 pressurizeReady = 3'b110, 
				 pressurizingState = 3'b111;
				 
	parameter counterFive  = 3'b001;
	parameter counterSeven = 3'b010;
	parameter counterEight = 3'b100;
				 
	parameter  	l	 	= 7'b1000111;
	parameter 	e		= 7'b0000110;
	parameter 	p		= 7'b0001100;
	parameter 	nothing = 7'b1111111;
	
	always @(*) begin
		case(ps)
			defaultState: begin
				canOut = 0;
				canIn = 1;
				display = nothing;
				rstCounter = 0;
				if (~outerPort  & leaving) begin
					ns = exitingTimer;
					rstCounter = 1;
				end
				else ns = defaultState;
			end
			exitingTimer: begin
				canOut = 0;
				canIn = 1;
				display = l;
				rstCounter = 0;
				if (counterVal == counterFive) ns = exitingState;
				else ns = exitingTimer;
			end
			exitingState: begin
				canOut = 0;
				canIn = 1;
				display = nothing;
				rstCounter = 0;
				if (~outerPort & ~innerPort & evac) begin
					rstCounter = 1;
					ns = evacuateTimer;
				end
				else ns = exitingState;
			end
			evacuateTimer: begin
				canOut = 0;
				canIn = 0;
				display = e;
				rstCounter = 0;
				if (counterVal == counterSeven) ns = evacuateState;
				else ns = evacuateTimer;
			end
			evacuateState: begin
				canOut = 1;
				canIn = 0;
				display = nothing;
				rstCounter = 0;
				if (outerPort & ~innerPort) ns = outerOpenState;
				else ns = evacuateState;
			end
			outerOpenState: begin
				canOut = 1;
				canIn = 0;
				display = nothing;
				rstCounter = 0;
				if (~outerPort & ~innerPort & ~leaving) ns = pressurizeReady;
				else ns = outerOpenState;
			end
			pressurizeReady: begin
				canOut = 1;
				canIn = 0;
				display = nothing;
				rstCounter = 0;
				if (~outerPort & ~innerPort & pressurize) begin
					rstCounter = 1;
					ns = pressurizingState;
				end
				else ns = pressurizeReady;
			end
			pressurizingState: begin
				canOut = 0;
				canIn = 0;
				display = p;
				rstCounter = 0;
				if (counterVal == counterEight) begin
					ns = defaultState;
				end
				else ns = pressurizingState;
			end
			default: begin
				canOut = 0;
				canIn = 1;
				display = nothing;
				rstCounter = 0;
				ns = defaultState;
			end
		endcase
	end
	
	always @(posedge clock) begin
		if (rst) ps <= defaultState;
		else ps <= ns;
	end
			
endmodule


//-----------------------------------------------------------
// Module name:
// leavingUranus_testbench
//
// Description:
// Testbench for leavingUranus. Tests all states for cycle
// as well as superfluous and errored input.
// 
// Author(s):
// Zach Nehrenberg
//
//----------------------------------------------------------- 
module leavingUranus_testbench();
	// Inputs
	reg rst, clock;
	reg innerPort, outerPort, leaving, evac, pressurize;
	reg [2:0] counterVal;
	
	
	// Outputs
	reg rstCounter;
	reg [6:0] display;
	
	// Set up the clock. 
	parameter CLOCK_PERIOD=100; 
	initial clock=0;
	always begin 
		#(CLOCK_PERIOD/2); 
		clock = ~clock; 
	end
	
	
	leavingUranus dut (rst, rstCounter, clock, innerPort, outerPort, leaving, evac, pressurize, counterVal, display);
	
	// We don't test opening and closing the ports when we're not supposed to.
	// This is because opening and closing them during operation is trivial.
	// Everyone would die anyway if you open them at the wrong time
	integer i;
	initial begin
		rst <= 1; innerPort <= 0; 			
		outerPort <= 0; leaving <= 0;
		counterVal <= 3'b000;
		evac <= 0; pressurize <= 0;			@(posedge clock);
		rst <= 0;							@(posedge clock);
		
		leaving <= 1;						@(posedge clock);
		evac <= 1;							@(posedge clock);
		evac <= 0;							@(posedge clock);
		pressurize <= 1;					@(posedge clock);
		pressurize <= 0;					@(posedge clock);
		counterVal <= 3'b001;				@(posedge clock); // 5 seconds passed
		counterVal <= 3'b000;
												
		evac <= 1;							@(posedge clock);
		evac <= 0;							@(posedge clock);
		pressurize <= 1;					@(posedge clock);
		pressurize <= 0;					@(posedge clock);
		counterVal <= 3'b010;				@(posedge clock);
		counterVal <= 3'b000;				@(posedge clock);

												
			
		outerPort <= 1;						@(posedge clock);
		outerPort <= 0; leaving <= 0; 		@(posedge clock);
		
		pressurize <= 1;					@(posedge clock);
		pressurize <= 0;					@(posedge clock);
		evac <= 1;							@(posedge clock);
		evac <= 0;							@(posedge clock);
		counterVal <= 3'b100;				@(posedge clock);
		counterVal <= 3'b000;				@(posedge clock);
											@(posedge clock);
											@(posedge clock);
		
		leaving <= 1;						@(posedge clock);
											@(posedge clock);
											@(posedge clock);
											@(posedge clock);
											@(posedge clock);
		$stop;
	end
	
endmodule
	
