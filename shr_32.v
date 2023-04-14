// Zuhair Shaikh and Brant Lan Li
// SHR Operation (SHR)
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University

`timescale 1ns/10ps

module shr_32(
	input wire [31:0] rA, rB,
	output wire [31:0] rZ
	);
	
	assign rZ = rA >> rB;
endmodule