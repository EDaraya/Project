`timescale 10ns / 1ps
/*	
Objetivo:
	Desmostrar la correcta lectura de datos en los distintos registros
	del conjunto del n�mero de instrucciones.
Procedimiento:
	Debido al funcionamiento en la memoria de instruciones, esta avanza cada +4, entonces se tiene que esperar que
	A recorra 4 ciclos o avance 4 numeros para obtener la siguiente instruccion.
	El resultado esperado es ver como RD posee diferentes valores cada 4 valores de A, ya que cada +4 es una instrucci�n.
*/
module InstructionMemoryTb;

	// Inputs
	reg [31:0] A;
	// Outputs
	wire [31:0] RD;
	// Instantiate the Unit Under Test (uut)
	InstructionMemory uut (
		.A(A), 
		.RD(RD)
	);
	integer i;
	initial 
		begin
			// Initialize Inputs
			A = 0;
			// Wait 100 ns for global reset to finish
			#100
			// Add stimulus here
			for(i=1;i<61;i=i+1)
				begin
					A=A+1;
					#2;
				end
			#1;
		end
endmodule


