// Zuhair Shaikh and Brant Lan Li
// 4 to 16 Decoder
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University

`timescale 1ns/10ps

module decoder_4_16(

	input wire [3:0] decoderIn, 
	output reg [15:0] decoderOut
	);

	always@(*) begin
	
		case(decoderIn)
		
         		4'b0000 : decoderOut <= 16'h0001;     
         		4'b0001 : decoderOut <= 16'h0002;   
					4'b0010 : decoderOut <= 16'h0004; 
         		4'b0011 : decoderOut <= 16'h0008;  
         		4'b0100 : decoderOut <= 16'h0010;    
         		4'b0101 : decoderOut <= 16'h0020;   
         		4'b0110 : decoderOut <= 16'h0040;
         		4'b0111 : decoderOut <= 16'h0080;    
         		4'b1000 : decoderOut <= 16'h0100;    
         		4'b1001 : decoderOut <= 16'h0200;    
         		4'b1010 : decoderOut <= 16'h0400;   
         		4'b1011 : decoderOut <= 16'h0800;  
         		4'b1100 : decoderOut <= 16'h1000;  
         		4'b1101 : decoderOut <= 16'h2000;    
         		4'b1110 : decoderOut <= 16'h4000;   
         		4'b1111 : decoderOut <= 16'h8000;   
					default : decoderOut <= 16'h0000;
      endcase
		
   end
	
endmodule 