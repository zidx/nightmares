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

-- DATE "05/31/2015 19:17:20"

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

ENTITY 	readOutBuffer IS
    PORT (
	empty : BUFFER std_logic;
	outputStream : BUFFER std_logic;
	clk : IN std_logic;
	rst : IN std_logic;
	load : IN std_logic;
	parallelIn : IN std_logic_vector(7 DOWNTO 0)
	);
END readOutBuffer;

-- Design Ports Information
-- empty	=>  Location: PIN_AK2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outputStream	=>  Location: PIN_AB13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rst	=>  Location: PIN_AK4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- load	=>  Location: PIN_AJ4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- parallelIn[3]	=>  Location: PIN_AE14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- parallelIn[4]	=>  Location: PIN_AJ5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- parallelIn[5]	=>  Location: PIN_AK6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- parallelIn[6]	=>  Location: PIN_AD14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- parallelIn[0]	=>  Location: PIN_AA13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- parallelIn[7]	=>  Location: PIN_AK3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- parallelIn[1]	=>  Location: PIN_AF13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- parallelIn[2]	=>  Location: PIN_AE13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_AB27,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF readOutBuffer IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_empty : std_logic;
SIGNAL ww_outputStream : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_rst : std_logic;
SIGNAL ww_load : std_logic;
SIGNAL ww_parallelIn : std_logic_vector(7 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputCLKENA0_outclk\ : std_logic;
SIGNAL \Add0~17_sumout\ : std_logic;
SIGNAL \load~input_o\ : std_logic;
SIGNAL \rst~input_o\ : std_logic;
SIGNAL \globalReset~combout\ : std_logic;
SIGNAL \Add0~18\ : std_logic;
SIGNAL \Add0~13_sumout\ : std_logic;
SIGNAL \Add0~14\ : std_logic;
SIGNAL \Add0~21_sumout\ : std_logic;
SIGNAL \Add0~22\ : std_logic;
SIGNAL \Add0~25_sumout\ : std_logic;
SIGNAL \Add0~26\ : std_logic;
SIGNAL \Add0~29_sumout\ : std_logic;
SIGNAL \Add0~30\ : std_logic;
SIGNAL \Add0~5_sumout\ : std_logic;
SIGNAL \Add0~6\ : std_logic;
SIGNAL \Add0~9_sumout\ : std_logic;
SIGNAL \Add0~10\ : std_logic;
SIGNAL \Add0~1_sumout\ : std_logic;
SIGNAL \counter[1]~0_combout\ : std_logic;
SIGNAL \Equal0~0_combout\ : std_logic;
SIGNAL \Equal0~1_combout\ : std_logic;
SIGNAL \parallelIn[7]~input_o\ : std_logic;
SIGNAL \parallelIn[0]~input_o\ : std_logic;
SIGNAL \outputStream~0_combout\ : std_logic;
SIGNAL \parallelIn[3]~input_o\ : std_logic;
SIGNAL \parallelIn[6]~input_o\ : std_logic;
SIGNAL \parallelIn[5]~input_o\ : std_logic;
SIGNAL \parallelIn[4]~input_o\ : std_logic;
SIGNAL \Mux0~0_combout\ : std_logic;
SIGNAL \parallelIn[2]~input_o\ : std_logic;
SIGNAL \parallelIn[1]~input_o\ : std_logic;
SIGNAL \outputStream~1_combout\ : std_logic;
SIGNAL \outputStream~2_combout\ : std_logic;
SIGNAL counter : std_logic_vector(7 DOWNTO 0);
SIGNAL \ALT_INV_parallelIn[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_parallelIn[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_parallelIn[7]~input_o\ : std_logic;
SIGNAL \ALT_INV_parallelIn[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_parallelIn[6]~input_o\ : std_logic;
SIGNAL \ALT_INV_parallelIn[5]~input_o\ : std_logic;
SIGNAL \ALT_INV_parallelIn[4]~input_o\ : std_logic;
SIGNAL \ALT_INV_parallelIn[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_load~input_o\ : std_logic;
SIGNAL \ALT_INV_rst~input_o\ : std_logic;
SIGNAL \ALT_INV_outputStream~1_combout\ : std_logic;
SIGNAL \ALT_INV_outputStream~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \ALT_INV_globalReset~combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~0_combout\ : std_logic;
SIGNAL ALT_INV_counter : std_logic_vector(7 DOWNTO 0);

BEGIN

empty <= ww_empty;
outputStream <= ww_outputStream;
ww_clk <= clk;
ww_rst <= rst;
ww_load <= load;
ww_parallelIn <= parallelIn;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_parallelIn[2]~input_o\ <= NOT \parallelIn[2]~input_o\;
\ALT_INV_parallelIn[1]~input_o\ <= NOT \parallelIn[1]~input_o\;
\ALT_INV_parallelIn[7]~input_o\ <= NOT \parallelIn[7]~input_o\;
\ALT_INV_parallelIn[0]~input_o\ <= NOT \parallelIn[0]~input_o\;
\ALT_INV_parallelIn[6]~input_o\ <= NOT \parallelIn[6]~input_o\;
\ALT_INV_parallelIn[5]~input_o\ <= NOT \parallelIn[5]~input_o\;
\ALT_INV_parallelIn[4]~input_o\ <= NOT \parallelIn[4]~input_o\;
\ALT_INV_parallelIn[3]~input_o\ <= NOT \parallelIn[3]~input_o\;
\ALT_INV_load~input_o\ <= NOT \load~input_o\;
\ALT_INV_rst~input_o\ <= NOT \rst~input_o\;
\ALT_INV_outputStream~1_combout\ <= NOT \outputStream~1_combout\;
\ALT_INV_outputStream~0_combout\ <= NOT \outputStream~0_combout\;
\ALT_INV_Mux0~0_combout\ <= NOT \Mux0~0_combout\;
\ALT_INV_globalReset~combout\ <= NOT \globalReset~combout\;
\ALT_INV_Equal0~0_combout\ <= NOT \Equal0~0_combout\;
ALT_INV_counter(4) <= NOT counter(4);
ALT_INV_counter(3) <= NOT counter(3);
ALT_INV_counter(2) <= NOT counter(2);
ALT_INV_counter(0) <= NOT counter(0);
ALT_INV_counter(1) <= NOT counter(1);
ALT_INV_counter(6) <= NOT counter(6);
ALT_INV_counter(5) <= NOT counter(5);
ALT_INV_counter(7) <= NOT counter(7);

-- Location: IOOBUF_X20_Y0_N36
\empty~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Equal0~1_combout\,
	devoe => ww_devoe,
	o => ww_empty);

-- Location: IOOBUF_X20_Y0_N19
\outputStream~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \outputStream~2_combout\,
	devoe => ww_devoe,
	o => ww_outputStream);

-- Location: IOIBUF_X89_Y23_N21
\clk~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G11
\clk~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \clk~input_o\,
	outclk => \clk~inputCLKENA0_outclk\);

-- Location: LABCELL_X22_Y1_N0
\Add0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~17_sumout\ = SUM(( counter(0) ) + ( VCC ) + ( !VCC ))
-- \Add0~18\ = CARRY(( counter(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(0),
	cin => GND,
	sumout => \Add0~17_sumout\,
	cout => \Add0~18\);

-- Location: IOIBUF_X22_Y0_N35
\load~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_load,
	o => \load~input_o\);

-- Location: IOIBUF_X22_Y0_N52
\rst~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rst,
	o => \rst~input_o\);

-- Location: LABCELL_X22_Y1_N51
globalReset : cyclonev_lcell_comb
-- Equation(s):
-- \globalReset~combout\ = ( \rst~input_o\ ) # ( !\rst~input_o\ & ( !\load~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111000011110000111100001111000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_load~input_o\,
	dataf => \ALT_INV_rst~input_o\,
	combout => \globalReset~combout\);

-- Location: LABCELL_X22_Y1_N3
\Add0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~13_sumout\ = SUM(( counter(1) ) + ( GND ) + ( \Add0~18\ ))
-- \Add0~14\ = CARRY(( counter(1) ) + ( GND ) + ( \Add0~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(1),
	cin => \Add0~18\,
	sumout => \Add0~13_sumout\,
	cout => \Add0~14\);

-- Location: FF_X22_Y1_N5
\counter[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~13_sumout\,
	sclr => \globalReset~combout\,
	ena => \counter[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(1));

-- Location: LABCELL_X22_Y1_N6
\Add0~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~21_sumout\ = SUM(( counter(2) ) + ( GND ) + ( \Add0~14\ ))
-- \Add0~22\ = CARRY(( counter(2) ) + ( GND ) + ( \Add0~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(2),
	cin => \Add0~14\,
	sumout => \Add0~21_sumout\,
	cout => \Add0~22\);

-- Location: FF_X22_Y1_N7
\counter[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~21_sumout\,
	sclr => \globalReset~combout\,
	ena => \counter[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(2));

-- Location: LABCELL_X22_Y1_N9
\Add0~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~25_sumout\ = SUM(( counter(3) ) + ( GND ) + ( \Add0~22\ ))
-- \Add0~26\ = CARRY(( counter(3) ) + ( GND ) + ( \Add0~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(3),
	cin => \Add0~22\,
	sumout => \Add0~25_sumout\,
	cout => \Add0~26\);

-- Location: FF_X22_Y1_N11
\counter[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~25_sumout\,
	sclr => \globalReset~combout\,
	ena => \counter[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(3));

-- Location: LABCELL_X22_Y1_N12
\Add0~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~29_sumout\ = SUM(( counter(4) ) + ( GND ) + ( \Add0~26\ ))
-- \Add0~30\ = CARRY(( counter(4) ) + ( GND ) + ( \Add0~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(4),
	cin => \Add0~26\,
	sumout => \Add0~29_sumout\,
	cout => \Add0~30\);

-- Location: FF_X22_Y1_N14
\counter[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~29_sumout\,
	sclr => \globalReset~combout\,
	ena => \counter[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(4));

-- Location: LABCELL_X22_Y1_N15
\Add0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~5_sumout\ = SUM(( counter(5) ) + ( GND ) + ( \Add0~30\ ))
-- \Add0~6\ = CARRY(( counter(5) ) + ( GND ) + ( \Add0~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(5),
	cin => \Add0~30\,
	sumout => \Add0~5_sumout\,
	cout => \Add0~6\);

-- Location: FF_X22_Y1_N17
\counter[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~5_sumout\,
	sclr => \globalReset~combout\,
	ena => \counter[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(5));

-- Location: LABCELL_X22_Y1_N18
\Add0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~9_sumout\ = SUM(( counter(6) ) + ( GND ) + ( \Add0~6\ ))
-- \Add0~10\ = CARRY(( counter(6) ) + ( GND ) + ( \Add0~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(6),
	cin => \Add0~6\,
	sumout => \Add0~9_sumout\,
	cout => \Add0~10\);

-- Location: FF_X22_Y1_N20
\counter[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~9_sumout\,
	sclr => \globalReset~combout\,
	ena => \counter[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(6));

-- Location: LABCELL_X22_Y1_N21
\Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~1_sumout\ = SUM(( counter(7) ) + ( GND ) + ( \Add0~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(7),
	cin => \Add0~10\,
	sumout => \Add0~1_sumout\);

-- Location: FF_X22_Y1_N23
\counter[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~1_sumout\,
	sclr => \globalReset~combout\,
	ena => \counter[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(7));

-- Location: LABCELL_X22_Y1_N54
\counter[1]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter[1]~0_combout\ = ( counter(7) & ( \Equal0~0_combout\ & ( ((!\load~input_o\) # ((counter(5)) # (\rst~input_o\))) # (counter(6)) ) ) ) # ( !counter(7) & ( \Equal0~0_combout\ ) ) # ( counter(7) & ( !\Equal0~0_combout\ ) ) # ( !counter(7) & ( 
-- !\Equal0~0_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111111111111111111111101111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_counter(6),
	datab => \ALT_INV_load~input_o\,
	datac => \ALT_INV_rst~input_o\,
	datad => ALT_INV_counter(5),
	datae => ALT_INV_counter(7),
	dataf => \ALT_INV_Equal0~0_combout\,
	combout => \counter[1]~0_combout\);

-- Location: FF_X22_Y1_N2
\counter[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~17_sumout\,
	sclr => \globalReset~combout\,
	ena => \counter[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(0));

-- Location: LABCELL_X22_Y1_N48
\Equal0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~0_combout\ = ( counter(3) & ( (counter(0) & (counter(4) & (counter(1) & counter(2)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000010000000000000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_counter(0),
	datab => ALT_INV_counter(4),
	datac => ALT_INV_counter(1),
	datad => ALT_INV_counter(2),
	dataf => ALT_INV_counter(3),
	combout => \Equal0~0_combout\);

-- Location: LABCELL_X22_Y1_N24
\Equal0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~1_combout\ = ( counter(7) & ( !counter(5) & ( (\Equal0~0_combout\ & !counter(6)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100000011000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Equal0~0_combout\,
	datac => ALT_INV_counter(6),
	datae => ALT_INV_counter(7),
	dataf => ALT_INV_counter(5),
	combout => \Equal0~1_combout\);

-- Location: IOIBUF_X20_Y0_N52
\parallelIn[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_parallelIn(7),
	o => \parallelIn[7]~input_o\);

-- Location: IOIBUF_X20_Y0_N1
\parallelIn[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_parallelIn(0),
	o => \parallelIn[0]~input_o\);

-- Location: LABCELL_X22_Y1_N30
\outputStream~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \outputStream~0_combout\ = ( counter(7) & ( counter(4) & ( (!counter(6) & !counter(5)) ) ) ) # ( !counter(7) & ( counter(4) & ( (!counter(6) & (!counter(5) & \parallelIn[0]~input_o\)) ) ) ) # ( counter(7) & ( !counter(4) & ( (!counter(6) & (!counter(5) & 
-- \parallelIn[7]~input_o\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000010000000100000000000100010001000100010001000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_counter(6),
	datab => ALT_INV_counter(5),
	datac => \ALT_INV_parallelIn[7]~input_o\,
	datad => \ALT_INV_parallelIn[0]~input_o\,
	datae => ALT_INV_counter(7),
	dataf => ALT_INV_counter(4),
	combout => \outputStream~0_combout\);

-- Location: IOIBUF_X24_Y0_N18
\parallelIn[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_parallelIn(3),
	o => \parallelIn[3]~input_o\);

-- Location: IOIBUF_X24_Y0_N1
\parallelIn[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_parallelIn(6),
	o => \parallelIn[6]~input_o\);

-- Location: IOIBUF_X24_Y0_N52
\parallelIn[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_parallelIn(5),
	o => \parallelIn[5]~input_o\);

-- Location: IOIBUF_X24_Y0_N35
\parallelIn[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_parallelIn(4),
	o => \parallelIn[4]~input_o\);

-- Location: LABCELL_X23_Y1_N24
\Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux0~0_combout\ = ( \parallelIn[5]~input_o\ & ( \parallelIn[4]~input_o\ & ( (!counter(4) & (((counter(5))) # (\parallelIn[3]~input_o\))) # (counter(4) & (((!counter(5)) # (\parallelIn[6]~input_o\)))) ) ) ) # ( !\parallelIn[5]~input_o\ & ( 
-- \parallelIn[4]~input_o\ & ( (!counter(4) & (\parallelIn[3]~input_o\ & ((!counter(5))))) # (counter(4) & (((!counter(5)) # (\parallelIn[6]~input_o\)))) ) ) ) # ( \parallelIn[5]~input_o\ & ( !\parallelIn[4]~input_o\ & ( (!counter(4) & (((counter(5))) # 
-- (\parallelIn[3]~input_o\))) # (counter(4) & (((\parallelIn[6]~input_o\ & counter(5))))) ) ) ) # ( !\parallelIn[5]~input_o\ & ( !\parallelIn[4]~input_o\ & ( (!counter(4) & (\parallelIn[3]~input_o\ & ((!counter(5))))) # (counter(4) & 
-- (((\parallelIn[6]~input_o\ & counter(5))))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101000000000011010100001111001101011111000000110101111111110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_parallelIn[3]~input_o\,
	datab => \ALT_INV_parallelIn[6]~input_o\,
	datac => ALT_INV_counter(4),
	datad => ALT_INV_counter(5),
	datae => \ALT_INV_parallelIn[5]~input_o\,
	dataf => \ALT_INV_parallelIn[4]~input_o\,
	combout => \Mux0~0_combout\);

-- Location: IOIBUF_X22_Y0_N1
\parallelIn[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_parallelIn(2),
	o => \parallelIn[2]~input_o\);

-- Location: IOIBUF_X22_Y0_N18
\parallelIn[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_parallelIn(1),
	o => \parallelIn[1]~input_o\);

-- Location: LABCELL_X22_Y1_N36
\outputStream~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \outputStream~1_combout\ = ( !counter(7) & ( counter(4) & ( (\parallelIn[2]~input_o\ & (counter(5) & !counter(6))) ) ) ) # ( !counter(7) & ( !counter(4) & ( (counter(5) & (!counter(6) & \parallelIn[1]~input_o\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000110000000000000000000000010000000100000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_parallelIn[2]~input_o\,
	datab => ALT_INV_counter(5),
	datac => ALT_INV_counter(6),
	datad => \ALT_INV_parallelIn[1]~input_o\,
	datae => ALT_INV_counter(7),
	dataf => ALT_INV_counter(4),
	combout => \outputStream~1_combout\);

-- Location: LABCELL_X22_Y1_N42
\outputStream~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \outputStream~2_combout\ = ( \outputStream~1_combout\ & ( counter(6) ) ) # ( !\outputStream~1_combout\ & ( counter(6) & ( (((!counter(7) & \Mux0~0_combout\)) # (\outputStream~0_combout\)) # (\globalReset~combout\) ) ) ) # ( \outputStream~1_combout\ & ( 
-- !counter(6) ) ) # ( !\outputStream~1_combout\ & ( !counter(6) & ( (\outputStream~0_combout\) # (\globalReset~combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0111011101110111111111111111111101110111111101111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_globalReset~combout\,
	datab => \ALT_INV_outputStream~0_combout\,
	datac => ALT_INV_counter(7),
	datad => \ALT_INV_Mux0~0_combout\,
	datae => \ALT_INV_outputStream~1_combout\,
	dataf => ALT_INV_counter(6),
	combout => \outputStream~2_combout\);

-- Location: LABCELL_X33_Y70_N0
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


