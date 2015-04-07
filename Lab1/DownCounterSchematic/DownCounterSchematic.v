// Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, the Altera Quartus II License Agreement,
// the Altera MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Altera and sold by Altera or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 14.0.0 Build 200 06/17/2014 SJ Full Version"
// CREATED		"Mon Apr 06 17:05:57 2015"

module DownCounterSchematic(
	PIN_AB12,
	PIN_AF14,
	PIN_V18,
	PIN_V17,
	PIN_W16,
	PIN_V16
);


input wire	PIN_AB12;
input wire	PIN_AF14;
output wire	PIN_V18;
output wire	PIN_V17;
output wire	PIN_W16;
output wire	PIN_V16;

wire	SYNTHESIZED_WIRE_28;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_29;
wire	SYNTHESIZED_WIRE_30;
wire	SYNTHESIZED_WIRE_31;
wire	SYNTHESIZED_WIRE_32;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_33;
wire	SYNTHESIZED_WIRE_15;
wire	SYNTHESIZED_WIRE_18;
wire	SYNTHESIZED_WIRE_19;
wire	SYNTHESIZED_WIRE_20;
wire	SYNTHESIZED_WIRE_34;
wire	SYNTHESIZED_WIRE_22;
wire	SYNTHESIZED_WIRE_24;
wire	SYNTHESIZED_WIRE_26;

assign	PIN_V18 = SYNTHESIZED_WIRE_33;
assign	PIN_V17 = SYNTHESIZED_WIRE_30;
assign	PIN_W16 = SYNTHESIZED_WIRE_29;
assign	PIN_V16 = SYNTHESIZED_WIRE_28;



assign	SYNTHESIZED_WIRE_20 =  ~SYNTHESIZED_WIRE_28;

assign	SYNTHESIZED_WIRE_22 =  ~SYNTHESIZED_WIRE_1;

assign	SYNTHESIZED_WIRE_31 = SYNTHESIZED_WIRE_29 | SYNTHESIZED_WIRE_28;

assign	SYNTHESIZED_WIRE_10 = SYNTHESIZED_WIRE_30 & SYNTHESIZED_WIRE_31;

assign	SYNTHESIZED_WIRE_32 = SYNTHESIZED_WIRE_31 | SYNTHESIZED_WIRE_30;

assign	SYNTHESIZED_WIRE_9 =  ~SYNTHESIZED_WIRE_32;

assign	SYNTHESIZED_WIRE_24 = SYNTHESIZED_WIRE_9 | SYNTHESIZED_WIRE_10;

assign	SYNTHESIZED_WIRE_15 = SYNTHESIZED_WIRE_32 | SYNTHESIZED_WIRE_33;

assign	SYNTHESIZED_WIRE_18 = SYNTHESIZED_WIRE_33 & SYNTHESIZED_WIRE_32;

assign	SYNTHESIZED_WIRE_19 =  ~SYNTHESIZED_WIRE_15;


ClockDivider	b2v_inst2(
	.clock(PIN_AF14),
	.out(SYNTHESIZED_WIRE_34));
	defparam	b2v_inst2.whichClock = 20;

assign	SYNTHESIZED_WIRE_1 = SYNTHESIZED_WIRE_29 ^ SYNTHESIZED_WIRE_28;

assign	SYNTHESIZED_WIRE_26 = SYNTHESIZED_WIRE_18 | SYNTHESIZED_WIRE_19;


DFlipFlop	b2v_inst3(
	.D(SYNTHESIZED_WIRE_20),
	.clk(SYNTHESIZED_WIRE_34),
	.rst(PIN_AB12),
	.q(SYNTHESIZED_WIRE_28)
	);


DFlipFlop	b2v_inst4(
	.D(SYNTHESIZED_WIRE_22),
	.clk(SYNTHESIZED_WIRE_34),
	.rst(PIN_AB12),
	.q(SYNTHESIZED_WIRE_29)
	);


DFlipFlop	b2v_inst5(
	.D(SYNTHESIZED_WIRE_24),
	.clk(SYNTHESIZED_WIRE_34),
	.rst(PIN_AB12),
	.q(SYNTHESIZED_WIRE_30)
	);


DFlipFlop	b2v_inst6(
	.D(SYNTHESIZED_WIRE_26),
	.clk(SYNTHESIZED_WIRE_34),
	.rst(PIN_AB12),
	.q(SYNTHESIZED_WIRE_33)
	);


endmodule
