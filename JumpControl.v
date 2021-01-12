`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:05:52 01/09/2021 
// Design Name: 
// Module Name:    JumpControl 
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
module JumpControl	(
							input [2:0] Funct3,
							input ForceJump,Branch,Zero,
							output reg BranchMux
							);

always @(*)
	begin
		if((ForceJump == 1'b0)&&(Branch == 1'b0))	//	PC+4
			BranchMux <= 1'b0;
		else if((ForceJump == 1'b1)&&(Branch == 1'b0))	//	jal/j
			BranchMux <= 1'b1;
		else if((Funct3 == 3'b000)&&(ForceJump == 1'b0)&&(Branch == 1'b1)&&(Zero==1'b1))	//	beq
			BranchMux <= 1'b1;
		else if((Funct3 == 3'b001)&&(ForceJump == 1'b0)&&(Branch == 1'b1)&&(Zero==1'b0))	//	bne
			BranchMux <= 1'b1;
		else
			BranchMux <= 1'b0;
	end
endmodule
