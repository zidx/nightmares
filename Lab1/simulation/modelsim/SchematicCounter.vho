-- Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus II License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 14.0.0 Build 200 06/17/2014 SJ Full Version"

-- DATE "04/01/2015 20:38:56"

-- 
-- Device: Altera 5CSEMA5F31C6 Package FBGA896
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	DownCounterSchematic IS
    PORT (
	PIN_V18 : OUT std_logic;
	PIN_AF14 : IN std_logic;
	PIN_AB12 : IN std_logic;
	PIN_V17 : OUT std_logic;
	PIN_W16 : OUT std_logic;
	PIN_V16 : OUT std_logic
	);
END DownCounterSchematic;

-- Design Ports Information
-- PIN_V18	=>  Location: PIN_V18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PIN_V17	=>  Location: PIN_V17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PIN_W16	=>  Location: PIN_W16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PIN_V16	=>  Location: PIN_V16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PIN_AF14	=>  Location: PIN_AF14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PIN_AB12	=>  Location: PIN_AB12,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF DownCounterSchematic IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_PIN_V18 : std_logic;
SIGNAL ww_PIN_AF14 : std_logic;
SIGNAL ww_PIN_AB12 : std_logic;
SIGNAL ww_PIN_V17 : std_logic;
SIGNAL ww_PIN_W16 : std_logic;
SIGNAL ww_PIN_V16 : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \PIN_AF14~input_o\ : std_logic;
SIGNAL \PIN_AF14~inputCLKENA0_outclk\ : std_logic;
SIGNAL \inst3|q~0_combout\ : std_logic;
SIGNAL \PIN_AB12~input_o\ : std_logic;
SIGNAL \inst3|q~q\ : std_logic;
SIGNAL \inst4|q~q\ : std_logic;
SIGNAL \inst3|q~DUPLICATE_q\ : std_logic;
SIGNAL \inst20~combout\ : std_logic;
SIGNAL \inst4|q~DUPLICATE_q\ : std_logic;
SIGNAL \inst15~0_combout\ : std_logic;
SIGNAL \inst5|q~q\ : std_logic;
SIGNAL \inst21~0_combout\ : std_logic;
SIGNAL \inst6|q~q\ : std_logic;
SIGNAL \inst3|ALT_INV_q~DUPLICATE_q\ : std_logic;
SIGNAL \inst4|ALT_INV_q~DUPLICATE_q\ : std_logic;
SIGNAL \inst3|ALT_INV_q~q\ : std_logic;
SIGNAL \inst4|ALT_INV_q~q\ : std_logic;
SIGNAL \inst5|ALT_INV_q~q\ : std_logic;
SIGNAL \inst6|ALT_INV_q~q\ : std_logic;

BEGIN

PIN_V18 <= ww_PIN_V18;
ww_PIN_AF14 <= PIN_AF14;
ww_PIN_AB12 <= PIN_AB12;
PIN_V17 <= ww_PIN_V17;
PIN_W16 <= ww_PIN_W16;
PIN_V16 <= ww_PIN_V16;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\inst3|ALT_INV_q~DUPLICATE_q\ <= NOT \inst3|q~DUPLICATE_q\;
\inst4|ALT_INV_q~DUPLICATE_q\ <= NOT \inst4|q~DUPLICATE_q\;
\inst3|ALT_INV_q~q\ <= NOT \inst3|q~q\;
\inst4|ALT_INV_q~q\ <= NOT \inst4|q~q\;
\inst5|ALT_INV_q~q\ <= NOT \inst5|q~q\;
\inst6|ALT_INV_q~q\ <= NOT \inst6|q~q\;

-- Location: IOOBUF_X80_Y0_N2
\PIN_V18~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst6|q~q\,
	devoe => ww_devoe,
	o => ww_PIN_V18);

-- Location: IOOBUF_X60_Y0_N2
\PIN_V17~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst5|q~q\,
	devoe => ww_devoe,
	o => ww_PIN_V17);

-- Location: IOOBUF_X52_Y0_N19
\PIN_W16~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst4|q~DUPLICATE_q\,
	devoe => ww_devoe,
	o => ww_PIN_W16);

