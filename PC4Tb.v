`timescale 1ns / 1ps

//Funcionalidad Testbench
//Se inicializa el valor y se corre esperando a que salga +4.

//Procedimiento
//Inicializar el valor de PC en 0 y lo que se espera
//en la salida es el Valor inicial +4. En este caso como
//se inicializa en 0, el valor de salida sera 4.

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
		PC = 0;      
endmodule
