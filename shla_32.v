// Zuhair Shaikh and Brant Lan Li
// SHLA Operation (SHLA)
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University

`timescale 1ns/10ps

module shla_32(
	input wire [31:0] rA, rB,
	output reg [31:0] rZ
	);
	
	always @(*)
		begin
			assign rZ = {rA[31], (rA[30:0] << rB)};
		end
endmodule