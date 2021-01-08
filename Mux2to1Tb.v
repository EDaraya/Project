`timescale 10ns / 1ps

//Funcionalidad
//Se busca que el valor de salida del mux concuerde con el valor que
//es seleccionador por el seleccionador.

//Procedimiento
//Se asigna un Valor a A y un valor a B, en esta prueba si el 
//valor del seleccionador esta en 0, se espera el valor de A
//en la salida, si el seleccionador esta en 1, se esta el valor de B.

module Mux2to1Tb;

	// Inputs
	reg Sel;
	reg [31:0] A;
	reg [31:0] B;

	// Outputs
	wire [31:0] C;

	// Instantiate the Device Under Test (UUT)
	Mux2to1 DUT (
		.Sel(Sel), 
		.A(A), 
		.B(B), 
		.C(C)
	);

	initial
	begin
		// Initialize Inputs
		Sel = 1'b0;
		A = 29;
		B = 13;
		
		#10;
		
		Sel = 1'b1;
		
		#10;
		
		Sel = 1'b0;
        
		// Add stimulus here

	end
endmodule

