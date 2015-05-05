//-----------------------------------------------------------
// Module name:
// CountUp
//
// Description:
// Outputs the percentage that a camera's buffer is full on
// the HEX displays. Only outpus one digit
// 
// Author(s):
// Krista Holden
// Zach Nehrenberg
//
//----------------------------------------------------------- 

module CountUp(count, hex);
	input  [3:0] count;
	output reg [6:0] hex;

	
	// State encodings
	parameter c0  = 4'b0000;
	parameter c1  = 4'b0001;
	parameter c2  = 4'b0010;
	parameter c3  = 4'b0011;
	parameter c4  = 4'b0100;
	parameter c5  = 4'b0101;
	parameter c6  = 4'b0110;
	parameter c7  = 4'b0111;
	parameter c8  = 4'b1000;
	parameter c9  = 4'b1001;
	parameter c10 = 4'b1010;
	
	// outputs to the HEX displays
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
	parameter nine		= 7'b0011000;
	parameter ten		= 7'b0100010;
	
	always @(*) begin
		case(count)
			c0:  hex = nothing;
			c1:  hex = one;
			c2:  hex = two;
			c3:  hex = three;
			c4:  hex = four;
			c5:  hex = five;
			c6:  hex = six;
			c7:  hex = seven;
			c8:  hex = eight;
			c9:  hex = nine;
			c10: hex = ten;
			default: hex = nothing;
		endcase
	end
endmodule	

//-----------------------------------------------------------
// Module name:
// CountUp
//
// Description:
// Module implemented as part of testing system.
// Tests all possible states of CountUp.
// 
// Author(s):
// Krista Holden
//
//----------------------------------------------------------- 
module CountUpTestbench ();
	reg [6:0] hex;
   reg [3:0] count;
	
	parameter stimDelay = 20;
	
	CountUp dut (count, hex);
	
   initial // Stimulus
   begin
	 #stimDelay count = 4'b0000;
	 #stimDelay count = 4'b0001;
	 #stimDelay count = 4'b0010;
	 #stimDelay count = 4'b0011;
	 #stimDelay count = 4'b0100;
	 #stimDelay count = 4'b0101;
	 #stimDelay count = 4'b0110;
	 #stimDelay count = 4'b0111;
	 #stimDelay count = 4'b1000;
	 #stimDelay count = 4'b1001;
	 #stimDelay count = 4'b1010;
	 #stimDelay count = 4'b1011;
	 #stimDelay count = 4'b1100;
	 #stimDelay count = 4'b1101;
	 #stimDelay count = 4'b1110;
	 #stimDelay count = 4'b1111;
	 #stimDelay count = 4'b0000;
	 
    #(4*stimDelay); // needed to see END of simulation
    $finish; // finish simulation
  end
endmodule
