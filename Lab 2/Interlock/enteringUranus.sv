//-----------------------------------------------------------
// Module name:
// enteringUranus
//
// Description:
// State machine for entering the interlock. Returns output
// values to the DE_SoC1 to keep track of the current state.
// 
// Author(s):
// Cody Ohlsen
//
//----------------------------------------------------------- 
module enteringUranus(rst, rstCounter, clock, innerPort, outerPort, arriving, evac, pressurize, counterVal, display, canOut, canIn);

input clock;
input rst, innerPort, outerPort, arriving, evac, pressurize;
input [2:0] counterVal;

output reg rstCounter, canOut, canIn;
output reg [6:0] display;

reg[2:0] ps;
reg[2:0] ns;

wire fiveSec = counterVal[0];
wire sevenSec = counterVal[1];
wire eightSec = counterVal[2];

parameter 	defaultState 		= 3'b000,
			arriveTiming		= 3'b001,
			waitForEvacuate		= 3'b010,
			evacTiming		   	= 3'b011,
			waitForPressurize 	= 3'b100,
			pressurizeTiming  	= 3'b101,
			exit 				= 3'b110;
				
parameter  	a	 	= 7'b0001000;
parameter 	e		= 7'b0000110;
parameter 	p		= 7'b0001100;
parameter 	nothing = 7'b1111111;
				
always @(*) begin
	case(ps)
		defaultState:	begin
			canOut = 0;
			canIn = 1;
			display = nothing;
			if(arriving) begin
				ns = arriveTiming;
				rstCounter = 1;		//timing for next state begins
			end
			else begin
				ns = defaultState;
				rstCounter = 0;
			end
		end
		arriveTiming:	begin
			canOut = 0;
			canIn = 1;
			display = a;
			rstCounter = 0;			//brings down timer
			if(fiveSec)					//waits 5 seconds
				ns = waitForEvacuate;
			else
				ns = arriveTiming;
		end
		waitForEvacuate: 	begin	//waits for user to press evacuate
			canOut = 0;
			canIn = 1;
			display = nothing;
			if(evac && !innerPort && !outerPort) begin
				ns = evacTiming;
				rstCounter = 1;
			end
			else begin
				ns = waitForEvacuate;
				rstCounter = 0;
			end
		end
		evacTiming:	begin
			canOut = 0;
			canIn = 0;
			display = e;
			rstCounter = 0;			//brings down timer
			if(sevenSec)	//waits 5 seconds
				ns = waitForPressurize;
			else
				ns = evacTiming;
		end
		waitForPressurize: 	begin	//waits for user to press evacuate
			canOut = 1;
			canIn = 0;
			display = nothing;
			if(pressurize && !outerPort && !innerPort) begin
				ns = pressurizeTiming;
				rstCounter = 1;
			end
			else begin
				ns = waitForPressurize;
				rstCounter = 0;
			end
		end
		pressurizeTiming:	begin
			canOut = 0;
			canIn = 0;
			display = p;
			rstCounter = 0;			//brings down timer
			if(eightSec)			//waits eight seconds
				ns = exit;
			else
				ns = pressurizeTiming;
		end
		exit:	begin
			canOut = 0;
			canIn = 1;
			display = nothing;
			rstCounter = 0;			
			if(~arriving)			
				ns = defaultState;
			else
				ns = exit;
		end
		default: begin
			canOut = 0;
			canIn = 1;
			display = nothing;
			ns = defaultState;
			rstCounter = 0;
		end
	endcase
end

always @(posedge clock) begin
	if(rst)
		ps <= defaultState;
	else
		ps <= ns;
end
endmodule

//-----------------------------------------------------------
// Module name:
// enteringUranus_testbench
//
// Description:
// Testbench for enteringUranus. Tests all states for cycle
// as well as superfluous and errored input.
// 
// Author(s):
// Cody Ohlsen
//
//----------------------------------------------------------- 
module enteringUranus_testbench();
	// Inputs
	reg rst, clock;
	reg innerPort, outerPort, arriving, evac, pressurize;
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
	
	
	enteringUranus dut (rst, rstCounter, clock, innerPort, outerPort, arriving, evac, pressurize, counterVal, display);
	
	// We don't test opening and closing the ports when we're not supposed to.
	// This is because opening and closing them during operation is trivial.
	// Everyone would die anyway if you open them at the wrong time
	integer i;
	initial begin
		rst <= 1; innerPort <= 0; 			
		outerPort <= 0; arriving <= 0;
		counterVal <= 3'b000;
		evac <= 0; pressurize <= 0;			@(posedge clock);
		rst <= 0;							@(posedge clock);
		
		arriving <= 1;						@(posedge clock);
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
		outerPort <= 0; arriving <= 0; 		@(posedge clock);
		
		pressurize <= 1;					@(posedge clock);
		pressurize <= 0;					@(posedge clock);
		evac <= 1;							@(posedge clock);
		evac <= 0;							@(posedge clock);
		counterVal <= 3'b100;				@(posedge clock);
		counterVal <= 3'b000;				@(posedge clock);
											@(posedge clock);
											@(posedge clock);
		
		arriving <= 1;						@(posedge clock);
											@(posedge clock);
											@(posedge clock);
											@(posedge clock);
											@(posedge clock);
		
		$stop;
	end
endmodule
		
				
