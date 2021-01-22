`timescale 1ns / 1ps
/*
Objetivo:
	Probar que el modulo genera la salida correcta para cada caso.

Procedimiento:
	Se le asignan los distintos valores posibles de las entradas para observar los valores a la salida. 
	A continuación se muestran los estimulos de entrada y el resultado esperado en cada caso.
	
	ForceJump = 0 y Branch = 0			BranchMux <= 1'b0;
			Funct3 = 3'b111;
			ForceJump = 1'b0;
			Branch = 1'b0;
			Zero = 1'b1;
			#10
	ForceJump = 1 y Branch = 0			BranchMux <= 1'b1;	jump
			Funct3 = 3'b000;
			ForceJump = 1'b1;
			Branch = 1'b0;
			Zero = 1'b1;
			#10
	ForceJump = 0 y Branch = 1			BranchMux <= 1'b1;	beq y se cumple cond
			Funct3 = 3'b000;
			ForceJump = 1'b0;
			Branch = 1'b1;
			Zero = 1'b1;
			#10
	ForceJump = 0 y Branch = 1 		BranchMux <= 1'b0; 
			Funct3 = 3'b000;
			ForceJump = 1'b0;
			Branch = 1'b1;
			Zero = 1'b0;
			#10
	ForceJump = 0 y Branch = 1			BranchMux <= 1'b1;	bne y se cumple cond
			Funct3 = 3'b001;
			ForceJump = 1'b0;
			Branch = 1'b1;
			Zero = 1'b0;
*/
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
			// ForceJump = 0 y Branch = 0
			Funct3 = 3'b111;
			ForceJump = 1'b0;
			Branch = 1'b0;
			Zero = 1'b1;
			#10
			// ForceJump = 1 y Branch = 0
			Funct3 = 3'b000;
			ForceJump = 1'b1;
			Branch = 1'b0;
			Zero = 1'b1;
			#10
			// ForceJump = 0 y Branch = 1 y se cumple condicional
			// beq
			Funct3 = 3'b000;
			ForceJump = 1'b0;
			Branch = 1'b1;
			Zero = 1'b1;
			#10
			// ForceJump = 0 y Branch = 1 y no se cumple condicional
			// bne
			Funct3 = 3'b000;
			ForceJump = 1'b0;
			Branch = 1'b1;
			Zero = 1'b0;
			#10
			// ForceJump = 0 y Branch = 1
			Funct3 = 3'b001;
			ForceJump = 1'b0;
			Branch = 1'b1;
			Zero = 1'b0;
		end
endmodule

