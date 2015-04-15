//-----------------------------------------------------------
// Module name:
// UserInput
//
// Description:
// Keeps track of button presses to ignore if the button
// is held down.
// 
// Author(s):
// Krista Holden
//
//----------------------------------------------------------- 

module UserInput (clk, in, pressed);
	input clk, in;
	output pressed;

	reg prev;

	assign pressed = ~prev && in;
 
	// Setting the previous
	always @(posedge clk) begin
		prev <= in;
	end
endmodule