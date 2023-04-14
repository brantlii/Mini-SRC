// Zuhair Shaikh and Brant Lan Li
// Arithemtic Logic Unit (ALU)
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University

`timescale 1ns/10ps

module alu(
	input wire CON_Out,
	input wire IncPC,
	input wire [31:0] A,
	input wire [31:0] B,
	input wire AND, ANDI, OR, ORI, NOT, NEG, ADD, ADDI, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, BR, LD, LDI, ST, HALT, NOP,
	output reg [63:0] result
	);
	
	wire [31:0] and_result;  // AND operation
	wire [31:0] or_result;	// OR operation
	wire [31:0] not_result;	// NOT operation
	wire [31:0] neg_result;	// NEG operation
	wire add_carry; 		// ADD sum
	wire [31:0] add_result;	// ADD operation
	wire sub_carry; 	 // SUB difference
	wire [31:0] sub_result;  // SUB operation
	wire [63:0] mul_result;  // MUL operation
	wire [63:0] div_result;  // DIV operation
	wire [31:0] shr_result;  // SHR operation
	wire [31:0] shra_result; // SHRA operation
	wire [31:0] shl_result;  // SHL operation
	wire [31:0] ror_result;  // ROR operation
	wire [31:0] rol_result;  // ROL operation
	
	always @ (*) begin
		if (IncPC) begin
			result[31:0] <= B[31:0] + 1;
			result[63:32] <= 32'b0;
		end else begin
				if (AND || ANDI) begin
							result[31:0] <= and_result[31:0];
							result[63:32] <= 32'b0;
				end
				else if (OR || ORI) begin
							result[31:0] <= or_result[31:0];
							result[63:32] <= 32'b0; 
			   end
				else if (NOT) begin
							result[31:0] <= not_result[31:0];
							result[63:32] <= 32'b0;
				end
				else if (NEG) begin
							result[31:0] <= neg_result[31:0];
							result[63:32] <= 32'b0;
				end
				else if (ADD || ADDI) begin
							result[31:0] <= add_result[31:0];
							result[63:32] <= 32'b0;
				end
				else if (SUB) begin
							result[31:0] <= sub_result[31:0];
							result[63:32] <= 32'b0;
				end
				else if (MUL) begin
							result[63:0] <= mul_result[63:0];
				end
				else if (DIV) begin
							result[63:0] <= div_result[63:0];
				end
				else if (SHR) begin
							result[31:0] <= shr_result[31:0];
							result[63:32] <= 32'b0;
				end
				else if (SHRA) begin
							result[31:0] <= shra_result[31:0];
							result[63:32] <= 32'b0;
				end
				else if (SHL) begin
							result[31:0] <= shl_result[31:0];
							result[63:32] <= 32'b0;
				end
				else if (ROR) begin
							result[31:0] <= ror_result[31:0];
							result[63:32] <= 32'b0;
				end
				else if (ROL) begin
							result[31:0] <= rol_result[31:0];
							result[63:32] <= 32'b0;
				end
				else if (BR) begin
							if (CON_Out) begin
								result[31:0] <= add_result[31:0];
								result[63:32] <= 32'b0;
							end else begin
								result[31:0] <= A[31:0];
								result[63:32] <= 32'b0;
							end
				end
				else if (LD || LDI || ST) begin
							result[31:0] <= add_result[31:0];
							result[63:32] <= 32'b0;
				end
				else if (HALT || NOP) begin
				end
				else begin
							result[63:0] <= 64'b0;
				end
		end
	end
	
	and_32 and_instance (A, B, and_result); 
	or_32 or_instance (A, B, or_result);
	not_32 not_instance (B, not_result);
	neg_32 neg_instance (B, neg_result);
	add_32 add_instance (A, B, 1'd0, add_result, add_carry);
	sub_32 sub_instance (A, B, 1'd0, sub_result, sub_carry);
	mul_32 mul_instance (A, B, mul_result);
	div_32 div_instance (A, B, div_result);
	shr_32 shr_instance (A, B, shr_result);
	shra_32 shra_instance (A, B, shra_result);
	shl_32 shl_instance (A, B, shl_result);
	ror_32 ror_instance (A, B, ror_result);	
	rol_32 rol_instance (A, B, rol_result);
	
endmodule 