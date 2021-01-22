`timescale 10ns / 1ps
/*
	Objetivo:
Se busca probar que el valor del registro PC se actualice tras cada senal del clk.

	Procedimiento:
Se inicializa el valor de NextPC en 0, y luego se cambia el valor a NextPC = 4
por lo tanto cuando el clk entre en flanco positivo, se debe actualizar el valor del
PC al valor del NextPC, en este caso con un valor de 4.
*/
module PCTb;

	// Inputs
	reg clk;
	reg [31:0] PC4;
	// Outputs
	wire [31:0] NextPC;
	// Instantiate the Unit Under Test (uut)
	PC uut (
		.clk(clk), 
		.PC4(PC4), 
		.NextPC(NextPC)
	);
	initial 
	begin
		// Initialize Inputs
		clk = 0;
		PC4 = 0; 
		// Wait 100 ns for global reset to finish
		#100;
		// Add stimulus here
		clk = 1;
		PC4 = 0;
		#10
		PC4 = 4;
	end
	always
		#5 clk=!clk;
endmodule
