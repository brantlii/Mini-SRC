// Zuhair Shaikh and Brant Lan Li
// ROL Operation (ROL)
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University

`timescale 1ns/10ps

module rol_32(
	input wire [31:0] rIn, rotB,
	output wire [31:0] rOut
	);
	
	reg [31:0] oTemp;
	always @ (*)
		begin
			oTemp = ((rIn << rotB) | (rIn >> (32 - rotB)));
		end
	assign rOut = oTemp;
endmodule