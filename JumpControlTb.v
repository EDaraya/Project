`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:38:34 01/11/2021
// Design Name:   JumpControl
// Module Name:   C:/Users/Eduardo/Desktop/Proyecto/Proyecto_Final/JumpControlTb.v
// Project Name:  Proyecto_Final
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: JumpControl
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module JumpControlTb;

	// Inputs
	reg [2:0] Funct3;
	reg ForceJump;
	reg Branch;
	reg Zero;
	// Outputs
	wire BranchMux;
	// Instantiate the Unit Under Test (UUT)
	JumpControl uut (
		.Funct3(Funct3), 
		.ForceJump(ForceJump), 
		.Branch(Branch), 
		.Zero(Zero), 
		.BranchMux(BranchMux)
	);
	initial 
		begin
			// Initialize Inputs
			Funct3 = 0;
			ForceJump = 0;
			Branch = 0;
			Zero = 0;

			// Wait 100 ns for global reset to finish
			#100;     
			// Add stimulus here
			Funct3 = 3'b111;
			ForceJump = 1'b0;
			Branch = 1'b0;
			Zero = 1'b1;
			#10
			Funct3 = 3'b000;
			ForceJump = 1'b1;
			Branch = 1'b0;
			Zero = 1'b1;
			#10
			Funct3 = 3'b000;
			ForceJump = 1'b0;
			Branch = 1'b1;
			Zero = 1'b1;
			#10
			Funct3 = 3'b001;
			ForceJump = 1'b0;
			Branch = 1'b1;
			Zero = 1'b0;
		end
endmodule

