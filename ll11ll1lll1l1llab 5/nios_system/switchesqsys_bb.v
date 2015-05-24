
module switchesqsys (
	clk_clk,
	reset_reset_n,
	switches_export,
	leds_export,
	readytodownload1_export,
	outsignal_export,
	curbyte1_export,
	readytodownload2_export,
	curbyte2_export);	

	input		clk_clk;
	input		reset_reset_n;
	input	[7:0]	switches_export;
	output	[7:0]	leds_export;
	input		readytodownload1_export;
	output	[1:0]	outsignal_export;
	input	[7:0]	curbyte1_export;
	input		readytodownload2_export;
	input	[7:0]	curbyte2_export;
endmodule
