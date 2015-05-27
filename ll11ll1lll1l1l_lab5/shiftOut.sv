//micropressesor will put the correct byte in byteIn, then call load until recieving the hemptea signal.
// this module sends the byte out in serial when load goes from low to high.
// reset should be activated when load goes down ( from micropressesor )

// 1.microprocessor fills byte in with info
// 2.microprocessor sends load
// 3.micropressesor waits for hemptea signal
// 4.micropressesor brings load down
// 5.the D has been sent
module shiftOut(out, hempTea, clk, rst, load, byteIn);
	input clk, rst;
	input load;
	input [7:0] byteIn;
	output out;
	output reg hempTea;

	//adds start and end bits to byte
	wire [9:0] signal;
	assign signal = { 1'b0, byteIn, 1'b1 };
	wire [3:0] index;
	wire enable;
	
	//when load goes from l to h enable.
	startBitDetect detectLoad (enable, clk, rst | hempTea, load);
	//begin counting
	fourBitCounter internalCounter (index, clk, rst, enable);

	assign out = signal[index] & enable;
	
	//when load goes from l to h enable.
	startBitDetect sentTheD (hempTea, clk, rst, index == 10);
//	the line above does this exact same thing as below
//	always @(posedge clk) begin
//		if(rst)
//			hempTea <= 0;
//		else if (index == 10)
//			hempTea <= 1;
//		else
//			hempTea <= hempTea;
//	end
endmodule