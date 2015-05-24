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
module Camera_testbench();
reg clock;
reg rst, rstBehavior, download;
reg [3:0] percentVal;
reg [2:0] inSignals;
reg [2:0] outSignals;
reg countNegative;
reg pauseCounter;
reg [6:0] display;
reg myStandby;
reg myFilm;
	
	// Set up the clock. 
	parameter CLOCK_PERIOD=100; 
	initial clock=0;
	always begin 
		#(CLOCK_PERIOD/2); 
		clock = ~clock; 
	end
	
	Camera dut (myStandby, myFilm, pauseCounter, countNegative, display, outSignals, rst, clock, download, inSignals, rstBehavior, percentVal);

	integer i;
	initial begin
		download <= 0;
		rstBehavior <= 0;
		rst <= 0; 
		@(posedge clock);
		rst <= 1;
		@(posedge clock);
		rst <= 0;
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		inSignals <= 3'b101;	//gets signal to enter standby from other camera
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		inSignals <= 3'b011; //gets signal to start film from other camera
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		percentVal <= 4'b0101;
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		percentVal <= 4'b1000;
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		percentVal <= 4'b1001;
		//begins download sequence 
		@(posedge clock);
		@(posedge clock);
		download <= 1; percentVal <= 4'b1010; //(download & (percentVal == tenSec)
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		percentVal <= 4'b0000;
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		
		//runs program again but through flush sequence
		download <= 0;
		rst <= 0; 
		@(posedge clock);
		rst <= 1;
		@(posedge clock);
		rst <= 0;
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		inSignals <= 3'b101;	//gets signal to enter standby from other camera
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		inSignals <= 3'b011; //gets signal to start film from other camera
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		percentVal <= 4'b0101;
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		percentVal <= 4'b1000;
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		percentVal <= 4'b1001;
		//begins download sequence 
		@(posedge clock);
		@(posedge clock);
		download <= 0; percentVal <= 4'b1010; //(percentVal == tenSec)
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		inSignals <= 3'b110; //signal that it is at 50 percetn and needs to flush
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		percentVal <= 4'b0000;	//done flushing
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		
		//runs program again but with different default reset behavior
		
		download <= 0;
		rstBehavior <= 1;
		rst <= 0; 
		@(posedge clock);
		rst <= 1;
		@(posedge clock);
		rst <= 0;
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		inSignals <= 3'b101;	//gets signal to enter standby from other camera
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		inSignals <= 3'b011; //gets signal to start film from other camera
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		percentVal <= 4'b0101;
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		percentVal <= 4'b1000;
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		percentVal <= 4'b1001;
		//begins download sequence 
		@(posedge clock);
		@(posedge clock);
		download <= 1; percentVal <= 4'b1010; //(download & (percentVal == tenSec)
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		percentVal <= 4'b0000;
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		
		//runs program again but through flush sequence with different rst behavior
		download <= 0;
		rst <= 0; 
		@(posedge clock);
		rst <= 1;
		@(posedge clock);
		rst <= 0;
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		inSignals <= 3'b101;	//gets signal to enter standby from other camera
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		inSignals <= 3'b011; //gets signal to start film from other camera
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		percentVal <= 4'b0101;
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		percentVal <= 4'b1000;
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		percentVal <= 4'b1001;
		//begins download sequence 
		@(posedge clock);
		@(posedge clock);
		download <= 0; percentVal <= 4'b1010; //(percentVal == tenSec)
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		inSignals <= 3'b110; //signal that it is at 50 percetn and needs to flush
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		percentVal <= 4'b0000;	//done flushing
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		
		$stop;
	end
endmodule
