	/*wire qBar1, qBar2, qBar3, qBar4, d0;
	
	DFlipFlop flip1(out[0], qBar1, d0, clk, rst);
	DFlipFlop flip2(out[1], qBar2, out[0], clk, rst);
	DFlipFlop flip3(out[2], qBar3, out[1], clk, rst);
	DFlipFlop flip4(out[3], qBar4, out[2], clk, rst);
	
	// Always logic to loop counter properly
	// Behavioural level
	always@(posedge clk)
		d0 <= ~out[3];*/