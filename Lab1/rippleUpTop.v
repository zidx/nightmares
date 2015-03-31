// rippleUpTop.v

`include "rippleUp.v"

module testBench;

endmodule

module Tester(rst, clk, out);
	input clk, rst;
	output reg [3:0] out;
	
	paramater simDelay = 20;
	
	// Generate periodic clock signal
	always begin
		#simDelay clk = !clk;
	end
	
	initial  // Response
	begin
		$display("\t\t out \t rst \t clk \t Time ");
		$monitor("\t\t %b \t %b \t %b", out, rst, clk, $time );
	end
	
	initial  // Stimulus
	begin
		
endmodule