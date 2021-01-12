`timescale 10ns / 1ps

//Funcionalidad Testbench
//Se busca que el valor se actualiza con la senal del clock

//Procedimiento
//Se inicializa el valor de PC4 en 0, y luego se cambia el valor a PC4 en 0
//por lo tanto cuando el clock entre en flanco positivo, se actualizara el valor de
//PCactualizado a PC4, en este caso 4..

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
		clk = 1;
		PC4 = 0;
		#10
		PC4 = 4;
	end
	always
		#5 clk =! clk;
endmodule
