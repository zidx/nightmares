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

`include "flipflop.v"
`include "ClockDividerSchem.sv"

module DownCounterSchematic(
	rst, clk, out
);

input wire clk, rst;
output wire [3:0] out;

//wire	PIN_AB12;
//wire	PIN_AF14;

//wire	SYNTHESIZED_WIRE_28;
wire	SYNTHESIZED_WIRE_1;
//wire	SYNTHESIZED_WIRE_29;
//wire	SYNTHESIZED_WIRE_30;
wire	SYNTHESIZED_WIRE_31;
wire	SYNTHESIZED_WIRE_32;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_10;
//wire	SYNTHESIZED_WIRE_33;
wire	SYNTHESIZED_WIRE_15;
wire	SYNTHESIZED_WIRE_18;
wire	SYNTHESIZED_WIRE_19;
wire	SYNTHESIZED_WIRE_20;
//wire	SYNTHESIZED_WIRE_34;
wire	SYNTHESIZED_WIRE_22;
wire	SYNTHESIZED_WIRE_24;
wire	SYNTHESIZED_WIRE_26;


//assign PIN_AF14 = clk;
//assign SYNTHESIZED_WIRE_34 = clk;
//assign PIN_AB12 = rst;

//assign	out[3] = SYNTHESIZED_WIRE_33;
//assign	out[2] = SYNTHESIZED_WIRE_30;
//assign	out[1] = SYNTHESIZED_WIRE_29;
//assign	out[0] = SYNTHESIZED_WIRE_28;







assign	SYNTHESIZED_WIRE_31 = out[1] | out[0]; // SYNTHESIZED_WIRE_29 | SYNTHESIZED_WIRE_28;

assign	SYNTHESIZED_WIRE_10 = SYNTHESIZED_WIRE_31 & out[2]; // SYNTHESIZED_WIRE_30;

assign	SYNTHESIZED_WIRE_32 = SYNTHESIZED_WIRE_31 | out[2]; // SYNTHESIZED_WIRE_30;

assign	SYNTHESIZED_WIRE_9 =  ~SYNTHESIZED_WIRE_32;

assign	SYNTHESIZED_WIRE_24 = SYNTHESIZED_WIRE_9 | SYNTHESIZED_WIRE_10;

assign	SYNTHESIZED_WIRE_15 = SYNTHESIZED_WIRE_32 | out[3]; // SYNTHESIZED_WIRE_33;

assign	SYNTHESIZED_WIRE_18 = SYNTHESIZED_WIRE_32 & out[3]; // SYNTHESIZED_WIRE_33 ;

assign	SYNTHESIZED_WIRE_19 =  ~SYNTHESIZED_WIRE_15;


/*ClockDividerSchem	b2v_inst2(
	.clock(PIN_AF14),
	.out(SYNTHESIZED_WIRE_34));
	defparam	b2v_inst2.whichClock = 20;*/

assign	SYNTHESIZED_WIRE_1 = out[1] ^ out[0]; // SYNTHESIZED_WIRE_29 ^ SYNTHESIZED_WIRE_28;

assign	SYNTHESIZED_WIRE_26 = SYNTHESIZED_WIRE_18 | SYNTHESIZED_WIRE_19;



assign	SYNTHESIZED_WIRE_20 =  ~out[0]; // ~SYNTHESIZED_WIRE_28;

DFlipFlop	b2v_inst3(
	.D(SYNTHESIZED_WIRE_20),
	//.clk(SYNTHESIZED_WIRE_34),
	.clk(clk),
	//.rst(PIN_AB12),
	.rst(rst),
	//.q(SYNTHESIZED_WIRE_28)
	.q(out[0])
	);

assign	SYNTHESIZED_WIRE_22 =  ~SYNTHESIZED_WIRE_1;

DFlipFlop	b2v_inst4(
	.D(SYNTHESIZED_WIRE_22),
	//.clk(SYNTHESIZED_WIRE_34),
	.clk(clk),
	//.rst(PIN_AB12),
	.rst(rst),
	//.q(SYNTHESIZED_WIRE_29)
	.q(out[1])
	);


DFlipFlop	b2v_inst5(
	.D(SYNTHESIZED_WIRE_24),
	//.clk(SYNTHESIZED_WIRE_34),
	.clk(clk),
	//.rst(PIN_AB12),
	.rst(rst),
	//.q(SYNTHESIZED_WIRE_30)
	.q(out[2])
	);


DFlipFlop	b2v_inst6(
	.D(SYNTHESIZED_WIRE_26),
	//.clk(SYNTHESIZED_WIRE_34),
	.clk(clk),
	//.rst(PIN_AB12),
	.rst(rst),
	//.q(SYNTHESIZED_WIRE_33)
	.q(out[3]) 
	);


endmodule
