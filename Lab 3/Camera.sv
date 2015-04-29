//-----------------------------------------------------------
// Module name:
// Camera
//
// Description:
// State machine for entering the interlock. Returns output
// values to the DE_SoC1 to keep track of the current state.
// 
// Author(s):
// Cody Ohlsen
// Zach Nehrenberg
//
//----------------------------------------------------------- 
module Camera(myStandby, myFilm, pauseCounter, countNegative, display, outSignals, rst, clock, download, inSignals, rstBehavior, percentVal);

input clock;
input rst, rstBehavior, download;
input [3:0] percentVal;
input [2:0] inSignals;

// Signals
//	  111  =  nothing
//	  110  =  fifty percent
//	  101  =  send standby signal
//	  011  =  send filming signal
output reg [2:0] outSignals;

output reg countNegative;
output reg pauseCounter;
output reg [6:0] display;

output reg myStandby;
output reg myFilm;

reg[3:0] ps;
reg[3:0] ns;

parameter zeroSec 	= 4'b0000;
parameter fiveSec 	= 4'b0101;
parameter eightSec	= 4'b1000;
parameter nineSec 	= 4'b1001;
parameter tenSec 		= 4'b1010;

parameter fiftyPercent  = 3'b110;
parameter standbySignal = 3'b101;
parameter filmSignal		= 3'b011;
parameter noSignal		= 3'b111;

parameter 	lowPower			 		= 4'b0000,
				standBy					= 4'b0001,
				active	  		 		= 4'b0010,
				reaches50		   	= 4'b0011,
				signalToDownload	 	= 4'b0100,
				reaches90			  	= 4'b0101,
				downloading 			= 4'b0110,
				idle						= 4'b0111,
				flushing					= 4'b1000;
				
parameter  	low 		= 7'b1000111;
parameter 	hold		= 7'b0001001;
parameter   activeD  = 7'b0001000;
parameter   downloadD	= 7'b0100001;
parameter	idleD  	= 7'b0111111;
parameter	flush 	= 7'b0001110;
parameter	fifty 	= 7'b0010010;
parameter	eighty	= 7'b0000000;
parameter	ninty		= 7'b0011000;

always @(*) begin
	case(ps)
		lowPower: begin
			pauseCounter = 1;
			countNegative = 0;
			display = low;
			outSignals = noSignal;
			if (~myStandby)
				ns = standBy;
			else
				ns = lowPower;
		end
		standBy: begin
			pauseCounter = 1;
			countNegative = 0;
			display = hold;
			outSignals = noSignal;
			if (~myFilm)
				ns = active;
			else
				ns = standBy;
		end
		active: begin
			pauseCounter = 0;
			countNegative = 0;
			display = activeD;
			outSignals = noSignal;
			if (percentVal == fiveSec)
				ns = reaches50;
			else
				ns = active;
		end
		reaches50: begin
			pauseCounter = 0;
			countNegative = 0;
			display = fifty;
			outSignals = fiftyPercent;
			if (percentVal == eightSec)
				ns = signalToDownload;
			else
				ns = reaches50;
		end
		signalToDownload: begin
			pauseCounter = 0;
			countNegative = 0;
			display = eighty;
			outSignals = standbySignal;
			if (percentVal == nineSec)
				ns = reaches90;
			else
				ns = signalToDownload;
		end
		reaches90: begin
			pauseCounter = 0;
			countNegative = 0;
			display = ninty;
			outSignals = filmSignal;
			if(download & (percentVal == tenSec)) 
				ns = downloading;
			else if (percentVal == tenSec)
				ns = idle;
			else
				ns = reaches90;
		end
		idle: begin
			pauseCounter = 1;
			countNegative = 0;
			display = idleD;
			outSignals = noSignal;
			if(inSignals == fiftyPercent) 
				ns = flushing;
			else if (download)
				ns = downloading;
			else
				ns = idle;
		end
		downloading: begin
			pauseCounter = 0;
			countNegative = 1;
			display = downloadD;
			outSignals = noSignal;
			if(percentVal == zeroSec) 
				ns = lowPower;
			else
				ns = downloading;
		end
		flushing: begin
			pauseCounter = 0;
			countNegative = 1;
			display = flush;
			outSignals = noSignal;
			if(percentVal == zeroSec) 
				ns = lowPower;
			else
				ns = flushing;
		end
		default: begin
			pauseCounter = 1;
			countNegative = 0;
			display = low;
			outSignals = noSignal;
			ns = lowPower;
		end
	endcase
end

always @(posedge clock) begin
	if(rst & rstBehavior) begin
		ps <= active;
		myStandby = 1'b1;
		myFilm = 1'b1;
	end
	else if (rst) begin
		ps <= lowPower;
		myFilm = 1'b1;
		myStandby = 1'b1;
	end
	else begin
		ps <= ns;
		if (inSignals == standbySignal) myStandby <= 1'b0;
		else if (ps == standBy || ps == active) myStandby <= 1'b1;
		else myStandby = myStandby;
		
		if (inSignals == filmSignal) myFilm <= 1'b0;
		else if (ps == active) myFilm <= 1'b1;
		else myFilm = myFilm;
	end
end
endmodule

//-----------------------------------------------------------
// Module name:
// Camera_testbench
//
// Description:
// Testbench for Camera. Tests all states for cycle
// as well as superfluous and errored input.
// 
// Author(s):
// Cody Ohlsen
//
//----------------------------------------------------------- 
/*module Camera_testbench();
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
	
	
	Camera dut (rst, rstCounter, clock, innerPort, outerPort, arriving, evac, pressurize, counterVal, display);
	
	// We don't test opening and closing the ports when we're not supposed to.
	// This is because opening and closing them during operation is trivial.
	// Everyone would die anyway if you open them at the wrong time
	integer i;
	initial begin
		rst <= 1; innerPort <= 0; 			
		outerPort <= 0; arriving <= 0;
		counterVal <= 4'b0000;
		evac <= 0; pressurize <= 0;			@(posedge clock);
		rst <= 0;							@(posedge clock);
		
		arriving <= 1;						@(posedge clock);
		evac <= 1;							@(posedge clock);
		evac <= 0;							@(posedge clock);
		pressurize <= 1;					@(posedge clock);
		pressurize <= 0;					@(posedge clock);
		counterVal <= 4'b0001;				@(posedge clock); // 5 seconds passed
		counterVal <= 4'b0000;
												
		evac <= 1;							@(posedge clock);
		evac <= 0;							@(posedge clock);
		pressurize <= 1;					@(posedge clock);
		pressurize <= 0;					@(posedge clock);
		counterVal <= 4'b0010;				@(posedge clock);
		counterVal <= 4'b0000;				@(posedge clock);

												
			
		outerPort <= 1;						@(posedge clock);
		outerPort <= 0; arriving <= 0; 		@(posedge clock);
		
		pressurize <= 1;					@(posedge clock);
		pressurize <= 0;					@(posedge clock);
		evac <= 1;							@(posedge clock);
		evac <= 0;							@(posedge clock);
		counterVal <= 4'b0100;				@(posedge clock);
		counterVal <= 4'b0000;				@(posedge clock);
											@(posedge clock);
											@(posedge clock);
		
		arriving <= 1;						@(posedge clock);
											@(posedge clock);
											@(posedge clock);
											@(posedge clock);
											@(posedge clock);
		
		$stop;
	end
endmodule*/
		
				
