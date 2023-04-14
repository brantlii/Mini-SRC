// Zuhair Shaikh and Brant Lan Li
// NOT Operation (NOT)
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University

`timescale 1ns/10ps

module not_32(
	input wire [31:0] rA,
	output wire [31:0] rZ
	);
	
	assign rZ = (rA ^ {32{1'b1}});
endmodule