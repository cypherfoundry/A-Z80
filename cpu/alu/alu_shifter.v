// Copyright (C) 1991-2011 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 11.0 Build 208 07/03/2011 Service Pack 1 SJ Full Version"
// CREATED		"Sun May 18 14:13:15 2014"

module alu_shifter(
	cf_in,
	alu_oe,
	alu_shift_enable,
	alu_shift_oe,
	op543,
	cf_out,
	db,
	db_high,
	db_low
);


input wire	cf_in;
input wire	alu_oe;
input wire	alu_shift_enable;
input wire	alu_shift_oe;
input wire	[2:0] op543;
output wire	cf_out;
inout wire	[7:0] db;
inout wire	[3:0] db_high;
inout wire	[3:0] db_low;

wire	[3:0] SYNTHESIZED_WIRE_0;
wire	[3:0] SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_8;

assign	SYNTHESIZED_WIRE_10 = 0;
assign	SYNTHESIZED_WIRE_6 = 1;




assign	db[7] = alu_oe ? db_high[3] : 1'bz;
assign	db[6] = alu_oe ? db_high[2] : 1'bz;
assign	db[5] = alu_oe ? db_high[1] : 1'bz;
assign	db[4] = alu_oe ? db_high[0] : 1'bz;

assign	db[3] = alu_oe ? db_low[3] : 1'bz;
assign	db[2] = alu_oe ? db_low[2] : 1'bz;
assign	db[1] = alu_oe ? db_low[1] : 1'bz;
assign	db[0] = alu_oe ? db_low[0] : 1'bz;

assign	db_low[3] = alu_shift_oe ? SYNTHESIZED_WIRE_0[3] : 1'bz;
assign	db_low[2] = alu_shift_oe ? SYNTHESIZED_WIRE_0[2] : 1'bz;
assign	db_low[1] = alu_shift_oe ? SYNTHESIZED_WIRE_0[1] : 1'bz;
assign	db_low[0] = alu_shift_oe ? SYNTHESIZED_WIRE_0[0] : 1'bz;

assign	db_high[3] = alu_shift_oe ? SYNTHESIZED_WIRE_1[3] : 1'bz;
assign	db_high[2] = alu_shift_oe ? SYNTHESIZED_WIRE_1[2] : 1'bz;
assign	db_high[1] = alu_shift_oe ? SYNTHESIZED_WIRE_1[1] : 1'bz;
assign	db_high[0] = alu_shift_oe ? SYNTHESIZED_WIRE_1[0] : 1'bz;


mux_8	b2v_mux_8_inst(
	.in0(SYNTHESIZED_WIRE_9),
	.in1(SYNTHESIZED_WIRE_3),
	.in2(cf_in),
	.in3(cf_in),
	.in4(SYNTHESIZED_WIRE_10),
	.in5(SYNTHESIZED_WIRE_9),
	.in6(SYNTHESIZED_WIRE_6),
	.in7(SYNTHESIZED_WIRE_10),
	.sel(op543),
	.out(SYNTHESIZED_WIRE_8));

assign	SYNTHESIZED_WIRE_3 = db[0];


assign	SYNTHESIZED_WIRE_9 = db[7];



alu_shifter_core	b2v_shifter_core_inst(
	.shift_in(SYNTHESIZED_WIRE_8),
	.shift_right(op543[0]),
	.shift_enable(alu_shift_enable),
	.db(db),
	.cy_out(cf_out),
	.out_high(SYNTHESIZED_WIRE_1),
	.out_low(SYNTHESIZED_WIRE_0));



endmodule
