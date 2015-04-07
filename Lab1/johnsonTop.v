//-----------------------------------------------------------
// Module name:
// testBench
//
// Description:
// Module implemented as part of testing system.
// Test Johnson counter with Tester module.
// 
// Author(s):
// Krista Holden
//
//-----------------------------------------------------------

`include "johnson.v"
`include "johnsonTester.v"

module testBench;
  // connect the two modules
  wire clk, rst;
  wire [3:0] out;

  // declare an instance of the Johnson
  Johnson myJohnson (rst, clk, out);

  // declare an instance of the testIt module
  JohnsonTester myJohnsonTester (rst, clk, out);

  // file for gtkwave
  initial
  begin
    $dumpfile("johnson.vcd");
    $dumpvars(1,myJohnson);
  end
endmodule 
