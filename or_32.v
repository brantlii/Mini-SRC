// Zuhair Shaikh and Brant Lan Li
// OR Operation (OR)
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University

`timescale 1ns/10ps

module or_32(
	input wire [31:0] rA, rB,
	output wire [31:0] rZ
	);
	
	genvar i;
	generate
		for (i=0; i<32; i=i+1) begin : gen_or
			assign rZ[i] = (rA[i])|(rB[i]);
		end
	endgenerate
endmodule