-- Location: IOOBUF_X52_Y0_N2
\PIN_V16~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst3|q~q\,
	devoe => ww_devoe,
	o => ww_PIN_V16);

-- Location: IOIBUF_X32_Y0_N1
\PIN_AF14~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_PIN_AF14,
	o => \PIN_AF14~input_o\);

-- Location: CLKCTRL_G6
\PIN_AF14~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \PIN_AF14~input_o\,
	outclk => \PIN_AF14~inputCLKENA0_outclk\);

-- Location: LABCELL_X55_Y1_N27
\inst3|q~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst3|q~0_combout\ = ( !\inst3|q~q\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111000000000000000011111111111111110000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => \inst3|ALT_INV_q~q\,
	combout => \inst3|q~0_combout\);

-- Location: IOIBUF_X12_Y0_N18
\PIN_AB12~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_PIN_AB12,
	o => \PIN_AB12~input_o\);

-- Location: FF_X55_Y1_N29
\inst3|q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PIN_AF14~inputCLKENA0_outclk\,
	d => \inst3|q~0_combout\,
	clrn => \PIN_AB12~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst3|q~q\);

-- Location: FF_X55_Y1_N31
\inst4|q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PIN_AF14~inputCLKENA0_outclk\,
	d => \inst20~combout\,
	clrn => \PIN_AB12~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst4|q~q\);

-- Location: FF_X55_Y1_N28
\inst3|q~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PIN_AF14~inputCLKENA0_outclk\,
	d => \inst3|q~0_combout\,
	clrn => \PIN_AB12~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst3|q~DUPLICATE_q\);

-- Location: LABCELL_X55_Y1_N30
inst20 : cyclonev_lcell_comb
-- Equation(s):
-- \inst20~combout\ = ( \inst4|q~q\ & ( \inst3|q~DUPLICATE_q\ ) ) # ( !\inst4|q~q\ & ( !\inst3|q~DUPLICATE_q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111000000000000000000000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => \inst4|ALT_INV_q~q\,
	dataf => \inst3|ALT_INV_q~DUPLICATE_q\,
	combout => \inst20~combout\);

-- Location: FF_X55_Y1_N32
\inst4|q~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PIN_AF14~inputCLKENA0_outclk\,
	d => \inst20~combout\,
	clrn => \PIN_AB12~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst4|q~DUPLICATE_q\);

-- Location: LABCELL_X55_Y1_N21
\inst15~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst15~0_combout\ = ( \inst5|q~q\ & ( \inst4|q~q\ ) ) # ( \inst5|q~q\ & ( !\inst4|q~q\ & ( \inst3|q~q\ ) ) ) # ( !\inst5|q~q\ & ( !\inst4|q~q\ & ( !\inst3|q~q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111100000000000000001111111100000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \inst3|ALT_INV_q~q\,
	datae => \inst5|ALT_INV_q~q\,
	dataf => \inst4|ALT_INV_q~q\,
	combout => \inst15~0_combout\);

-- Location: FF_X55_Y1_N22
\inst5|q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PIN_AF14~inputCLKENA0_outclk\,
	d => \inst15~0_combout\,
	clrn => \PIN_AB12~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst5|q~q\);

-- Location: LABCELL_X55_Y1_N54
\inst21~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst21~0_combout\ = ( \inst6|q~q\ & ( \inst5|q~q\ ) ) # ( \inst6|q~q\ & ( !\inst5|q~q\ & ( (\inst4|q~DUPLICATE_q\) # (\inst3|q~q\) ) ) ) # ( !\inst6|q~q\ & ( !\inst5|q~q\ & ( (!\inst3|q~q\ & !\inst4|q~DUPLICATE_q\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111000000000000000011111111111100000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \inst3|ALT_INV_q~q\,
	datad => \inst4|ALT_INV_q~DUPLICATE_q\,
	datae => \inst6|ALT_INV_q~q\,
	dataf => \inst5|ALT_INV_q~q\,
	combout => \inst21~0_combout\);

-- Location: FF_X55_Y1_N55
\inst6|q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PIN_AF14~inputCLKENA0_outclk\,
	d => \inst21~0_combout\,
	clrn => \PIN_AB12~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst6|q~q\);

-- Location: LABCELL_X56_Y13_N3
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


