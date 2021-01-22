`timescale 10ns / 1ps
/*
Objetivo:
	Que el valor de salida del Multiplexor concuerde con el valor que
	es seleccionado por la entrada llamada Seleccionador.
Procedimiento:
	Se asigna un valor a A, B, C y D; pues cuando el valor del seleccionador 
	esta en 0, se espera obtener el valor de A en la salida.
	Si el seleccionador esta en 1, se obteniene el valor de B, y así sucesivamente.
*/
module Mux4to1Tb;

	// Inputs
	reg [1:0] Sel;
	reg [31:0] A;
	reg [31:0] B;
	reg [31:0] C;
	reg [31:0] D;
	// Outputs
	wire [31:0] E;
	// Instantiate the Unit Under Test (uut)
	Mux4to1 uut (
		.Sel(Sel), 
		.A(A), 
		.B(B), 
		.C(C),
		.D(D),
		.E(E)
	);
	initial
		begin
			// Initialize Inputs
			Sel = 0;
			A = 0;
			B = 0;
			C = 0;
			D = 0;
			// Wait 100 ns for global reset to finish
			#100;
			// Add stimulus here
			Sel = 2'b00;
			A = 1;
			B = 2;
			C = 3;
			D = 4;
			#10;
			Sel = 2'b01;
			A = 1;
			B = 2;
			C = 3;
			D = 4;
			#10;
			Sel = 2'b10;
			A = 1;
			B = 2;
			C = 3;
			D = 4;
			#10;
			Sel = 2'b11;
			A = 1;
			B = 2;
			C = 3;
			D = 4;
		end
endmodule

