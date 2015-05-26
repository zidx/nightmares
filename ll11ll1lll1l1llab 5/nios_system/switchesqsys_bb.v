
module switchesqsys (
	clk_clk,
	reset_reset_n,
	switches_export,
	leds_export,
	readytodownload_export,
	outsignal_export,
	curbyteout_export,
	instrobe_export,
	load_export,
	curbytein_export,
	empty_export);	

	input		clk_clk;
	input		reset_reset_n;
	input	[7:0]	switches_export;
	output	[7:0]	leds_export;
	input		readytodownload_export;
	output	[1:0]	outsignal_export;
	output	[7:0]	curbyteout_export;
	input		instrobe_export;
	output		load_export;
	input	[7:0]	curbytein_export;
	input		empty_export;
endmodule
