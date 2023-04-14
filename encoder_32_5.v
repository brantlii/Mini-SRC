// Zuhair Shaikh and Brant Lan Li
// 32 to 5 Encoder 
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University 

`timescale 1ns/10ps

module encoder_32_5 ( 
				input wire R0Out,
				input wire R1Out,
				input wire R2Out, 
				input wire R3Out,
				input wire R4Out, 
				input wire R5Out, 
				input wire R6Out, 
				input wire R7Out, 
				input wire R8Out, 
				input wire R9Out, 
				input wire R10Out, 
				input wire R11Out, 
				input wire R12Out, 
				input wire R13Out, 
				input wire R14Out, 
				input wire R15Out, 	
				input wire PCOut, 
				input wire HIOut, 
				input wire LOOut, 
				input wire ZHIOut, 
				input wire ZLOOut,
				input wire InPortOut, 
				input wire MDROut,
				input wire COut,
				output reg [4:0] Encoder_Select
				);
				always @ (*) begin 
				
					if	(COut) Encoder_Select <= 5'b10111;
					else if 	(InPortOut) Encoder_Select <= 5'b10110;
					else if	(MDROut) Encoder_Select <= 5'b10101;
					else if	(PCOut) Encoder_Select <= 5'b10100;
					else if	(ZLOOut) Encoder_Select <= 5'b10011;
					else if	(ZHIOut) Encoder_Select <= 5'b10010;
					else if	(LOOut) Encoder_Select <= 5'b10001;
					else if	(HIOut) Encoder_Select <= 5'b10000;
					else if	(R15Out) Encoder_Select <= 5'b01111;
					else if	(R14Out) Encoder_Select <= 5'b01110;
					else if	(R13Out) Encoder_Select <= 5'b01101;
					else if	(R12Out) Encoder_Select <= 5'b01100;
					else if	(R11Out) Encoder_Select <= 5'b01011;
					else if	(R10Out) Encoder_Select <= 5'b01010;
					else if	(R9Out) Encoder_Select <= 5'b01001;
					else if	(R8Out) Encoder_Select <= 5'b01000;
					else if	(R7Out) Encoder_Select <= 5'b00111;
					else if	(R6Out) Encoder_Select <= 5'b00110;
					else if	(R5Out) Encoder_Select <= 5'b00101;
					else if	(R4Out) Encoder_Select <= 5'b00100;
					else if	(R3Out) Encoder_Select <= 5'b00011;
					else if	(R2Out) Encoder_Select <= 5'b00010;
					else if	(R1Out) Encoder_Select <= 5'b00001;
					else if	(R0Out) Encoder_Select <= 5'b00000;
					
				end
endmodule


					


							

							
							
							
						

					


							

							
							
							
						