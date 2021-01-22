`timescale 1ns / 1ps
/*
Objetivo:
	Probar que el modulo del sumador del PC con un inmmediato funciona correctamente.

Procedimiento:
	Se le asigna un valor de 4 al PC y un valor de 4 al inmediato.
	A la salida debería obtenerse el valor de 8.
*/
module PCimmTb;

	// Inputs
	reg [31:0] PC;
	reg [31:0] Imm;

	// Outputs
	wire [31:0] PCimm;

	// Instantiate the Unit Under Test (UUT)
	PCimm uut (
		.PC(PC), 
		.Imm(Imm), 
		.PCimm(PCimm)
	);

	initial 
		begin
			// Initialize Inputs
			PC = 0;
			Imm = 0;
			// Wait 100 ns for global reset to finish
			#100;
			// Add stimulus here
			PC = 4;
			Imm = 4;
		end
endmodule

