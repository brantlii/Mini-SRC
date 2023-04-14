// Zuhair Shaikh and Brant Lan Li
// ALU Testbench File 
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University

`timescale 1ns/10ps 

module ALU_tb;
	
	reg clk;
	reg [31:0] input_a;
	reg [31:0] input_b;
	reg [4:0] opcode;
	wire [63:0] ALU_result;

	ALU ALU_instance (input_a, input_b, opcode, ALU_result);
	
	initial
	begin
		clk = 0;
		forever #10 clk = ~ clk;
	end
	
	initial 
		begin 
			input_a <= 32'b0100;
			input_b <= 32'b0010;
			
			opcode <= 5'b00000;     // check AND operation 
			
			# 10 
			
			opcode <= 5'b00001;		// check OR operation 
			
			# 10 
			
			opcode <= 5'b00010;		// check NOT operation 
			
			# 10
			
			opcode <= 5'b00011;		// check NEG operation 
			
			# 10
			
			opcode <= 5'b00100; 		// check ADD operation 
			
			# 10
			
			opcode <= 5'b00101;		// check SUB operation
			
			# 10 
			
			opcode <= 5'b00110;		// check MUL operation 
			
			# 10
			
			opcode <= 5'b00111;		// check DIV operation
			
			# 10
			
			opcode <= 5'b01000;		// check SHR operation
			
			# 10
			
			opcode <= 5'b01001;		// check SHRA operation
			
			# 10 
			
			opcode <= 5'b01010;		// check SHL operation
			
			# 10 
			
			opcode <= 5'b01011;		// check ROR operation
			
			# 10 
			
			opcode <= 5'b01100;		// check ROL operation
		end 
		
endmodule 