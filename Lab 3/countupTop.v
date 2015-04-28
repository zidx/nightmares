//-----------------------------------------------------------
// Module name:
// CountUpTop
//
// Description:
// Module implemented as part of testing system.
// Test CountUp with CountUpTester module.
// 
// Author(s):
// Krista Holden
//
//-----------------------------------------------------------

`include "countup.v"
`include "countupTester.v"

module UserInputTop ();
  // connect the two modules
  wire [3:0] count;
  wire [6:0] hex;

  // declare an instance of the Johnson
  CountUp myCountUp (count, hex);

  // declare an instance of the testIt module
  CountUpTester myCountUpTester (count, hex);

  // file for gtkwave
  initial
  begin
    $dumpfile("CountUp.vcd");
    $dumpvars(1,myCountUp);
  end
endmodule
