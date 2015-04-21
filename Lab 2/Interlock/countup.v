//-----------------------------------------------------------
// Module name:
// CountUp
//
// Description:
// Outputs the num seconds passed on the HEX.
// 
// Author(s):
// Krista Holden
//
//----------------------------------------------------------- 

module CountUp(count, hex);
	input  [3:0] count;
	output [6:0] hex;
	
	reg    [6:0] current;
		
	parameter c0 = 4'b0000;
	parameter c1 = 4'b0001;
	parameter c2 = 4'b0010;
	parameter c3 = 4'b0011;
	parameter c4 = 4'b0100;
	parameter c5 = 4'b0101;
	parameter c6 = 4'b0110;
	parameter c7 = 4'b0111;
	parameter c8 = 4'b1000;
	
	parameter nothing = 7'b1111111;
	parameter zero		= 7'b1000000;
	parameter one 		= 7'b1001111;
	parameter two 		= 7'b0100100;
	parameter three 	= 7'b0110000;
	parameter four 	= 7'b0011001;
	parameter five 	= 7'b0010010;
	parameter six 		= 7'b0000010;
	parameter seven 	= 7'b1111000;
	parameter eight 	= 7'b0000000;
	
	assign hex = current;
	
	initial current = nothing;
	
	always @(*) begin
		case(count)
			c0: current = nothing;
			c1: current = one;
			c2: current = two;
			c3: current = three;
			c4: current = four;
			c5: current = five;
			c6: current = six;
			c7: current = seven;
			c8: current = eight;
			default: current = nothing;
		endcase
	end
	
endmodule	
	