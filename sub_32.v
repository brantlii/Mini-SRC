// Zuhair Shaikh and Brant Lan Li
// SUB Operation (SUB)
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University

`timescale 1ns/10ps

module sub_32(
	input wire [31:0] rA, rB,
	input wire cIn,
	input wire [31:0] S,
	output wire cOut
	);
	
	wire [31:0] cTemp;
	
	neg_32 neg_operation(rB, cTemp);
	add_32 add_operation(rA, cTemp, cIn, S, cOut);
endmodule