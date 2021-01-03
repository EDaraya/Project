`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:05:11 12/29/2020 
// Design Name: 
// Module Name:    instruction_memory 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
//Modulo para la instruction memory. 
//"op1.txt" contiene las instrucciones en hexadecimal de la operacion 1. 
module instruction_memory(clk, address, instruction);

input				clk;
input	[31:0]	address;
output[31:0]	instruction;

reg	[31:0]	instruction;

//	memAddr is an address register in the memory side.
reg	[31:0]	memAddr;
reg	[31:0]	iMem[0:29];

	//	Definition of the latency to latch the address and
	//	read the memory.
parameter	addressLatch = 10, memDelay = 70;

	//	The I-Memory is initially loaded
initial
	$readmemh ("op1.txt", iMem);

	//	I-mem is read in every cycle.
	//	A read signal could be added if neccessary.
always @(posedge clk) begin
	#addressLatch	memAddr = address;
	#memDelay	instruction = iMem[memAddr];
end

endmodule


