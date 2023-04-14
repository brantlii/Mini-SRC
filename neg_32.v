// Zuhair Shaikh and Brant Lan Li
// NOT Operation (NOT)
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University

`timescale 1ns/10ps

module neg_32(
	input wire [31:0] rA,
	output wire [31:0] rZ
	);
	
	wire [31:0] zTemp;
	wire cOut;
	
	not_32 not_instance (rA, zTemp);
	add_32 add_instance (zTemp, 32'd1, 1'd0, rZ, cOut);
endmodule