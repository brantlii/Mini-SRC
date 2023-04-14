// Zuhair Shaikh and Brant Lan Li
// General Purpose Register (Used for R1 - R15, HI, LO, Y, IR)
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University 

`timescale 1ns/10ps

module gen_register #(parameter INIT = 32'h0)(
	input wire [31:0] D,
	input wire clk,
	input	wire clr,
	input wire enable,
	output wire [31:0] Q
	);
	
	reg [31:0] qTemp;
	initial qTemp = INIT;
	always @ (posedge clk)
		begin
			if (clr) begin
				qTemp <= 0;
			end
			else if (enable) begin
				qTemp <= D;
			end
		end
	assign Q = qTemp;
endmodule