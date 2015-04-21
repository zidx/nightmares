module enteringUranus(rst, rstCounter, clock, innerPort, outerPort, arriving, evac, pressurize, counterVal, display);

input clock;
input rst, innerPort, outerPort, arriving, evac, pressurize;
input [2:0] counterVal;

output rstCounter;
output [6:0] display;

reg[2:0] ps;
reg[2:0] ns;

wire fiveSec = counterVal[0];
wire sevenSec = counterVal[1];
wire eightSec = counterVal[2];

parameter 	defaultState 		= 3'b000,
				arriveTiming		= 3'b001,
				waitForEvacuate	= 3'b010,
				evacTiming		   = 3'b011,
				waitForPressurize = 3'b100,
				pressurizeTiming  = 3'b101,
				exit 					= 3'b110;
				
parameter  	a	 	= 7'b0001000;
parameter 	e		= 7'b0000110;
parameter 	p		= 7'b0001100;
parameter 	nothing = 7'b1111111;
				
always @(*) begin
	case(ps)
		defaultState:	begin
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
			display = a;
			rstCounter = 0;			//brings down timer
			if(fiveSec)					//waits 5 seconds
				ns = waitForEvacuate;
			else
				ns = arriveTiming;
		end
		waitForEvacuate: 	begin	//waits for user to press evacuate
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
			display = e;
			rstCounter = 0;			//brings down timer
			if(sevenSec)	//waits 5 seconds
				ns = waitForPressurize;
			else
				ns = evacTiming;
		end
		waitForPressurize: 	begin	//waits for user to press evacuate
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
			display = p;
			rstCounter = 0;			//brings down timer
			if(eightSec)	//waits eight seconds
				ns = exit;
			else
				ns = pressurizeTiming;
		end
		exit:	begin
			display = nothing;
			rstCounter = 0;			//brings down timer
			if(~arriving)	//waits eight seconds
				ns = defaultState;
			else
				ns = exit;
		end
		default: begin
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
		
				