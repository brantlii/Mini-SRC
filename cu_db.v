// Zuhair Shaikh and Brant Lan Li
// Control Unit (CU)
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University

`timescale 1ns/10ps

module cu_db(
	input wire  Clock, Reset, Stop,
	input wire  [31:0] IR,
	input wire  CON_Out,
	output reg  Gra, Grb, Grc, Rin, Rout, BAout, Read, Write, Run, Clear,
	output reg  IncPC, CON_In,
	output reg  PCin, IRin, HIin, LOin, ZHighin, ZLowin, MARin, MDRin, OutPort, Yin,
	output reg  PCout, HIout, LOout, ZHighout, ZLowout, InPort, MDRout, Cout, GLR,
	output reg  AND, ANDI, OR, ORI, NOT, NEG, ADD, ADDI, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, BR, LD, LDI, ST, HALT, NOP
	);
	
	reg [6:0] Present_State;
	
	parameter LD = 5'b00000;
	parameter LDI = 5'b00001;
   parameter ST = 5'b00010;
	parameter ADD = 5'b00011;
	parameter SUB = 5'b00100;
	parameter AND = 5'b00101;
	parameter OR = 5'b00110;
	parameter SHR = 5'b00111;
	parameter SHRA = 5'b01000;
	parameter SHL = 5'b01001;
	parameter ROR = 5'b01010; 
	parameter ROL = 5'b01011;
	parameter ADDI = 5'b01100;
	parameter ANDI = 5'b01101;
	parameter ORI = 5'b01110;
	parameter MUL = 5'b01111;
	parameter DIV = 5'b10000;
	parameter NEG = 5'b10001;
	parameter NOT = 5'b10010;
	parameter BR = 5'b10011;
	parameter JR = 5'b10100;
	parameter JAL = 5'b10101;
	parameter IN = 5'b10110;
	parameter OUT = 5'b10111;
	parameter MFHI = 5'b11000;
	parameter MFLO = 5'b11001;
	parameter NOP = 5'b11010;
	parameter HALT = 5'b11011;
	
	parameter State_Reset = 7'b0000000;
	parameter FCTH_T0 = 7'b0000001;
	parameter FCTH_T1 = 7'b0000010;
	parameter FCTH_T2 = 7'b0000011;
	parameter LD_T3 = 7'b0000100;
	parameter LD_T4 = 7'b0000101;
	parameter LD_T5 = 7'b0000110;
	parameter LD_T6 = 7'b0000111;
	parameter LD_T7 = 7'b0001000;
	parameter LDI_T3 = 7'b0001001;
	parameter LDI_T4 = 7'b0001010;
	parameter LDI_T5 = 7'b0001011;
	parameter ST_T3 = 7'b0001100;
	parameter ST_T4 = 7'b0001101;
	parameter ST_T5 = 7'b0001110;
	parameter ST_T6 = 7'b0001111;
	parameter ST_T7 = 7'b0010000;
	parameter ADD_T3 = 7'b0010001;
	parameter ADD_T4 = 7'b0010010;
	parameter ADD_T5 = 7'b0010011;
	parameter SUB_T3 = 7'b0010100;
	parameter SUB_T4 = 7'b0010101;
	parameter SUB_T5 = 7'b0010110;
	parameter AND_T3 = 7'b0010111;
	parameter AND_T4 = 7'b0011000;
	parameter AND_T5 = 7'b0011001;
	parameter OR_T3 = 7'b0011010;
	parameter OR_T4 = 7'b0011011;
	parameter OR_T5 = 7'b0011100;
	parameter SHR_T3 = 7'b0011101;
	parameter SHR_T4 = 7'b0011110;
	parameter SHR_T5 = 7'b0011111;
	parameter SHRA_T3 = 7'b0100000;
	parameter SHRA_T4 = 7'b0100001;
	parameter SHRA_T5 = 7'b0100010;
	parameter SHL_T3 = 7'b0100011;
	parameter SHL_T4 = 7'b0100100;
	parameter SHL_T5 = 7'b0100101;
	parameter ROR_T3 = 7'b0100110;
	parameter ROR_T4 = 7'b0100111;
	parameter ROR_T5 = 7'b0101000;
	parameter ROL_T3 = 7'b0101001;
	parameter ROL_T4 = 7'b0101010;
	parameter ROL_T5 = 7'b0101011;
	parameter ADDI_T3 = 7'b0101100;
	parameter ADDI_T4 = 7'b0101101;
	parameter ADDI_T5 = 7'b0101110;
	parameter ANDI_T3 = 7'b0101111;
	parameter ANDI_T4 = 7'b0110000;
	parameter ANDI_T5 = 7'b0110001;
	parameter ORI_T3 = 7'b0110010;
	parameter ORI_T4 = 7'b0110011;
	parameter ORI_T5 = 7'b0110100;
	parameter MUL_T3 = 7'b0110101;
	parameter MUL_T4 = 7'b0110110;
	parameter MUL_T5 = 7'b0110111;
	parameter MUL_T6 = 7'b0111000;
	parameter DIV_T3 = 7'b0111001;
	parameter DIV_T4 = 7'b0111010;
	parameter DIV_T5 = 7'b0111011;
	parameter DIV_T6 = 7'b0111100;
	parameter NEG_T3 = 7'b0111101;
	parameter NEG_T4 = 7'b0111110;
	parameter NOT_T3 = 7'b0111111;
	parameter NOT_T4 = 7'b1000000;
	parameter BR_T3 = 7'b1000001;
	parameter BR_T4 = 7'b1000010;
	parameter BR_T5 = 7'b1000011;
	parameter BR_T6 = 7'b1000100;
	parameter JR_T3 = 7'b1000101;
	parameter JAL_T3 = 7'b1000110;
	parameter JAL_T4 = 7'b1000111;
	parameter IN_T3 = 7'b1001000;
	parameter OUT_T3 = 7'b1001001;
	parameter MFHI_T3 = 7'b1001010;
	parameter MFLO_T3 = 7'b1001011;
	parameter NOP_T3 = 7'b1001100;
	parameter HALT_T3 = 7'b1001101;
	
	initial begin
		Present_State = State_Reset;
	end
	
	always @ (posedge Clock, posedge Reset, posedge, Stop) begin
		if (Reset) begin
			Present_State <= FCTH_T0;
		end
		if (Stop) begin
			Present_State <= HALT_T3;
		end
		case (Present_State)
			State_Reset : Present_State <= FCTH_T0;
			FCTH_T0 : Present_State <= FCTH_T1;
			FCTH_T1 : Present_State <= FCTH_T2;
			FCTH_T2 : begin @ (posedge Clock);
				case (IR[31:27])
						LD : Present_State <= LD_T3;
						LDI : Present_State <= LDI_T3;
						ST : Present_State <= ST_T3;
						ADD : Present_State <= ADD_T3;
						SUB : Present_State <= SUB_T3;
						AND : Present_State <= AND_T3;
						OR : Present_State <= OR_T3;
						SHR : Present_State <= SHR_T3;
						SHRA : Present_State <= SHRA_T3;
						SHL : Present_State <= SHL_T3;
						ROR : Present_State <= ROR_T3;
						ROL : Present_State <= ROL_T3;
						ADDI : Present_State <= ADDI_T3;
						ANDI : Present_State <= ANDI_T3;
						ORI : Present_State <= ORI_T3;
						MUL : Present_State <= MUL_T3;
						DIV : Present_State <= DIV_T3;
						NEG : Present_State <= NEG_T3;
						NOT : Present_State <= NOT_T3;
						BR : Present_State <= BR_T3;
						JR : Present_State <= JR_T3;
						JAL : Present_State <= JAL_T3;
						IN : Present_State <= IN_T3;
						OUT : Present_State <= OUT_T3;
						MFHI : Present_State <= MFHI_T3;
						MFLO : Present_State <= MFLO_T3;
						NOP : Present_State <= NOP_T3;
						HALT : Present_State <= HALT_T3;
						default : Present_State <= HALT_T3;
				endcase
			end
			
			LD_T3 : Present_State <= LD_T4;
			LD_T4 : Present_State <= LD_T5;
			LD_T5 : Present_State <= LD_T6;
			LD_T6 : Present_State <= LD_T7;
			LD_T7 : Present_State <= FCTH_T0;
			
			LD_T3 : Present_State <= LD_T4;
			LD_T4 : Present_State <= LD_T5;
			LD_T5 : Present_State <= FCTH_T0;		
			
			ST_T3 : Present_State <= ST_T4;
			ST_T4 : Present_State <= ST_T5;
			ST_T5 : Present_State <= ST_T6;
			ST_T6 : Present_State <= ST_T7;
			ST_T7 : Present_State <= FCTH_T0;
			
			ADD_T3 : Present_State <= ADD_T4;
			ADD_T4 : Present_State <= ADD_T5;
			ADD_T5 : Present_State <= FCTH_T0;	
			
			SUB_T3 : Present_State <= SUB_T4;
			SUB_T4 : Present_State <= SUB_T5;
			SUB_T5 : Present_State <= FCTH_T0;	
			
			AND_T3 : Present_State <= AND_T4;
			AND_T4 : Present_State <= AND_T5;
			AND_T5 : Present_State <= FCTH_T0;				
			
			OR_T3 : Present_State <= OR_T4;
			OR_T4 : Present_State <= OR_T5;
			OR_T5 : Present_State <= FCTH_T0;				
			
			SHR_T3 : Present_State <= SHR_T4;
			SHR_T4 : Present_State <= SHR_T5;
			SHR_T5 : Present_State <= FCTH_T0;				
			
			SHRA_T3 : Present_State <= SHRA_T4;
			SHRA_T4 : Present_State <= SHRA_T5;
			SHRA_T5 : Present_State <= FCTH_T0;				
			
			SHL_T3 : Present_State <= SHL_T4;
			SHL_T4 : Present_State <= SHL_T5;
			SHL_T5 : Present_State <= FCTH_T0;				
			
			ROR_T3 : Present_State <= ROR_T4;
			ROR_T4 : Present_State <= ROR_T5;
			ROR_T5 : Present_State <= FCTH_T0;	
			
			ROL_T3 : Present_State <= ROL_T4;
			ROL_T4 : Present_State <= ROL_T5;
			ROL_T5 : Present_State <= FCTH_T0;				
			
			ADDI_T3 : Present_State <= ADDI_T4;
			ADDI_T4 : Present_State <= ADDI_T5;
			ADDI_T5 : Present_State <= FCTH_T0;				
			
			ANDI_T3 : Present_State <= ANDI_T4;
			ANDI_T4 : Present_State <= ANDI_T5;
			ANDI_T5 : Present_State <= FCTH_T0;	
			
			ORI_T3 : Present_State <= ORI_T4;
			ORI_T4 : Present_State <= ORI_T5;
			ORI_T5 : Present_State <= FCTH_T0;					
			
			MUL_T4 : Present_State <= MUL_T5;
			MUL_T5 : Present_State <= MUL_T6;
			MUL_T6 : Present_State <= MUL_T7;
			MUL_T7 : Present_State <= FCTH_T0;			
			
			DIV_T4 : Present_State <= DIV_T5;
			DIV_T5 : Present_State <= DIV_T6;
			DIV_T6 : Present_State <= DIV_T7;
			DIV_T7 : Present_State <= FCTH_T0;			
			
			NEG_T6 : Present_State <= NEG_T4;
			NEG_T7 : Present_State <= FCTH_T0;			
			
			NOT_T3 : Present_State <= NOT_T4;
			NOT_T4 : Present_State <= FCTH_T0;			
			
			BR_T4 : Present_State <= BR_T5;
			BR_T5 : Present_State <= BR_T6;
			BR_T6 : Present_State <= BR_T7;
			BR_T7 : Present_State <= FCTH_T0;			
			
			JR_T3 : Present_State <= FCTH_T0;
			
			JAL_T3 : Present_State <= JAL_T3;
			JAL_T4 : Present_State <= FCTH_T0;

			IN_T3 : Present_State <= FCTH_T0;			
			
			OUT_T3 : Present_State <= FCTH_T0;
			
			MFHI_T3 : Present_State <= FCTH_T0;
			
			MFLO_T3 : Present_State <= FCTH_T0;
			
			NOP_T3 : Present_State <= FCTH_T0;
			
			HALT_T3 : Present_State <= FCTH_T0;
		endcase
	end
	
	always @ (Present_State) begin
		case (Present_State)
			State_Reset : begin
				Run <= 1;
				{Gra, Grb, Grc, Rin, Rout, BAout, Read, Write, Run, Clear} <= 0;
				{IncPC, CON_In} <= 0;
				{PCin, IRin, HIin, LOin, ZHighin, ZLowin, MARin, MDRin, OutPort, Yin} <= 0;
				{PCout, HIout, LOout, ZHighout, ZLowout, InPort, MDRout, Cout, GLR} <= 0;
				{AND, ANDI, OR, ORI, NOT, NEG, ADD, ADDI, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, BR, LD, LDI, ST, HALT, NOP} <= 0;
			end
			FCTH_T0 : begin
				{Gra, Grb, Grc, Rin, Rout, BAout, Read, Write, Run, Clear} <= 0;
				{IncPC, CON_In} <= 0;
				{PCin, IRin, HIin, LOin, ZHighin, ZLowin, MARin, MDRin, OutPort, Yin} <= 0;
				{PCout, HIout, LOout, ZHighout, ZLowout, InPort, MDRout, Cout, GLR} <= 0;
				{AND, ANDI, OR, ORI, NOT, NEG, ADD, ADDI, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, BR, LD, LDI, ST, HALT, NOP} <= 0;
				PCout <= 1; MARin <= 1; 
			
			
			
			
			
			
	
	
endmodule
			
			
			
			
