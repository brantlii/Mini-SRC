// Zuhair Shaikh and Brant Lan Li
// Select and Encode Logic 
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University

`timescale 1ns/10ps

module sel(
	input wire Gra,
	input wire Grb,
	input wire Grc, 
	input wire Rin,
	input wire Rout,
	input wire BAout, 
	input wire [31:0] IR_Out,
	output wire [15:0] GenReg_In,
	output wire [15:0] GenReg_Out,
	output wire [31:0] C_sign_extended
	);
	
	wire [3:0] decoder_input;
	wire [15:0] decoder_output;
	
	assign decoder_input = (IR_Out[26:23] & {4{Gra}}) | (IR_Out[22:19] & {4{Grb}}) | (IR_Out[18:15] & {4{Grc}});
						 
	decoder_4_16 decode(decoder_input, decoder_output);
	
	assign GenReg_In = {16{Rin}} & decoder_output;
	assign GenReg_Out = ({16{Rout}} | {16{BAout}}) & decoder_output;
	assign C_sign_extended = {{13{IR_Out[18]}},IR_Out[18:0]};
	
endmodule 
	
	
	
	
	
