// Continuousely signals that a control should startBitDetect
// counting until it recieves a reset signal to go to low
module startBitDetect(enable, clk, rst, in, counter);
	input clk, rst;
	input in;
	input [7:0] counter;
	output reg enable;
	reg [3:0] rstCount;
	
	always @(posedge clk) begin
		if (rst) begin
			enable <= 0;
			rstCount <= 0;
		end
		else if (rstCount < 4'd15) begin
			enable <= 0;
			rstCount <= rstCount + 1;
		end else begin
			if (in && counter < 8'b10010000) enable <= 1;
			else enable <= enable;
			rstCount <= 4'd15;
		end
	end
endmodule
