//-----------------------------------------------------------
// Module name:
// SynchronousUp
//
// Description:
// Module implemented as a synchronous up counter.
// Includes inputs reset and clock, and outputs the count.
// 
// Author(s):
// Krista Holden
//
//----------------------------------------------------------- 

module SynchronousUp(rst, clk, out);
	input clk, rst;
	output reg [3:0] out;
	
	parameter start = 4'b0000;
	
	initial out = start;
	
	always @(posedge clk) begin
		if(~rst) begin
			out <= start;
		end
		else begin
			out[0] <= ~out[0];
			out[1] <= out[1] ^ out[0];
			out[2] <= out[2] ^ (out[1] & out[0]);
			out[3] <= out[3] ^ (out[2] & out[1] & out[0]);
		end
	end

endmodule
