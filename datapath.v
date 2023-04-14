// Zuhair Shaikh and Brant Lan Li
// Datapath (DUT)
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University

`timescale 1ns/10ps

module datapath (
	input wire  Clock, Reset, Stop
);

	wire	Run, Clear;
	wire [31:0] InPort_Data;
	wire [31:0] OutPort_Data;

	wire PCin;
	wire IRin;
	wire HIin;
	wire LOin;
	wire ZHIin;
	wire ZLOin;
	wire MARin;
	wire MDRin;
	wire OutPortin;
	wire Yin;
	wire R0in;
	wire R1in;
	wire R2in;
	wire R3in;
	wire R4in;
	wire R5in;
	wire R6in;
	wire R7in;
	wire R8in;
	wire R9in;
	wire R10in;
	wire R11in;
	wire R12in;
	wire R13in;
	wire R14in;
	wire R15in;

	wire PCout;
	wire HIout;
	wire LOout;
	wire ZHIout;
	wire ZLOout;
	wire InPortout;
	wire MDRout;
	wire Cout;	
	wire R0out;
	wire R1out;
	wire R2out;
	wire R3out;
	wire R4out;
	wire R5out;
	wire R6out;
	wire R7out;
	wire R8out;
	wire R9out;
	wire R10out;
	wire R11out;
	wire R12out;
	wire R13out;
	wire R14out;
	wire R15out;
	
	wire Gra;
	wire Grb;
	wire Grc;
	wire Rin;
	wire Rout;
	wire BAout;
	wire Read; // MDR_Enable
	wire Write; // RAM_Enable
	wire IncPC;
	
	wire CON_In;
	wire CON_Out;
	wire GLR; // R15in, JAL

	wire [31:0] BusMux_R0;
	wire [31:0] BusMux_R1;
	wire [31:0] BusMux_R2;
	wire [31:0] BusMux_R3;
	wire [31:0] BusMux_R4;
	wire [31:0] BusMux_R5;
	wire [31:0] BusMux_R6;
	wire [31:0] BusMux_R7;
	wire [31:0] BusMux_R8;
	wire [31:0] BusMux_R9;
	wire [31:0] BusMux_R10;
	wire [31:0] BusMux_R11;
	wire [31:0] BusMux_R12;
	wire [31:0] BusMux_R13;
	wire [31:0] BusMux_R14;
	wire [31:0] BusMux_R15;
	wire [31:0] BusMux_HI;
	wire [31:0] BusMux_LO;
	wire [31:0] BusMux_ZHI;
	wire [31:0] BusMux_ZLO;
	wire [31:0] BusMux_PC;
	wire [31:0] BusMux_MDR;
	wire [31:0] BusMux_MAR;
	wire [31:0] BusMux_InPort;
	wire [31:0] BusMux_C;
	wire [31:0] BusMux_Y;
	wire [31:0] BusMux_IR;
	wire [4:0] Mux_Select;
	wire [31:0] Mux_Out;
	
	wire [63:0] ALU_Data;
	wire [31:0] MDatain; // RAM_Out
	wire GLS; // R15in, Encoder
	wire [6:0] Present_State;
	wire AND, ANDI, OR, ORI, NOT, NEG, ADD, ADDI, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, BR, LD, LDI, ST, HALT, NOP;
	
	assign R15in = GLR | GLS;
	assign InPort_Data = 32'h00000088;
	
	cu ControlUnit (Clock, Reset, Stop, BusMux_IR, CON_Out, Run, Clear, Gra, Grb, Grc, Rin, Rout, BAout, Read, Write,
						 IncPC, CON_In, PCin, IRin, HIin, LOin, ZHIin, ZLOin, MARin, MDRin, OutPortin, Yin,
						 PCout, HIout, LOout, ZHIout, ZLOout, InPortout, MDRout, Cout, GLR,
						 AND, ANDI, OR, ORI, NOT, NEG, ADD, ADDI, SUB, MUL, DIV,
						 SHR, SHRA, SHL, ROR, ROL, BR, LD, LDI, ST, HALT, NOP);
	
	alu ALU (CON_Out, IncPC, BusMux_Y, Mux_Out, 
							AND, ANDI, OR, ORI, NOT, NEG, ADD, ADDI, SUB, MUL, DIV,
							SHR, SHRA, SHL, ROR, ROL, BR, LD, LDI, ST, HALT, NOP, ALU_Data);
							
	ram RAM (BusMux_MDR, BusMux_MAR[8:0], Clock, Read, Write, MDatain);
	
	sel SelectEncode (Gra, Grb, Grc, Rin, Rout, BAout, BusMux_IR,
						  {GLS, R14in, R13in, R12in, R11in, R10in, R9in, R8in, R7in, R6in, R5in, R4in, R3in, R2in, R1in, R0in},
						  {R15out, R14out, R13out, R12out, R11out, R10out, R9out, R8out, R7out, R6out, R5out, R4out, R3out, R2out, R1out, R0out},
						   BusMux_C);
							
	con_ff CON_FF (BusMux_IR[20:19], Mux_Out, CON_In, CON_Out);
	
	encoder_32_5 Encoder32_5 (R0out, R1out, R2out, R3out, R4out,
								 R5out, R6out, R7out, R8out, R9out,
								 R10out, R11out, R12out, R13out, R14out, R15out,
								 PCout, HIout, LOout, ZHIout, ZLOout, 
								 InPortout, MDRout, Cout, Mux_Select);
	
	mux_32_1 Multiplexer32_1 (BusMux_R0, BusMux_R1, BusMux_R2, 
								 BusMux_R3, BusMux_R4, BusMux_R5, BusMux_R6, 
								 BusMux_R7, BusMux_R8, BusMux_R9, BusMux_R10, 
								 BusMux_R11, BusMux_R12, BusMux_R13, BusMux_R14, 
								 BusMux_R15, BusMux_HI, BusMux_LO, BusMux_ZHI, 
								 BusMux_ZLO, BusMux_PC, BusMux_MDR, BusMux_InPort, 
								 BusMux_C, Mux_Select, Mux_Out);			

	zero_register R0 (Mux_Out, Clock, Clear, R0in, BAout, BusMux_R0);	
	gen_register R1 (Mux_Out, Clock, Clear, R1in, BusMux_R1);
	gen_register R2 (Mux_Out, Clock, Clear, R2in, BusMux_R2);
	gen_register R3 (Mux_Out, Clock, Clear, R3in, BusMux_R3);
	gen_register R4 (Mux_Out, Clock, Clear, R4in, BusMux_R4);
	gen_register R5 (Mux_Out, Clock, Clear, R5in, BusMux_R5);
	gen_register R6 (Mux_Out, Clock, Clear, R6in, BusMux_R6);
	gen_register R7 (Mux_Out, Clock, Clear, R7in, BusMux_R7);
	gen_register R8 (Mux_Out, Clock, Clear, R8in, BusMux_R8);
	gen_register R9 (Mux_Out, Clock, Clear, R9in, BusMux_R9);
	gen_register R10 (Mux_Out, Clock, Clear, R10in, BusMux_R10);
	gen_register R11 (Mux_Out, Clock, Clear, R11in, BusMux_R11);
	gen_register R12 (Mux_Out, Clock, Clear, R12in, BusMux_R12);
	gen_register R13 (Mux_Out, Clock, Clear, R13in, BusMux_R13);
	gen_register R14 (Mux_Out, Clock, Clear, R14in, BusMux_R14);
	gen_register R15 (Mux_Out, Clock, Clear, R15in, BusMux_R15);

	gen_register InPort (InPort_Data, Clock, Clear, 1'b1, BusMux_InPort);
	gen_register OutPort (Mux_Out, Clock, Clear, OutPortin, OutPort_Data);
	gen_register Y (Mux_Out, Clock, Clear, Yin, BusMux_Y);
	gen_register HI (Mux_Out, Clock, Clear, HIin, BusMux_HI);
	gen_register LO (Mux_Out, Clock, Clear, LOin, BusMux_LO);
	gen_register ZHI (ALU_Data[63:32], Clock, Clear, ZHIin, BusMux_ZHI);
	gen_register ZLO (ALU_Data[31:0], Clock, Clear, ZLOin, BusMux_ZLO);
	gen_register MAR (Mux_Out, Clock, Clear, MARin, BusMux_MAR);
	pc_register PC (Mux_Out, Clock, Clear, IncPC, PCin, BusMux_PC);
	gen_register IR (Mux_Out, Clock, Clear, IRin, BusMux_IR);
	mdr_register MDR (Mux_Out, Clock, Clear, Read, MDRin, MDatain, BusMux_MDR);				 
endmodule 