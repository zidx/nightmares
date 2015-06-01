//-----------------------------------------------------------
// Module name:
// Percents
//
// Description:
// Buffer module holds data in a buffer. Data is stored and outputted
// to the user
// Author(s):
// Cody
// Krista 
// Zach
//----------------------------------------------------------- 
module Buffer (clock, reset, emptyBuffer, percent, inputValue, outputValue, strobe);
	input clock, reset, emptyBuffer;
	input [3:0] percent;
	input [7:0] inputValue;
	
	output reg strobe;
	output reg [7:0] outputValue;
	
	 reg previousPercentVal;
	 reg previousEmptyBuffer;
	 reg [7:0]	memory [9:0];	// 10 x 8 bit memory
	 
	 parameter full = 4'b1010;
	 
	 //after number of clock cycles, ten percent of the buffer has filled
	 always @(posedge clock) begin
	 previousPercentVal <= percent[0];
	 previousEmptyBuffer <= emptyBuffer;
		if (reset)  begin
			outputValue <= 0;
		end
		else begin
			if (emptyBuffer) begin
				outputValue	<= memory[percent];
			end
			else begin
				memory [percent] <= inputValue;
				outputValue <= 0;
			end 
		end
	 end
	 
	 always @(posedge clock) begin
		if ( (emptyBuffer & (percent[0] != previousPercentVal)) | (previousEmptyBuffer == 0 && emptyBuffer == 1) )
				strobe <= 1;
		else
			strobe <= 0;
	 end
	 
endmodule

module Buffer_testbench();
	reg clock, reset, emptyBuffer;
	reg [3:0] percent;
	reg [7:0] inputValue;
	
	wire strobe;
	wire [7:0] outputValue;
	
	parameter clkDur = 100;
	parameter full = 4'b1010;
	
	// Set up the clock. 
	initial clock=0;
	always begin 
		#(clkDur/2); 
		clock = ~clock; 
	end
	
	Buffer dut (clock, reset, emptyBuffer, percent, inputValue, outputValue, strobe);
	
	initial begin
		// Loading Data In
		emptyBuffer <= 0; inputValue = 8'b00000000; percent = 4'b0000;
		reset <= 1; @(posedge clock);		
		reset <= 0; @(posedge clock);
		repeat(9)  begin
			percent <= percent + 1;
			inputValue <= inputValue + 8'b00010001;
			@(posedge clock);
		end
		
		// Reading Data Out
		reset <= 1; @(posedge clock);		
		reset <= 0; emptyBuffer <= 1; inputValue = 8'b00000000; percent = 4'b0000; @(posedge clock);
		repeat(9)  begin
			percent <= percent + 1;
			inputValue <= inputValue + 8'b00010001;
			@(posedge clock);
		end
		
		emptyBuffer <= 0; @(posedge clock);
								@(posedge clock);
		
		$stop; // End the simulation.
	end

endmodule
