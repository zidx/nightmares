// johnsonTop.v
`include "johnson.v"
`include "tester.v"

module testBench;
  // connect the two modules
  wire clk, rst;
  wire [3:0] out;

  // declare an instance of the Johnson
  Johnson myJohnson (rst, clk, out);

  // declare an instance of the testIt module
  Tester aTester (rst, clk, out);

  // file for gtkwave
  initial
  begin
    $dumpfile("johnson.vcd");
    $dumpvars(1,myJohnson);
    end
endmodule 
