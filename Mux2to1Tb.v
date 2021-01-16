`timescale 10ns / 1ps
/*
Objetivo:
	Se busca que el valor de salida del Mux concuerde con el valor que
	es seleccionador por el seleccionador.
Procedimiento:
	Se asigna un Valor a A y B, y si el valor del seleccionador esta en 0, se espera el valor de A
	en la salida. Si el seleccionador esta en 1, se obtiene el valor de B.
*/
module Mux2to1Tb;

	// Inputs
	reg Sel;
	reg [31:0] A;
	reg [31:0] B;
	// Outputs
	wire [31:0] C;
	// Instantiate the Unit Under Test (uut)
	Mux2to1 uut (
		.Sel(Sel), 
		.A(A), 
		.B(B), 
		.C(C)
	);
	initial
		begin
			// Initialize Inputs
			Sel = 0;
			A = 0;
			B = 0;
			// Wait 100 ns for global reset to finish
			#100;
			// Add stimulus here
			A = 29;
			B = 13;
			
			#10;
			Sel = 1'b1;
			#10;
			
			Sel = 1'b0;
		end
endmodule

