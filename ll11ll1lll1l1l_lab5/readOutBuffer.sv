module readOutBuffer(empty, outputStream, clk, rst, load, parallelIn);
	input clk, rst;
	input load;
	input [7:0] parallelIn;
	output empty, outputStream;

	// Buffer including leading 0 and trailing 1
	wire [9:0] inputBuffer;
	wire globalReset;
	reg [7:0] counter;
	
	assign globalReset = rst | ~load;
	assign inputBuffer = {1'b1, parallelIn, 1'b0};

	// Counter logic
	always @(posedge clk) begin
		if (rst | ~load) begin 
			counter <= 8'd0;
		end else if (counter == 8'b10011111) counter <= counter;
		else counter <= counter + 1'b1;
	end
	
	// Assign empty to be after the counter has iterated
	// 10 times, indicating it has passed through the buffer
	assign empty = (counter == 8'b10011111);
	
	// Assign outputStream
	// We need to make sure that outputStream is always 1 until
	// the first bit
	assign outputStream = inputBuffer[counter[7:4]] | globalReset;
endmodule

module readOutBuffer_testbench();
	reg clk, rst, load;	
	reg [7:0] parallelIn;
	wire empty, outputStream;
	
	// Set up the clock. 
	parameter clkDur = 100;
	initial clk=0;
	always begin 
		#(clkDur/2); 
		clk = ~clk; 
	end
	
	readOutBuffer dut (empty, outputStream, clk, rst, load, parallelIn);
	
	initial begin
			rst <= 1; load <= 0; 	  	
			parallelIn <= 7'b1001101; 
												@(posedge clk);
			rst <= 0;						@(posedge clk);
			repeat(10)						@(posedge clk);
			load <= 1; 
			repeat(16 * 11) 				@(posedge clk);
			
												@(posedge clk);
			load <= 0;						@(posedge clk);
			repeat(16 * 3)					@(posedge clk);
			load <= 1;						@(posedge clk);
												@(posedge clk);
												
			repeat(16 * 20) 				@(posedge clk);
			
			$stop; // End the simulation.
	end
endmodule
