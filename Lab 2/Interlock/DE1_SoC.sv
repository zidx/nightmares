// Top Level module
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW); 
	 input CLOCK_50;
	 output reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
	 output [9:0] LEDR; 
	 input [3:0] KEY; 
	 input [9:0] SW; 
	 
	 reg [2:0] pCounter;
	 reg [2:0] nCounter;
	 
	 reg rstCounterEntering;
	 reg rstCounterExiting;
	 
	 //user input wire assignments
	 wire spacecraftArriving   =  SW[0];
	 wire spacecraftDeparting  =  SW[1];
	 wire outerPort				=  SW[2];
	 wire innerPort 				=  SW[3];
	 wire reset 					=  KEY[0];
	 wire pressurizeChamber    = ~KEY[1];
	 wire evacuateChamber 		= ~KEY[2];
	 wire [6:0] displayArrive	=  HEX0;
	 wire [6:0] displayDepart	=  HEX1;
	 
	 //User Input Wires
	 wire spacecraftArrivingUI;
	 wire spacecraftDepartingUI;
	 wire outerPortUI;
	 wire innerPortUI;
	 wire resetUI;
	 wire pressurizeChamberUI;
	 wire evacuateChamberUI;
	 
	 // Generate clk off of CLOCK_50, whichClock picks rate.
	 wire [31:0] clk;
	 
	 //clock 6 used in operation for the timer.
	 wire clock = clk[whichClock];
	 wire [3:0] numSeconds;
	 
	 wire [2:0] counterVal;
	 assign counterVal = {numSeconds == fiveSec, numSeconds == sevenSec, numSeconds == eightSec};	 
	 	 
	 //clock cycles for timer output to time number of seconds
	 parameter fiveSec  = 4'b0101;
	 parameter sevenSec = 4'b0111;
	 parameter eightSec = 4'b1000;
	 
	 //uses clock 6 to use the lowest whole number of Hz for exactly precise timing.
	 parameter whichClock = 6;
	 ClockDivider cdiv (CLOCK_50, clk);	 
	 
	 assign LEDR[0] = spacecraftArrivingUI;
	 assign LEDR[1] = spacecraftDepartingUI;
	 assign LEDR[2] = outerPortUI;
	 assign LEDR[3] = innerPortUI;
	 
	 assign LEDR[5] = numSeconds[0];
	 
	 //sends all asynchronous input through a DFF
	 DFlipFlop arriving (spacecraftArrivingUI , spacecraftArriving, clock, resetUI);
	 DFlipFlop departing (spacecraftDepartingUI, spacecraftDeparting, clock, resetUI );
	 DFlipFlop outPort (outerPortUI, outerPort, clock, resetUI );
	 DFlipFlop inPort (innerPortUI, innerPort, clock, resetUI );
	 
	 UserInput resetInput (clock, reset, resetUI );
	 UserInput pressurizeInput (clock, pressurizeChamber, pressurizeChamberUI );
	 UserInput evacuateInput (clock, evacuateChamber, evacuateChamberUI );
	  
	 //instantiates the timer to get the number of seconds
	 Timer secTimer  (clock, reset | rstCounterEntering | rstCounterExiting, numSeconds);	 
	 
	 //instantiate both State Machines
	 enteringUranus enteringInterlock (resetUI, rstCounterEntering, clock, innerPortUI, outerPortUI, spacecraftArrivingUI, evacuateChamberUI, pressurizeChamberUI, counterVal, HEX0);
	 leavingUranus  leavingInterlock  (resetUI, rstCounterExiting, clock, innerPortUI, outerPortUI, spacecraftDepartingUI, evacuateChamberUI, pressurizeChamberUI, counterVal);
	 
endmodule

module ClockDivider (clock, divided_clocks);
	 input clock;
	 output [31:0] divided_clocks;
	 reg [31:0] divided_clocks;

	 initial
	 divided_clocks = 0;

	 always @(posedge clock)
	 divided_clocks = divided_clocks + 1;
endmodule 