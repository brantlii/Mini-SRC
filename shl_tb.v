// Zuhair Shaikh and Brant Lan Li
// Shift Left Testbench (SHL)
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University

`timescale 1ns/10ps
module shl_tb; 	
	reg   R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in;
	reg 	PCin, IRin, HIin, LOin, ZHighin, ZLowin, MARin, MDRin, OutPort, Cin, Yin;
	reg   R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out;
	reg 	PCout, HIout, LOout, ZHighout, ZLowout, InPort, MDRout, MARout, Cout;
	reg	Clock, Clear;
	reg 	IncPC, Read;
	reg 	[4:0] OP;
	reg	[31:0] Mdatain;

parameter	Default = 4'b0000, Reg_load1a= 4'b0001, Reg_load1b= 4'b0010,
				Reg_load2a= 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101,
				Reg_load3b = 4'b0110, T0= 4'b0111, T1= 4'b1000,T2= 4'b1001, T3= 4'b1010, T4= 4'b1011, T5= 4'b1100;
reg	[3:0] Present_state= Default;

initial Clear = 0;

datapath datapath_instance(
	Clock, Clear,
	R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in,
	PCin, IRin, HIin, LOin, ZHighin, ZLowin, MARin, MDRin, OutPort, Cin, Yin,
	R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
	PCout, HIout, LOout, ZHighout, ZLowout, InPort, MDRout, MARout, Cout,
	Read, Mdatain, IncPC, OP
	);
	

initial 
	begin
		Clock = 0;
		forever #10 Clock = ~ Clock;
end

always @(posedge Clock)//finite state machine; if clock rising-edge
begin
	case (Present_state)
		Default			:	#40 Present_state = Reg_load1a;
		Reg_load1a		:	#40 Present_state = Reg_load1b;
		Reg_load1b		:	#40 Present_state = Reg_load2a;
		Reg_load2a		:	#40 Present_state = Reg_load2b;
		Reg_load2b		:	#40 Present_state = Reg_load3a;
		Reg_load3a		:	#40 Present_state = Reg_load3b;
		Reg_load3b		:	#40 Present_state = T0;
		T0					:	#40 Present_state = T1;
		T1					:	#40 Present_state = T2;
		T2					:	#40 Present_state = T3;
		T3					:	#40 Present_state = T4;
		T4					:	#40 Present_state = T5;
		endcase
	end

always @(Present_state)// do the required job ineach state
begin
	case (Present_state)              //assert the required signals in each clock cycle
		Default: begin
				{R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in} <= 0;
				{PCin, IRin, HIin, LOin, ZHighin, ZLowin, MARin, MDRin, OutPort, Cin, Yin} <= 0;
				{R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out} <= 0;
				{PCout, HIout, LOout, ZHighout, ZLowout, InPort, MDRout, MARout, Cout} <= 0;
				Read <= 0;   Mdatain <= 32'h00000000;   IncPC <= 0;   OP <= 5'b00000;  
		end
		Reg_load1a: begin 
				Mdatain<= 32'h12345678;
				Read = 0; MDRin = 0;
				#10 Read <= 1; MDRin <= 1;  
				#15 Read <= 0; MDRin <= 0;
		end
		Reg_load1b: begin
				#10 MDRout<= 1; R3in <= 1;  
				#15 MDRout<= 0; R3in <= 0;     
		end
		Reg_load2a: begin 
				Mdatain <= 32'h0000000A;
				#10 Read <= 1; MDRin <= 1;  
				#15 Read <= 0; MDRin <= 0;
		end
		Reg_load2b: begin
				#10 MDRout<= 1; R5in <= 1;  
				#15 MDRout<= 0; R5in <= 0;
		end
		Reg_load3a: begin 
				Mdatain <= 32'h00000020;
				#10 Read <= 1; MDRin <= 1;  
				#15 Read <= 0; MDRin <= 0;
		end
		Reg_load3b: begin
				#10 MDRout<= 1; R1in <= 1;  
				#15 MDRout<= 0; R1in <= 0;
		end
	
		T0: begin
				#10 PCout<= 1; MARin <= 1; IncPC <= 1;
				#10 PCout <= 0; MARin <= 0; IncPC <= 0;
		end
		T1: begin
				#10 PCin <= 1; Read <= 1; MDRin <= 1;
				Mdatain <= 32'h489A8000;
				#10 PCin <= 0; Read <= 0; MDRin <= 0;
				
		end
		T2: begin
				#10 MDRout<= 1; IRin <= 1; 
				#10 MDRout<= 0; IRin <= 0; 
		end
		T3: begin
				#10 R3out<= 1; Yin <= 1;  
				#15 R3out<= 0; Yin <= 0;
		end
		T4: begin
				#10 R5out<= 1; OP <= 5'b01010; ZLowin <= 1; 
				#15 R5out<= 0; ZLowin <= 0; 
		end
		T5: begin
				#10 ZLowout<= 1; R1in <= 1; 
				#15 ZLowout<= 0; R1in <= 0;
		end
	endcase
end
endmodule