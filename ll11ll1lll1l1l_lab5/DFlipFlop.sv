//-----------------------------------------------------------
// Module name:
// DFlipFlop
//
// Description:
// Module implemented as a flip flop with active low reset.
// Includes input to clock and outputs q and qBar.
// 
// Author(s):
// Included file from EE371 Lab 1
//
// *NOTE: modified the always block assign statements to be
//        non-blocking statements for correct verilog usage.
//----------------------------------------------------------- 

module DFlipFlop(q,  D, clk, rst);
	input D, clk, rst;
	output q;
	reg q;
		always@ (posedge clk or posedge rst)
		begin  // Statements need to be non-blocking
			if(rst)
				q <= 0;
			else
				q <= D;
		end
endmodule