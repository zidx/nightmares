//-----------------------------------------------------------
// Module name:
// testBench
//
// Description:
// Module implemented as part of testing system.
// Test RippleUp counter with Tester module.
// 
// Author(s):
// Zach Nehrenburg
// Cody Ohlsen
//-----------------------------------------------------------

`include "rippleUp.v"
`include "rippleUpTester.v"

module testBench;
  // connect the two modules
  wire clk, rst;
  wire [3:0] out;

  // declare an instance of the RippleUp
  RippleUp myRippleUp (rst, clk, out);

  // declare an instance of the testIt module
  RippleUpTester aTester (rst, clk, out);

  // file for gtkwave
  initial
  begin
    $dumpfile("myRippleUp.vcd");
    $dumpvars(1,myRippleUp);
  end
endmodule 
