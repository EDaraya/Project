`timescale 10ns / 1ps
/*
Objetivo:
	Probar que el modulo de generación de valores inmmediatos funcione correctamente.

Procedimiento:
	Se le envian una instrucción en hexadecimal para cada uno de los distintos tipos de instrcciones y se verifica 
	que los valores inmediatos que son generados sean los correctos.
	Tipo I: imm = -48
	Tipo S: imm = 44
	Tipo B: imm = 16
	Tipo U: imm = 45056
	Tipo J: imm = 12
*/
module ImmGeneratorTb;

	// Inputs
	reg [31:0] Inst;
	// Outputs
	wire [31:0] Imm;
	// Instantiate the Unit Under Test (uut)
	ImmGenerator uut (
		.Inst(Inst), 
		.Imm(Imm)
	);
	initial 
		begin
			// Initialize Inputs
			Inst = 0;
			// Wait 100 ns for global reset to finish
			#100; 
			// Add stimulus here
			Inst = 32'hfd010113;	// Tipo I
			#10;
			Inst = 32'h02812623;	// Tipo S
			#10;
			Inst = 32'h00f71863;	// Tipo B
			#10;
			Inst = 32'h0000b7b7;	//	Tipo U
			#10;
			Inst = 32'h00c0006f;	//	Tipo J
		end
endmodule


