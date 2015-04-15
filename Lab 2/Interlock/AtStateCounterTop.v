//-----------------------------------------------------------
// Module name:
// UserInputTop
//
// Description:
// Module implemented as part of testing system.
// Test UserInput with UserInputTester module.
// 
// Author(s):
// Krista Holden
//
//-----------------------------------------------------------

`include "AtStateCounter.v"
`include "AtStateCounterTester.v"

module AtStateCounterTop ();
  // connect the two modules
  wire clk, in;
  wire [2:0] out;

  // declare an instance of the Johnson
  AtStateCounter myAtStateCounter (rst, clk, out);

  // declare an instance of the testIt module
  AtStateCounterTester myAtStateCounterTester (rst, clk, out);

  // file for gtkwave
  initial
  begin
    $dumpfile("AtStateCounter.vcd");
    $dumpvars(1,myAtStateCounter);
  end
endmodule
