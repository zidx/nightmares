module leavingUranus(rst, rstCounter, clock, innerPort, outerPort, leaving, evac, pressurize, counterVal);
	input clock, rst;
	input innerPort, outerPort, leaving, evac, pressurize;
	input [2:0] counterVal;

	output rstCounter;
	
	reg [2:0] ps;
	reg [2:0] ns;
	
	parameter s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100, s5 = 3'b101, s6 = 3'b110, s7 = 3'b111;
	
	always @(*) begin
		case(ps)
			s0: begin
				rstCounter = 0;
				if (~outerPort  & leaving) begin
					ns = s1;
					rstCounter = 1;
				end
				else ns = s0;
			end
			s1: begin
				rstCounter = 0;
				if (counterVal == 3'b001) ns = s2;
				else ns = s1;
			end
			s2: begin
				rstCounter = 0;
				if (~outerPort & ~innerPort & evac) begin
					rstCounter = 1;
					ns = s3;
				end
				else ns = s2;
			end
			s3: begin
				rstCounter = 0;
				if (counterVal == 3'b010) ns = s4;
				else ns = s3;
			end
			s4: begin
				rstCounter = 0;
				if (outerPort & ~innerPort) ns = s5;
				else ns = s4;
			end
			s5: begin
				rstCounter = 0;
				if (~outerPort & ~innerPort & ~leaving) ns = s6;
				else ns = s5;
			end
			s6: begin
				rstCounter = 0;
				if (~outerPort & ~innerPort & pressurize) begin
					rstCounter = 1;
					ns = s7;
				end
				else ns = s6;
			end
			s7: begin
				rstCounter = 0;
				if (counterVal == 3'b100) begin
					ns = s0;
				end
				else ns = s7;
			end
		endcase
	end
	
	always @(posedge clock) begin
		if (rst) ps <= s0;
		else ps <= ns;
	end
			
endmodule
