// Zuhair Shaikh and Brant Lan Li
// 2 To 4 Decoder
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University 

`timescale 1ns/10ps

module decoder_2_4(
	input wire [1:0] decoderIn,
	output reg [3:0] decoderOut
	);
	
	always @ (*) begin
		case (decoderIn)
			2'b00 : decoderOut <= 4'b0001;
			2'b01 : decoderOut <= 4'b0010;
			2'b10 : decoderOut <= 4'b0100;
			2'b11 : decoderOut <= 4'b1000;
		endcase
	end	
endmodule
