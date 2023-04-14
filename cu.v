// Zuhair Shaikh and Brant Lan Li
// Control Unit (CU)
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University

`timescale 1ns/10ps

module cu(
	input wire  Clock, Reset, Stop,
	input wire  [31:0] IR,
	input wire  CON_Out,
	output reg  Run, Clear,
	output reg  Gra, Grb, Grc, Rin, Rout, BAout, Read, Write,
	output reg  IncPC, CON_In,
	output reg  PCin, IRin, HIin, LOin, ZHighin, ZLowin, MARin, MDRin, OutPort, Yin,
	output reg  PCout, HIout, LOout, ZHighout, ZLowout, InPort, MDRout, Cout, GLR,
	output reg  AND, ANDI, OR, ORI, NOT, NEG, ADD, ADDI, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, BR, LD, LDI, ST, HALT, NOP
	);
	
	reg [6:0] Present_State;
	
	parameter OP_LD = 5'b00000;
	parameter OP_LDI = 5'b00001;
   parameter OP_ST = 5'b00010;
	parameter OP_ADD = 5'b00011;
	parameter OP_SUB = 5'b00100;
	parameter OP_AND = 5'b00101;
	parameter OP_OR = 5'b00110;
	parameter OP_SHR = 5'b00111;
	parameter OP_SHRA = 5'b01000;
	parameter OP_SHL = 5'b01001;
	parameter OP_ROR = 5'b01010; 
	parameter OP_ROL = 5'b01011;
	parameter OP_ADDI = 5'b01100;
	parameter OP_ANDI = 5'b01101;
	parameter OP_ORI = 5'b01110;
	parameter OP_MUL = 5'b01111;
	parameter OP_DIV = 5'b10000;
	parameter OP_NEG = 5'b10001;
	parameter OP_NOT = 5'b10010;
	parameter OP_BR = 5'b10011;
	parameter OP_JR = 5'b10100;
	parameter OP_JAL = 5'b10101;
	parameter OP_IN = 5'b10110;
	parameter OP_OUT = 5'b10111;
	parameter OP_MFHI = 5'b11000;
	parameter OP_MFLO = 5'b11001;
	parameter OP_NOP = 5'b11010;
	parameter OP_HALT = 5'b11011;
	
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
	
	always @ (negedge Clock, negedge Reset, negedge Stop) begin
		if (Reset == 0) begin
			Present_State <= FCTH_T0;
		end
		if (Stop == 0) begin
			Present_State <= HALT_T3;
		end
		case (Present_State)
			State_Reset : Present_State <= FCTH_T0;
			FCTH_T0 : Present_State <= FCTH_T1;
			FCTH_T1 : Present_State <= FCTH_T2;
			FCTH_T2 :case (IR[31:27])
						OP_LD :  Present_State <= LD_T3;
						OP_LDI :  Present_State <= LDI_T3;
						OP_ST :  Present_State <= ST_T3;
						OP_ADD :  Present_State <= ADD_T3;
						OP_SUB :  Present_State <= SUB_T3;
						OP_AND :  Present_State <= AND_T3;
						OP_OR :  Present_State <= OR_T3;
						OP_SHR :  Present_State <= SHR_T3;
						OP_SHRA :  Present_State <= SHRA_T3;
						OP_SHL :  Present_State <= SHL_T3;
						OP_ROR :  Present_State <= ROR_T3;
						OP_ROL :  Present_State <= ROL_T3;
						OP_ADDI :  Present_State <= ADDI_T3;
						OP_ANDI :  Present_State <= ANDI_T3;
						OP_ORI :  Present_State <= ORI_T3;
						OP_MUL :  Present_State <= MUL_T3;
						OP_DIV :  Present_State <= DIV_T3;
						OP_NEG :  Present_State <= NEG_T3;
						OP_NOT :  Present_State <= NOT_T3;
						OP_BR :  Present_State <= BR_T3;
						OP_JR :  Present_State <= JR_T3;
						OP_JAL :  Present_State <= JAL_T3;
						OP_IN :  Present_State <= IN_T3;
						OP_OUT :  Present_State <= OUT_T3;
						OP_MFHI :  Present_State <= MFHI_T3;
						OP_MFLO :  Present_State <= MFLO_T3;
						OP_NOP :  Present_State <= NOP_T3;
						OP_HALT :  Present_State <= HALT_T3;
				endcase
			LD_T3 :  Present_State <= LD_T4;
			LD_T4 :  Present_State <= LD_T5;
			LD_T5 :  Present_State <= LD_T6;
			LD_T6 :  Present_State <= LD_T7;
			LD_T7 :  Present_State <= FCTH_T0;
			
			LDI_T3 :  Present_State <= LDI_T4;
			LDI_T4 :  Present_State <= LDI_T5;
			LDI_T5 :  Present_State <= FCTH_T0;		
			
			ST_T3 :  Present_State <= ST_T4;
			ST_T4 :  Present_State <= ST_T5;
			ST_T5 :  Present_State <= ST_T6;
			ST_T6 :  Present_State <= ST_T7;
			ST_T7 :  Present_State <= FCTH_T0;
			
			ADD_T3 :  Present_State <= ADD_T4;
			ADD_T4 :  Present_State <= ADD_T5;
			ADD_T5 :  Present_State <= FCTH_T0;	
			
			SUB_T3 :  Present_State <= SUB_T4;
			SUB_T4 :  Present_State <= SUB_T5;
			SUB_T5 :  Present_State <= FCTH_T0;	
			
			AND_T3 :  Present_State <= AND_T4;
			AND_T4 :  Present_State <= AND_T5;
			AND_T5 :  Present_State <= FCTH_T0;				
			
			OR_T3 :  Present_State <= OR_T4;
			OR_T4 :  Present_State <= OR_T5;
			OR_T5 :  Present_State <= FCTH_T0;				
			
			SHR_T3 :  Present_State <= SHR_T4;
			SHR_T4 :  Present_State <= SHR_T5;
			SHR_T5 :  Present_State <= FCTH_T0;				
			
			SHRA_T3 :  Present_State <= SHRA_T4;
			SHRA_T4 :  Present_State <= SHRA_T5;
			SHRA_T5 :  Present_State <= FCTH_T0;				
			
			SHL_T3 :  Present_State <= SHL_T4;
			SHL_T4 :  Present_State <= SHL_T5;
			SHL_T5 :  Present_State <= FCTH_T0;				
			
			ROR_T3 :  Present_State <= ROR_T4;
			ROR_T4 :  Present_State <= ROR_T5;
			ROR_T5 :  Present_State <= FCTH_T0;	
			
			ROL_T3 :  Present_State <= ROL_T4;
			ROL_T4 :  Present_State <= ROL_T5;
			ROL_T5 :  Present_State <= FCTH_T0;				
			
			ADDI_T3 :  Present_State <= ADDI_T4;
			ADDI_T4 :  Present_State <= ADDI_T5;
			ADDI_T5 :  Present_State <= FCTH_T0;				
			
			ANDI_T3 :  Present_State <= ANDI_T4;
			ANDI_T4 :  Present_State <= ANDI_T5;
			ANDI_T5 :  Present_State <= FCTH_T0;	
			
			ORI_T3 :  Present_State <= ORI_T4;
			ORI_T4 :  Present_State <= ORI_T5;
			ORI_T5 :  Present_State <= FCTH_T0;					
			
			MUL_T3 :  Present_State <= MUL_T4;
			MUL_T4 :  Present_State <= MUL_T5;
			MUL_T5 :  Present_State <= MUL_T6;
			MUL_T6 :  Present_State <= FCTH_T0;			
			
			DIV_T3 :  Present_State <= DIV_T4;
			DIV_T4 :  Present_State <= DIV_T5;
			DIV_T5 :  Present_State <= DIV_T6;
			DIV_T6 :  Present_State <= FCTH_T0;			
			
			NEG_T3 :  Present_State <= NEG_T4;
			NEG_T4 :  Present_State <= FCTH_T0;			
			
			NOT_T3 :  Present_State <= NOT_T4;
			NOT_T4 :  Present_State <= FCTH_T0;			
			
			BR_T3 :  Present_State <= BR_T4;
			BR_T4 :  Present_State <= BR_T5;
			BR_T5 :  Present_State <= BR_T6;
			BR_T6 :  Present_State <= FCTH_T0;			
			
			JR_T3 :  Present_State <= FCTH_T0;
			
			JAL_T3 :  Present_State <= JAL_T4;
			JAL_T4 :  Present_State <= FCTH_T0;

			IN_T3 :  Present_State <= FCTH_T0;			
			
			OUT_T3 :  Present_State <= FCTH_T0;
			
			MFHI_T3 :  Present_State <= FCTH_T0;
			
			MFLO_T3 :  Present_State <= FCTH_T0;
			
			NOP_T3 :  Present_State <= FCTH_T0;
			
			HALT_T3 :  Present_State <= FCTH_T0;
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
				PCout <= 1; MARin <= 1; IncPC <= 1; 
				#15 PCout <= 0; MARin <= 0; IncPC <= 0;
			end
			FCTH_T1 : begin
				 Read <= 1; MDRin <= 1;
				 #15 Read <= 0; MDRin <= 0;
			end
			FCTH_T2 : begin
				MDRout <= 1; IRin <= 1;
				#15 MDRout <= 0; IRin <= 0;
			end
			
			LD_T3 : begin
				Grb <= 1; BAout <= 1; Yin <= 1;
				#15 Grb <= 0; BAout <= 0; Yin <= 0;				
			end
			LD_T4 : begin
				Cout <= 1; ADD <= 1; ZHighin <= 1; ZLowin <= 1;
				#15 Cout <= 0; ADD <= 0; ZHighin <= 0; ZLowin <= 0;			
			end
			LD_T5 : begin
				ZLowout <= 1; MARin <= 1;
				#15 ZLowout <= 0; MARin <= 0;
			end
			LD_T6 : begin
				Read <= 1; MDRin <= 1;
				#15 Read <= 0; MDRin <= 0;
			end
         LD_T7 : begin
				MDRout <= 1; Gra <= 1; Rin <= 1;
				#15 MDRout <= 0; Gra <= 0; Rin <= 0;			
			end
			
         LDI_T3 : begin
				Grb <= 1; BAout <= 1; Yin <= 1;
				#15 Grb <= 0; BAout <= 0; Yin <= 0;			
			end
         LDI_T4 : begin
				Cout <= 1; ADD <= 1; ZHighin <= 1; ZLowin <= 1;
				#15 Cout <= 0; ADD <= 0; ZHighin <= 0; ZLowin <= 0;				
			end
         LDI_T5 : begin
				ZLowout <= 1; Gra <= 1; Rin <= 1;
				#15 ZLowout <= 0; Gra <= 0; Rin <= 0;			
			end
			
         ST_T3 : begin
				Grb <= 1; BAout <= 1; Yin <= 1;
				#15 Grb <= 0; BAout <= 0; Yin <= 0;			
			end
         ST_T4 : begin
				Cout <= 1; ADD <= 1; ZHighin <= 1; ZLowin <= 1;
				#15 Cout <= 0; ADD <= 0; ZHighin <= 0; ZLowin <= 0;				
			end
         ST_T5 : begin
				ZLowout <= 1; MARin <= 1;
				#15 ZLowout <= 0; MARin <= 0;			
			end
         ST_T6 : begin
				Gra <= 1; Rout <= 1; MDRin <= 1;
				#15 Gra <= 0; Rout <= 0; MDRin <= 0;			
			end
         ST_T7 : begin
				MDRout <= 1; Write <= 1;
				#15 MDRout <= 0; Write <= 0;			
			end
			
         ADD_T3 : begin
				Grb <= 1; Rout <= 1; Yin <= 1;
				#15 Grb <= 0; Rout <= 0; Yin <= 0;						
			end	
         ADD_T4 : begin
				Grc <= 1; Rout <= 1; ADD <= 1; ZHighin <= 1; ZLowin <= 1;
				#15 Grc <= 0; Rout <= 0; ADD <= 0; ZHighin <= 0; ZLowin <= 0;	
			end
         ADD_T5 : begin
				ZLowout <= 1; Gra <= 1; Rin <= 1;
				#15 ZLowout <= 0; Gra <= 0; Rin <= 0;	
			end
			
         SUB_T3 : begin
				Grb <= 1; Rout <= 1; Yin <= 1;
				#15 Grb <= 0; Rout <= 0; Yin <= 0;
			end
         SUB_T4 : begin
				Grc <= 1; Rout <= 1; SUB <= 1; ZHighin <= 1; ZLowin <= 1;
				#15 Grc <= 0; Rout <= 0; SUB <= 0; ZHighin <= 0; ZLowin <= 0;				
			end
         SUB_T5 : begin
				ZLowout <= 1; Gra <= 1; Rin <= 1;
				#15 ZLowout <= 0; Gra <= 0; Rin <= 0;	
			end
			
         AND_T3 : begin
				Grb <= 1; Rout <= 1; Yin <= 1;
				#15 Grb <= 0; Rout <= 0; Yin <= 0;
			end
         AND_T4 : begin
				Grc <= 1; Rout <= 1; AND <= 1; ZHighin <= 1; ZLowin <= 1;
				#15 Grc <= 0; Rout <= 0; AND <= 0; ZHighin <= 0; ZLowin <= 0;	
			end
         AND_T5 : begin
				ZLowout <= 1; Gra <= 1; Rin <= 1;
				#15 ZLowout <= 0; Gra <= 0; Rin <= 0;	
			end
			
         OR_T3 : begin
				Grb <= 1; Rout <= 1; Yin <= 1;
				#15 Grb <= 0; Rout <= 0; Yin <= 0;				
			end
         OR_T4 : begin
				Grc <= 1; Rout <= 1; OR <= 1; ZHighin <= 1; ZLowin <= 1;
				#15 Grc <= 0; Rout <= 0; OR <= 0; ZHighin <= 0; ZLowin <= 0;			
			end
         OR_T5 : begin
				ZLowout <= 1; Gra <= 1; Rin <= 1;
				#15 ZLowout <= 0; Gra <= 0; Rin <= 0;				
			end
			
         SHR_T3 : begin
				Grb <= 1; Rout <= 1; Yin <= 1;
				#15 Grb <= 0; Rout <= 0; Yin <= 0;	
			end
         SHR_T4 : begin
				Grc <= 1; Rout <= 1; SHR <= 1; ZHighin <= 1; ZLowin <= 1;
				#15 Grc <= 0; Rout <= 0; SHR <= 0; ZHighin <= 0; ZLowin <= 0;
			end
         SHR_T5 : begin
				ZLowout <= 1; Gra <= 1; Rin <= 1;
				#15 ZLowout <= 0; Gra <= 0; Rin <= 0;	
         end
			
         SHRA_T3 : begin
				Grb <= 1; Rout <= 1; Yin <= 1;
				#15 Grb <= 0; Rout <= 0; Yin <= 0;			
			end
         SHRA_T4 : begin
				Grc <= 1; Rout <= 1; SHRA <= 1; ZHighin <= 1; ZLowin <= 1;
				#15 Grc <= 0; Rout <= 0; SHRA <= 0; ZHighin <= 0; ZLowin <= 0;			
			end
         SHRA_T5 : begin
				ZLowout <= 1; Gra <= 1; Rin <= 1;
				#15 ZLowout <= 0; Gra <= 0; Rin <= 0;			
			end
			
         SHL_T3 : begin
				Grb <= 1; Rout <= 1; Yin <= 1;
				#15 Grb <= 0; Rout <= 0; Yin <= 0;			
			end
         SHL_T4 : begin
				Grc <= 1; Rout <= 1; SHL <= 1; ZHighin <= 1; ZLowin <= 1;
				#15 Grc <= 0; Rout <= 0; SHL <= 0; ZHighin <= 0; ZLowin <= 0;			
			end
         SHL_T5 : begin
				ZLowout <= 1; Gra <= 1; Rin <= 1;
				#15 ZLowout <= 0; Gra <= 0; Rin <= 0;			
			end
         
         ROR_T3 : begin
				Grb <= 1; Rout <= 1; Yin <= 1;
				#15 Grb <= 0; Rout <= 0; Yin <= 0;			
			end
         ROR_T4 : begin
				Grc <= 1; Rout <= 1; ROR <= 1; ZHighin <= 1; ZLowin <= 1;
				#15 Grc <= 0; Rout <= 0; ROR <= 0; ZHighin <= 0; ZLowin <= 0;			
			end
         ROR_T5 : begin
				ZLowout <= 1; Gra <= 1; Rin <= 1;
				#15 ZLowout <= 0; Gra <= 0; Rin <= 0;			
			end
         
         ROL_T3 : begin
				Grb <= 1; Rout <= 1; Yin <= 1;
				#15 Grb <= 0; Rout <= 0; Yin <= 0;		
			end
         ROL_T4 : begin 
				Grc <= 1; Rout <= 1; ROL <= 1; ZHighin <= 1; ZLowin <= 1;
				#15 Grc <= 0; Rout <= 0; ROL <= 0; ZHighin <= 0; ZLowin <= 0;				
			end
         ROL_T5 : begin 
				ZLowout <= 1; Gra <= 1; Rin <= 1;
				#15 ZLowout <= 0; Gra <= 0; Rin <= 0;			
			end
         
         ADDI_T3 : begin
				Grb <= 1; Rout <= 1; Yin <= 1;
				#15 Grb <= 0; Rout <= 0; Yin <= 0;			
			end
         ADDI_T4 : begin
				Cout <= 1; ADDI <= 1; ZHighin <= 1; ZLowin <= 1;
				#15 Cout <= 0; ADDI <= 0; ZHighin <= 0; ZLowin <= 0;
			end
         ADDI_T5 : begin
				ZLowout <= 1; Gra <= 1; Rin <= 1;
				#15 ZLowout <= 0; Gra <= 0; Rin <= 0;
			end
			
         ANDI_T3 : begin
				Grb <= 1; Rout <= 1; Yin <= 1;
				#15 Grb <= 0; Rout <= 0; Yin <= 0;
			end	
         ANDI_T4 : begin
				Cout <= 1; ANDI <= 1; ZHighin <= 1; ZLowin <= 1;
				#15 Cout <= 0; ANDI <= 0; ZHighin <= 0; ZLowin <= 0;
			end
         ANDI_T5 : begin
				ZLowout <= 1; Gra <= 1; Rin <= 1;
				#15 ZLowout <= 0; Gra <= 0; Rin <= 0;
			end
         
         ORI_T3 : begin 
				Grb <= 1; Rout <= 1; Yin <= 1;
				#15 Grb <= 0; Rout <= 0; Yin <= 0;
			end
         ORI_T4 : begin 
				Cout <= 1; ORI <= 1; ZHighin <= 1; ZLowin <= 1;
				#15 Cout <= 0; ORI <= 0; ZHighin <= 0; ZLowin <= 0;			
			end
         ORI_T5 : begin 
				ZLowout <= 1; Gra <= 1; Rin <= 1;
				#15 ZLowout <= 0; Gra <= 0; Rin <= 0;			
			end
         
         MUL_T3 : begin 
				Gra <= 1; Rout <= 1; Yin <= 1;
				#15 Gra <= 0; Rout <= 0; Yin <= 0;	
			end
         MUL_T4 : begin 
				Grb <= 1; Rout <= 1; MUL <= 1; ZHighin <= 1; ZLowin <= 1;
				#15 Grb <= 0; Rout <= 0; MUL <= 0; ZHighin <= 0; ZLowin <= 0;				
			end
         MUL_T5 : begin 
				ZLowout <= 1; LOin <= 1;
				#15 ZLowout <= 0; LOin <= 0;
			end
         MUL_T6 : begin 
				ZHighout <= 1; HIin <= 1;
				#15 ZHighout <= 0; HIin <= 0;			
			end
         
         DIV_T3 : begin 
				Gra <= 1; Rout <= 1; Yin <= 1;
				#15 Gra <= 0; Rout <= 0; Yin <= 0;
			end
         DIV_T4 : begin 
				Grb <= 1; Rout <= 1; DIV <= 1; ZHighin <= 1; ZLowin <= 1;
				#15 Grb <= 0; Rout <= 0; DIV <= 0; ZHighin <= 0; ZLowin <= 0;	
			end
         DIV_T5 : begin 
				ZLowout <= 1; LOin <= 1;
				#15 ZLowout <= 0; LOin <= 0;
			end
         DIV_T6 : begin 
				ZHighout <= 1; HIin <= 1;
				#15 ZHighout <= 0; HIin <= 0;	
			end
         
         NEG_T3 : begin 
				Grb <= 1; Rout <= 1; NEG <= 1; ZHighin <= 1; ZLowin <= 1;
				#15 Grb <= 0; Rout <= 0; NEG <= 0; ZHighin <= 0; ZLowin <= 0;
			end
         NEG_T4 : begin 
				Gra <= 1; Rin <= 1; ZLowout <= 1;
				#15 Gra <= 0; Rin <= 0; ZLowout <= 0;	
			end
         
         NOT_T3 : begin 
				Grb <= 1; Rout <= 1; NOT <= 1; ZHighin <= 1; ZLowin <= 1;
				#15 Grb <= 0; Rout <= 0; NOT <= 0; ZHighin <= 0; ZLowin <= 0;
			end
         NOT_T4 : begin 
				Gra <= 1; Rin <= 1; ZLowout <= 1;
				#15 Gra <= 0; Rin <= 0; ZLowout <= 0;
			end
         
         BR_T3 : begin
				Gra <= 1; Rout <= 1; CON_In <= 1;
				#15 Gra <= 0; Rout <= 0; CON_In <= 0;			
			end
         BR_T4 : begin
				PCout <= 1; Yin <= 1;
				#15 PCout <= 0; Yin <= 0;			
			end
         BR_T5 : begin
				Cout <= 1; BR <= 1; ZLowin <= 1; ZHighin <= 1;
				#15 Cout <= 0; BR <= 0; ZLowin <= 0; ZHighin <= 0;			
			end
         BR_T6 : begin
				ZLowout <= 1; PCin <= CON_Out;
				#15 ZLowout <= 0; PCin <= 0;			
			end
         
         JR_T3 : begin
				Gra <= 1; Rout <= 1; PCin <= 1;
				#15 Gra <= 0; Rout <= 0; PCin <= 0;
			end
         
         JAL_T3 : begin
				GLR <= 1; PCout <= 1; Rin <= 1;
				#15 GLR <= 0; PCout <= 0; Rin <= 0;
			end
         JAL_T4 : begin
				Gra <= 1; Rout <= 1; PCin <= 1;
				#15 Gra <= 0; Rout <= 0; PCin <= 0;
			end
         
         IN_T3 : begin
				Gra <= 1; InPort <= 1; Rin <= 1;
				#15 Gra <= 0; InPort <= 0; Rin <= 0;
			end
         
         OUT_T3 : begin 
				Gra <= 1; OutPort <= 1; Rout <= 1;
				#15 Gra <= 0; OutPort <= 0; Rout <= 0;
			end
         
         MFHI_T3 : begin
				Gra <= 1; HIout <= 1; Rin <= 1;
				#15 Gra <= 0; HIout <= 0; Rin <= 0;
			end
         
         MFLO_T3 : begin
				Gra <= 1; LOout <= 1; Rin <= 1;
				#15 Gra <= 0; LOout <= 0; Rin <= 0;
			end
         
         NOP_T3 : begin 
			end
         
         HALT_T3 : begin
				Run <= 0;
			end

		endcase
	end	
endmodule