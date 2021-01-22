`timescale 1ns / 1ps
/*
Objetivo:
	Inicializar el valor de la entrada PC y verificar que a la salida PC4 se obtenga un valor de PC+4.

Procedimiento:
	Se Inicializa el valor de PC en 0 y lo que se espera en la salida PC4 es el valor inicial +4. 
	En este caso como se inicializa en 0, el valor de salida esperado es 4.
*/
module PC4Tb;

	// Inputs
	reg [31:0] PC;
	// Outputs
	wire [31:0] PC4;
	// Instantiate the Unit Under Test (uut)
	PC4 uut (
		.PC(PC), 
		.PC4(PC4)
	);
	initial
		begin
			// Initialize Inputs
			PC = 0; 
			// Wait 100 ns for global reset to finish
			#100;
		end
endmodule
