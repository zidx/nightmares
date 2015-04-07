module ClockDivider (clock, out);
	 input clock;
	 output out;
	 reg out;
	 reg [31:0] divided_clocks;

	 initial
	 divided_clocks = 0;

	 always @(posedge clock)
	 divided_clocks = divided_clocks + 1;
	 
	 parameter whichClock = 10;
	 assign out = divided_clocks[whichClock];
endmodule 