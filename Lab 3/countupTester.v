//-----------------------------------------------------------
// Module name:
// CountUpTester
//
// Description:
// Module implemented as part of testing system.
// Tests all possible states of CountUp.
// 
// Author(s):
// Krista Holden
//
//----------------------------------------------------------- 

module CountUpTester (count, hex);
  input [6:0] hex;
  output reg [3:0] count;
	
  parameter stimDelay = 20;
  
  initial // Response
  begin
    $display("\t\t count \t hex ");
	$monitor("\t\t %b \t %b", count, hex);
  end

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
