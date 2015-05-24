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
				strobe <= ~strobe;
		else
			strobe <= strobe;
	 end
	 
endmodule


