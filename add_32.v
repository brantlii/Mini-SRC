// Zuhair Shaikh and Brant Lan Li
// ADD Operation (ADD)
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University

`timescale 1ns/10ps

module add_4(
	input wire [3:0] rA, rB,
	input wire cIn,
	output wire [3:0] S,
	output wire cOut
	);
	
	wire [3:0] G;
	wire [3:0] P; 
	wire [3:0] C;
	
	assign G = rA & rB;
	assign P = rA ^ rB;
	assign C[0] = cIn;
	assign C[1]= G[0] | (P[0]&C[0]);
	assign C[2]= G[1] | (P[1]&G[0]) | P[1]&P[0]&C[0];
	assign C[3]= G[2] | (P[2]&G[1]) | P[2]&P[1]&G[0] | P[2]&P[1]&P[0]&C[0];
	assign cOut = G[3] | (P[3]&G[2]) | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0] | P[3]&P[2]&P[1]&P[0]&C[0];
	assign S[3:0] = P ^ C;
endmodule

module add_16(
	input wire [15:0] rA, rB,
	input wire cIn,
	output wire [15:0] S,
	output wire cOut
	);
	
	wire cOutA;
	wire cOutB;
	wire cOutC;

	add_4 adderA(rA[3:0], rB[3:0], cIn, S[3:0], cOutA);
	add_4 adderB(rA[7:4], rB[7:4], cOutA, S[7:4], cOutB);				
	add_4 adderC(rA[11:8], rB[11:8], cOutB, S[11:8], cOutC);
	add_4 adderD(rA[15:12], rB[15:12], cOutC, S[15:12], cOut);
endmodule

module add_32(
	input wire [31:0] rA, rB,
	input wire cIn,
	output wire [31:0] S,
	output wire cOut
	);
	
	wire cOutTemp;

	add_16 adderA(rA[15:0], rB[15:0], cIn, S[15:0], cOutTemp);
	add_16 adderB(rA[31:16], rB[31:16], cOutTemp, S[31:16], cOut);
endmodule