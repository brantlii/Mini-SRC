// Zuhair Shaikh and Brant Lan Li
// 32 to 1 Multiplexer (32:1 MUX) 
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University 

`timescale 1ns/10ps

module mux_32_1 (		
		input wire [31:0] MuxInR0,
		input wire [31:0] MuxInR1,
		input wire [31:0] MuxInR2, 
		input wire [31:0] MuxInR3, 
		input wire [31:0] MuxInR4, 
		input wire [31:0] MuxInR5, 
		input wire [31:0] MuxInR6, 
		input wire [31:0] MuxInR7,								
		input wire [31:0] MuxInR8, 
		input wire [31:0] MuxInR9, 
		input wire [31:0] MuxInR10, 
		input wire [31:0] MuxInR11, 
		input wire [31:0] MuxInR12, 
		input wire [31:0] MuxInR13, 
		input wire [31:0] MuxInR14, 
		input wire [31:0] MuxInR15,
		input wire [31:0] MuxInHI, 
		input wire [31:0] MuxInLO, 
		input wire [31:0] MuxInZHI, 
		input wire [31:0] MuxInZLO, 
		input wire [31:0] MuxInPC, 
		input wire [31:0] MuxInMDR, 
		input wire [31:0] MuxInPort, 
		input wire [31:0] MuxInC,
		input wire [4:0] MuxSelect,
		output reg [31:0] MuxOut
		);
		
		always @ (*) begin
			case (MuxSelect)
				5'b00000: MuxOut <= MuxInR0;
				5'b00001: MuxOut <= MuxInR1;
				5'b00010: MuxOut <= MuxInR2;
				5'b00011: MuxOut <= MuxInR3;
				5'b00100: MuxOut <= MuxInR4;
				5'b00101: MuxOut <= MuxInR5;
				5'b00110: MuxOut <= MuxInR6;
				5'b00111: MuxOut <= MuxInR7;
				5'b01000: MuxOut <= MuxInR8;
				5'b01001: MuxOut <= MuxInR9;
				5'b01010: MuxOut <= MuxInR10;
				5'b01011: MuxOut <= MuxInR11;
				5'b01100: MuxOut <= MuxInR12;
				5'b01101: MuxOut <= MuxInR13;
				5'b01110: MuxOut <= MuxInR14;
				5'b01111: MuxOut <= MuxInR15;
				5'b10000: MuxOut <= MuxInHI;
				5'b10001: MuxOut <= MuxInLO;
				5'b10010: MuxOut <= MuxInZHI;
				5'b10011: MuxOut <= MuxInZLO;
				5'b10100: MuxOut <= MuxInPC;
				5'b10101: MuxOut <= MuxInMDR;
				5'b10110: MuxOut <= MuxInPort;
				5'b10111: MuxOut <= MuxInC;
				default: MuxOut <= 32'b0;
			endcase	
		end 		
endmodule 

						