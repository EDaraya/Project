`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:11:54 01/11/2021
// Design Name:   ALUControl
// Module Name:   C:/Users/Eduardo/Desktop/Proyecto/Proyecto_Final/ALUControlTb.v
// Project Name:  Proyecto_Final
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALUControl
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALUControlTb;

	// Inputs
	reg [3:0] ALUOp;
	reg Funct75;
	reg Funct70;
	reg [2:0] Funct3;

	// Outputs
	wire [4:0] ALU_Control;

	// Instantiate the Unit Under Test (UUT)
	ALUControl uut (
		.ALUOp(ALUOp), 
		.Funct75(Funct75), 
		.Funct70(Funct70), 
		.Funct3(Funct3), 
		.ALU_Control(ALU_Control)
	);

	initial 
		begin
			// Initialize Inputs
			ALUOp = 0;
			Funct75 = 0;
			Funct70 = 0;
			Funct3 = 0;
			// Wait 100 ns for global reset to finish
			#100;
			// Add stimulus here
			// add
			ALUOp = 4'b0110;
			Funct75 = 1'b0;
			Funct70 = 1'b0;
			Funct3 = 3'b000;
			#10
			// xori
			ALUOp = 4'b0010;
			Funct75 = 1'b0;
			Funct70 = 1'b0;
			Funct3 = 3'b100;
			#10
			// sb
			ALUOp = 4'b0100;
			Funct75 = 1'b0;
			Funct70 = 1'b0;
			Funct3 = 3'b000;
			#10
			// bne
			ALUOp = 4'b1100;
			Funct75 = 1'b0;
			Funct70 = 1'b0;
			Funct3 = 3'b001;
			#10			
			// lui
			ALUOp = 4'b0111;
			Funct75 = 1'b0;
			Funct70 = 1'b0;
			Funct3 = 3'b000;
			#10
			// jal
			ALUOp = 4'b1101;
			Funct75 = 1'b1;
			Funct70 = 1'b1;
			Funct3 = 3'b111;
		end
endmodule

