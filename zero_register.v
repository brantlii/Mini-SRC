// Zuhair Shaikh and Brant Lan Li
// R0 Register
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University

`timescale 1ns/10ps

module zero_register (
	input wire [31:0] D,
	input wire clk,
	input	wire clr,
	input wire enable,
	input wire BAout,
	output wire [31:0] Q
	);
	
	wire [31:0] qTemp;
	gen_register zero_instance (D, clk, clr, enable, qTemp);
	assign Q = {32{!BAout}} & qTemp;
endmodule