// Reads serial data in and outputs it as parallel data.
// Uses the sample bit to shift the register
module ReadInBuffer(charOut, rst, clk, sampleBit, in);
	input rst, clk;
	input sampleBit, in;
	output [7:0] charOut;
	
	// If we are losing data, use the strobe to save the previous
	// data on the strobe so that when it is accessed it is
	// still good
	
	wire in0, in1, in2, in3, in4, in5, in6, in7, in8;
	
	DFlipFlopS d0 (in0, in, clk, rst, sampleBit);
	DFlipFlopS d1 (in1, in0, clk, rst, sampleBit);
	DFlipFlopS d2 (in2, in1, clk, rst, sampleBit);
	DFlipFlopS d3 (in3, in2, clk, rst, sampleBit);
	DFlipFlopS d4 (in4, in3, clk, rst, sampleBit);
	DFlipFlopS d5 (in5, in4, clk, rst, sampleBit);
	DFlipFlopS d6 (in6, in5, clk, rst, sampleBit);
	DFlipFlopS d7 (in7, in6, clk, rst, sampleBit);
	DFlipFlopS d8 (in8, in7, clk, rst, sampleBit);
	
	assign charOut = {in0, in1, in2, in3, in4, in5, in6, in7};
endmodule

module ReadInBuffer_testbench();
	reg rst, clk;
	reg [7:0] charOut;
	reg in;
	reg sampleBit;
	
	// Set up the clock. 
	parameter clkDur = 100;
	initial clk=0;
	always begin 
		#(clkDur/2); 
		clk = ~clk; 
	end
	
	parameter sampleDur = clkDur * 4;
	initial sampleBit = 0;
	always begin
		#(sampleDur/4);
		sampleBit = ~sampleBit;
	end
	
	ReadInBuffer dut (charOut, rst, clk, sampleBit, in);
	
	initial begin
			rst <= 1; in <= 0; 			@(posedge clk);
			rst <= 0;						@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
			in <= 1;							@(posedge sampleBit);
			in <= 0;							@(posedge sampleBit);
			in <= 1;							@(posedge sampleBit);
			in <= 0;							@(posedge sampleBit);
												@(posedge sampleBit);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
			in <= 1;							@(posedge sampleBit);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
			rst <= 1;						@(posedge sampleBit);
			rst <= 0;						@(posedge sampleBit);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
			$stop; // End the simulation.
	end
endmodule
