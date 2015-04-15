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

`include "UserInput.v"
`include "UserInputTester.v"

module UserInputTop ();
  // connect the two modules
  wire clk, in, pressed;

  // declare an instance of the Johnson
  UserInput myUserInput (clk, in, pressed);

  // declare an instance of the testIt module
  UserInputTester myUserInputTester (clk, in, pressed);

  // file for gtkwave
  initial
  begin
    $dumpfile("UserInput.vcd");
    $dumpvars(1,myUserInput);
  end
endmodule
