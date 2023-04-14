// Zuhair Shaikh and Brant Lan Li
// D Flip Flop
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University 

`timescale 1ns/10ps

module d_ff(
	input wire D,
	input wire clk,
	output reg Q
	);
	
	always @ (posedge clk)
		begin
			Q <= D;
		end
endmodule