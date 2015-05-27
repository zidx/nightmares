// Continuousely signals that a control should startBitDetect
// counting until it recieves a reset signal to go to low
module startBitDetect(enable, clk, rst, in);
	input clk, rst;
	input in;
	output enable;
	
	always @(posedge clk) begin
		if (rst) enable <= 0;
		else begin
			if (in) enable <= 1;
			else enable <= enable;
		end
	end
endmodule
