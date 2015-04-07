module DFlipFlop(q, qBar, D, clk, rst);
	input D, clk, rst;
	output q, qBar;
	reg q;
	not n1 (qBar, q);
		always@ (posedge clk) // Reset needs to be synchronous
		begin  // Statements need to be non-blocking
			if(rst)
				q <= D;
			else
				q <= 0;
		end
endmodule