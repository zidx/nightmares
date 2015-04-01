// rippleUpTop.v
`include "rippleUp.v"
`include "tester.v"

module testBench;
  // connect the two modules
  wire clk, rst;
  wire [3:0] out;

  // declare an instance of the RippleUp
  RippleUp myRippleUp (rst, clk, out);

  // declare an instance of the testIt module
  Tester aTester (rst, clk, out);

  // file for gtkwave
  initial
  begin
    $dumpfile("myRippleUp.vcd");
    $dumpvars(1,myRippleUp);
    end
endmodule 
