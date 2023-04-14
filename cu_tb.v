// Zuhair Shaikh and Brant Lan Li
// Control Unit Testbench
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University

`timescale 1ns/10ps

module cu_tb;
	reg   Clock, Reset, Stop;
	
	datapath DUT(Clock, Reset, Stop);
		
	initial begin
		{Clock, Reset, Stop} = 0;
		forever #10 Clock = ~ Clock;
	end
endmodule