//at reset, seconds reset to zero. returns number of seconds
//active low reset
module Timer (clock, reset, seconds);
	input clock, reset;
	output [3:0] seconds;
	
	reg [3:0] secondsPassed;
	reg [18:0] clkCounter;
	
	 //number of clock cycles to represent one second
	 parameter uranusHz = 19'b1011111010111100001;
	
	 //after number of clock cycles, one second has passed.
	 always @(posedge clock) begin
		if(!reset) begin
			clkCounter <= 19'b0000000000000000000;
			secondsPassed <= 1'b0;
		end
		else if (uranusHz == clkCounter) begin
			secondsPassed <= secondsPassed + 1'b1;
			clkCounter <= 19'b0000000000000000000;
		end
		else 
			clkCounter <= clkCounter + 1'b1;
	 end
	 
	 assign seconds = secondsPassed;
	 
endmodule
