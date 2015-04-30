//-----------------------------------------------------------
// Module name:
// Camera
//
// Description:
// 
// Author(s):
// Cody Ohlsen
// Zach Nehrenberg
//
//----------------------------------------------------------- 
module Camera(myStandby, myFilm, pauseBuffer, emptyBuffer, display, outSignals, rst, clock, download, inSignals, rstBehavior, percentVal);

	input clock;
	input rst, rstBehavior, download;
	input [3:0] percentVal;
	input [2:0] inSignals;

	// Signals for output. A low signal on a
	// bit corresponds to active (active low)
	//	  111  =  nothing
	//	  110  =  fifty percent
	//	  101  =  send standby signal
	//	  011  =  send filming signal
	output reg [2:0] outSignals;
	
	// Outputs for the camera. See
	// DE1_SoC module for descriptions
	output reg emptyBuffer;
	output reg pauseBuffer;
	output reg [6:0] display;

	output reg myStandby;
	output reg myFilm;

	// Present state and next state of the
	// camera state machine
	reg[3:0] ps;
	reg[3:0] ns;

	// Parameters scoped just to this camera.
	// Helps the camera to know where it is at
	// based on the input of its percentVal of
	// its buffer.
	parameter zeroPercent 		= 4'b0000;
	parameter halfPercent 		= 4'b0101;
	parameter eightyPercent		= 4'b1000;
	parameter ninetyPercent 	= 4'b1001;
	parameter hundredPercent 	= 4'b1010;

	// Parameters outputted through the outSignals
	// to other cameras.
	parameter fiftyPercent  = 3'b110;
	parameter standbySignal = 3'b101;
	parameter filmSignal		= 3'b011;
	parameter noSignal		= 3'b111;

	// Encodings of the different states this 
	// camera can be in.
	parameter 	lowPower			 		= 4'b0000,
					standBy					= 4'b0001,
					active	  		 		= 4'b0010,
					reaches50		   	= 4'b0011,
					signalToDownload	 	= 4'b0100,
					reaches90			  	= 4'b0101,
					downloading 			= 4'b0110,
					idle						= 4'b0111,
					flushing					= 4'b1000;
	

	// Various outputs to the HEX display
	// to notify to the user what state this
	// camera is in
	parameter  	low 			= 7'b1000111;
	parameter 	hold			= 7'b0001001;
	parameter   activeD  	= 7'b0001000;
	parameter   downloadD	= 7'b0100001;
	parameter	idleD  		= 7'b0111111;
	parameter	flush 		= 7'b0001110;
	parameter	fifty 		= 7'b0010010;
	parameter	eighty		= 7'b0000000;
	parameter	ninty			= 7'b0011000;

	always @(*) begin
		case(ps)
			lowPower: begin
				pauseBuffer = 1;
				emptyBuffer = 0;
				display = low;
				outSignals = noSignal;
				if (~myStandby)
					ns = standBy;
				else
					ns = lowPower;
			end
			standBy: begin
				pauseBuffer = 1;
				emptyBuffer = 0;
				display = hold;
				outSignals = noSignal;
				if (~myFilm)
					ns = active;
				else
					ns = standBy;
			end
			active: begin
				pauseBuffer = 0;
				emptyBuffer = 0;
				display = activeD;
				outSignals = noSignal;
				if (percentVal == halfPercent)
					ns = reaches50;
				else
					ns = active;
			end
			reaches50: begin
				pauseBuffer = 0;
				emptyBuffer = 0;
				display = fifty;
				outSignals = fiftyPercent;
				if (percentVal == eightyPercent)
					ns = signalToDownload;
				else
					ns = reaches50;
			end
			signalToDownload: begin
				pauseBuffer = 0;
				emptyBuffer = 0;
				display = eighty;
				outSignals = standbySignal;
				if (percentVal == ninetyPercent)
					ns = reaches90;
				else
					ns = signalToDownload;
			end
			reaches90: begin
				pauseBuffer = 0;
				emptyBuffer = 0;
				display = ninty;
				outSignals = filmSignal;
				if(download & (percentVal == hundredPercent)) 
					ns = downloading;
				else if (percentVal == hundredPercent)
					ns = idle;
				else
					ns = reaches90;
			end
			idle: begin
				pauseBuffer = 1;
				emptyBuffer = 0;
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
				pauseBuffer = 0;
				emptyBuffer = 1;
				display = downloadD;
				outSignals = noSignal;
				if(percentVal == zeroPercent) 
					ns = lowPower;
				else
					ns = downloading;
			end
			flushing: begin
				pauseBuffer = 0;
				emptyBuffer = 1;
				display = flush;
				outSignals = noSignal;
				if(percentVal == zeroPercent) 
					ns = lowPower;
				else
					ns = flushing;
			end
			default: begin
				pauseBuffer = 1;
				emptyBuffer = 0;
				display = low;
				outSignals = noSignal;
				ns = lowPower;
			end
		endcase
	end

	always @(posedge clock) begin
		// Check if we are the starter clock. If we are,
		// we want to go imediately to the active state.
		// Otherwise we go to the low power state.
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
			// If we are not in reset behaviour get the next state on
			// each clock edge, and if we recieve a signal from another
			// camera, store that signal so we know to execute it when
			// it is possible for us to.
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
		counterVal <= 4'b0001;				@(posedge clock); // 5 Percentonds passed
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
		
				
