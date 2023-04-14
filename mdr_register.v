// Zuhair Shaikh and Brant Lan Li
// Memory Data Register Register (MDR)
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University 

`timescale 1ns/10ps

module mdr_register (
	input wire [31:0] BusMuxOut,
	input wire clk,
	input wire clr,
	input wire Read,
	input wire MDRin,
	input wire [31:0] MDAtain,
	output wire [31:0] Q
	);
	
	wire [31:0] D;
	
	mdr_mux muxmdr (BusMuxOut, Read, MDAtain, D);
	gen_register mdr (D, clk, clr, MDRin, Q);
endmodule 