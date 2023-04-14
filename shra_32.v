// Zuhair Shaikh and Brant Lan Li
// SHRA Operation (SHRA)
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University

`timescale 1ns/10ps

module shra_32(
	input wire [31:0] rA, rB,
	output wire [31:0] rZ
	);

	assign rZ = $signed(rA) >>> rB;
endmodule
