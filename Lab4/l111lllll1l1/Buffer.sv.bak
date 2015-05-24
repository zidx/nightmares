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
module Buffer (clock, reset, emptyBuffer, percent, inputValue, outputValue);
	input clock, reset, emptyBuffer;
	input [3:0] percent;
	input [7:0] inputValue;

	output reg [7:0] outputValue;
	
	 reg [7:0]	memory [9:0];	// 10 x 8 bit memory
	
	 //after number of clock cycles, ten percent of the buffer has filled
	 always @(posedge clock) begin
		if (reset) 
			outputValue = 0;
		else begin
			if (emptyBuffer)
				outputValue	= memory[percent];
			else begin
				memory [percent] = inputValue;
				outputValue = 0;
			end 
		end
	 end
	 
endmodule


