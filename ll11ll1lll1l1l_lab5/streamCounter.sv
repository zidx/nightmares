// Streamd Counter is an 8 bit counter that sends output signals
// every 16 clock cylces to propegate a DFF, and a strobe once
// it has sent out the sampleBit 9 times
module streamCounter(sampleBit, strobe, rst, clk, enable);
	input rst, clk;
	input enable;
	output sampleBit;
	output strobe;
	
	// 8 bit counter
	reg [7:0] counter;
	
	// Counter counts up only once.
	// Resets to 1 instead of 0, because enable
	// comes in one clock cycle late. This mitigates
	// the problem of being one clock cycle late
	always @(posedge clk) begin
		if (rst | ~enable) counter <= 8'd1;
		else if (counter == 8'b11111111) counter <= counter;
		else counter <= counter + 1'b1;
	end
	
	// Assign the sampleBit to occur every 16 clock cycles
   // and the strobe to occur once the 10th bit has passed in
	assign sampleBit = (counter[3:0] == 4'b0111) && (counter[7:4] < 4'b1001);
	assign strobe = (counter[7:0] == 8'b10010000);
	
	// If we have problems identifying the strobe then
	// switch to this....
	// assign strobe = (counter[7:4] == 4'b1001);
	
	
endmodule

module streamCounter_testbench();
	reg clk, rst, enable;	
	wire sampleBit, strobe;
	
	// Set up the clock. 
	parameter clkDur = 100;
	initial clk=0;
	always begin 
		#(clkDur/2); 
		clk = ~clk; 
	end
	
	streamCounter dut (sampleBit, strobe, rst, clk, enable);
	
	initial begin
			rst <= 1; enable <= 1;	  	@(posedge clk);
			rst <= 0;						@(posedge clk);
			
			repeat(16 * 11) 				@(posedge clk);
			
												@(posedge clk);
			enable <= 0;					@(posedge clk);
			repeat(16 * 3)					@(posedge clk);
			enable <= 1;					@(posedge clk);
												@(posedge clk);
												
			repeat(16 * 5) 				@(posedge clk);
			
			$stop; // End the simulation.
	end
endmodule
