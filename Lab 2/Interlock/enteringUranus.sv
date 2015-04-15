module enteringUranus(rst, rstCounter, clock, innerPort, outerPort, arriving, evac, pressurize, counterVal);

input clock;
input rst, innerPort, outerPort, arriving, evac, pressurize;
input [2:0] counterVal;

output rstCounter;

reg[3:0] ps;
reg[3:0] ns;

wire fiveSec = counterVal[0];
wire sevenSec = counterVal[1];
wire eightSec = counterVal[2];

parameter 	defaultState 		= 3'b000,
				arriveTiming		= 3'b001,
				waitForEvacuate	= 3'b010,
				evacTiming		   = 3'b011,
				waitForPressurize = 3'b100,
				pressurizeTiming  = 3'b101;
				
always @(*) begin
	case(ps)
		defaultState:	begin
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
			rstCounter = 0;			//brings down timer
			if(fiveSec)	//waits 5 seconds
				ns = waitForEvacuate;
			else
				ns = arriveTiming;
		end
		waitForEvacuate: 	begin	//waits for user to press evacuate
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
			rstCounter = 0;			//brings down timer
			if(sevenSec)	//waits 5 seconds
				ns = waitForPressurize;
			else
				ns = evacTiming;
		end
		waitForPressurize: 	begin	//waits for user to press evacuate
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
			rstCounter = 0;			//brings down timer
			if(eightSec)	//waits eight seconds
				ns = defaultState;
			else
				ns = pressurizeTiming;
		end
		default: begin
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
		
				