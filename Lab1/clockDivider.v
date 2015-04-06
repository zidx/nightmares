//-----------------------------------------------------------
// Module name:
// ClockDivider
//
// Description:
// Module used to divide a clock input into slower clocks
// for different clock timing options
// 
// Author(s):
// used from EE271
//
//----------------------------------------------------------- 

module ClockDivider (clock, divided_clocks);
 input clock;
 output [31:0] divided_clocks;
 reg [31:0] divided_clocks;

 // clock starts at 0
 initial
 divided_clocks = 0;

 // each clock cycle increments the 32 bit divider.
 always @(posedge clock)
 divided_clocks = divided_clocks + 1;
endmodule 