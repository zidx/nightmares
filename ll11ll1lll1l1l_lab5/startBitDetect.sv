// Detects the start bit, when the stream goes from a 
// high signal to a low signal
module startBitDetect(enable, rst, clk, bitStream, strobe);
	input clk, rst;
	input bitStream, strobe;
	output enable;
	
	// Registers to hold previous val
	reg ps;
	reg prevBit;
	
	// Make ps 1 once bitStream goes from high to low
	// If we get a strobe, it needs to be set back to 0
	always @(posedge clk) begin
		if (rst | strobe) begin
			prevBit <= 1;
			ps <= 0;
		end else begin
			prevBit <= bitStream;
			if (prevBit & ~bitStream)
				ps <= 1;
			else
				ps <= ps;
		end
	end

	// Make sure enable goes down at correct time
	assign enable = ps & ~rst;
endmodule

module startBitDetect_testbench();
	reg clk, rst;
	reg enable, bitStream;
	
	// Set up the clock. 
	parameter clkDur = 100;
	initial clk=0;
	always begin 
		#(clkDur/2); 
		clk = ~clk; 
	end
	
	startBitDetect dut (enable, rst, clk, bitStream);
	
	initial begin
			rst <= 1; bitStream <= 1;	@(posedge clk);
			rst <= 0;						@(posedge clk);
			repeat(4)						@(posedge clk);
			bitStream <= 1;				@(posedge clk);
			repeat(4)						@(posedge clk);
			rst <= 1;						@(posedge clk);
												@(posedge clk);
			rst <= 0;						@(posedge clk);
			repeat(14)						@(posedge clk);
			bitStream <= 1;				@(posedge clk);
			repeat(3)						@(posedge clk);
			rst <= 1;						@(posedge clk);
												@(posedge clk);
			rst <= 0;						@(posedge clk);
			repeat(11)						@(posedge clk);
			bitStream <= 0;				@(posedge clk);
			repeat(7)						@(posedge clk);
			bitStream <= 1;				@(posedge clk);
			repeat(7)						@(posedge clk);
			rst <= 1;						@(posedge clk);
												@(posedge clk);
			rst <= 0;						@(posedge clk);
			repeat(7)						@(posedge clk);

		$stop; // End the simulation.
	end
endmodule
