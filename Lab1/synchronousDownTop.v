// Synchronous Down counter

`include "synchronousDown.v"

module testBench;
	wire clk, rst;
	wire [3:0] out;
	
	//declare instance of synchonous down counter.
	synchronousDown mySynchronousDown (rst, clk, out)

	// declare an instance of the testIt module
	Tester aTester (rst, clk, out);

	// file for gtkwave
	initial
	begin
		$dumpfile("johnson.vcd");
		$dumpvars(1,myJohnson);
	end
endmodule 