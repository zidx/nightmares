//-----------------------------------------------------------
// Module name:
// CountUpTester
//
// Description:
// Module implemented as part of testing system.
// Tests all possible states of ContainsShip.
// 
// Author(s):
// Krista Holden
//
//----------------------------------------------------------- 

module ContainsShipTester (clock, reset, shipDocked, arriving, departing, openDoor);
  input shipDocked;
  output reg clock, reset, openDoor, arriving, departing;  
	
  parameter stimDelay = 20;
  
  initial clock = 0;
  
  always begin
    #stimDelay clock = !clock;
  end
  
  initial // Response
  begin
    $display("\t\t clock \t reset \t openDoor \t arriving \t departing ");
	$monitor("\t\t %b \t %b", clock, reset, openDoor, arriving, departing);
  end

  initial // Stimulus
  begin
	openDoor = 0;	departing = 0;	arriving = 0;	reset = 1; // empty
	reset = 0;
	
	// Departing Cycle (nothing happens)
	#(3 * stimDelay) 	departing = 1;                             
	#stimDelay 			departing = 0;
	#stimDelay 		 	 openDoor = 1;
	#stimDelay 		 	 openDoor = 0;
	
	// Arriving Cycle (empty -> enter -> contains)
	#stimDelay 			arriving = 1;
	#stimDelay 			arriving = 0;
	#stimDelay 		 	openDoor = 1;
	#stimDelay 		 	openDoor = 0;
	
	// Opening The Door (nothing happens)
	#stimDelay 		 	openDoor = 1;
	#stimDelay 		 	openDoor = 0;
	
	// Arriving Again (nothing happens)
	#stimDelay 			arriving = 1;
	#stimDelay 			arriving = 0;
	#stimDelay 		 	openDoor = 1;
	#stimDelay 		 	openDoor = 0;
	
	// Departing Cycle (contains -> exit -> empty)
	#(3 * stimDelay) 	departing = 1;                             
	#stimDelay 			departing = 0;
	#stimDelay 		 	openDoor = 1;
	#stimDelay 		 	openDoor = 0;
	
	// Opening The Door (nothing happens)
	#stimDelay 		 	openDoor = 1;
	#stimDelay 		 	openDoor = 0;
	
	// Signal Reset @ empty
	#stimDelay 		 	reset = 1;
	#stimDelay 		 	reset = 0;
	
	// Signal Reset @ enter
	#stimDelay 			arriving = 1;
	#stimDelay 			arriving = 0;
	#stimDelay 		 	reset = 1;
	#stimDelay 		 	reset = 0;
	
	// Signal Reset @ contains
	#stimDelay 			arriving = 1;
	#stimDelay 			arriving = 0;
	#stimDelay 		 	openDoor = 1;
	#stimDelay 		 	openDoor = 0;
	#stimDelay 		 	reset = 1;
	#stimDelay 		 	reset = 0;
	
	// Signal Reset @ exit
	#stimDelay 			arriving = 1;
	#stimDelay 			arriving = 0;
	#stimDelay 		 	openDoor = 1;
	#stimDelay 		 	openDoor = 0;
	#(3 * stimDelay) 	departing = 1;                             
	#stimDelay 			departing = 0;
	#stimDelay 		 	reset = 1;
	#stimDelay 		 	reset = 0;
	
	 
    #(4*stimDelay); // needed to see END of simulation
    $finish; // finish simulation
  end
endmodule 
