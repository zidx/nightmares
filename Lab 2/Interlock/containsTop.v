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

`include "containsShip.v"
`include "containsTester.v"

module UserInputTop ();
  // connect the two modules
  wire clock, reset, shipDocked, arriving, departing, openDoor;

  // declare an instance of the Johnson
  ContainsShip myContains (clock, reset, shipDocked, arriving, departing, openDoor);

  // declare an instance of the testIt module
  ContainsShipTester myContainsTester (clock, reset, shipDocked, arriving, departing, openDoor);

  // file for gtkwave
  initial
  begin
    $dumpfile("ContainsShip.vcd");
    $dumpvars(1,myContains);
  end
endmodule
