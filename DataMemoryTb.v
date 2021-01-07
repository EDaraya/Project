`timescale 10ns / 1ps
// Data Memory Testbench
/* 
Objetivo: 
	Comprobar el correcto almacenamiento y lectura de datos, dependiendo de sus entradas.
	Debe probarse la correcta lectura de un dato para WE = 0 y la correcta escritura para WE = 1
Procedimiento
	Escribir datos en distintas addres y comprobar que la salida posea el valor de estos.
	En esta prueba debido a que WE es 1, el primer valor a esperar en RD es el valor de 15 en el byte más significativo. 
	Este valor debe escribirse en el otro ciclo de reloj, por lo tanto
	RD tendra un momento un valor indeterminado.Luego sucede lo mismo con el valor de 10.
*/

module DataMemoryTb;

	// Inputs
	reg clk;
	reg WE;
	reg [3:0] BE;
	reg [31:0] A;
	reg [31:0] WD;
	// Outputs
	wire [31:0] RD;
	// Instantiate the Device Under Test (UUT)
	DataMemory DUT (
		.clk(clk), 
		.A(A), 
		.WE(WE), 
		.BE(BE),
		.WD(WD),
		.RD(RD)
	);
	initial 
	begin
		// Initialize Inputs
		#15
		clk = 1;
		A = 3;
		WE = 1;
		BE = 4'b1000;
		WD = 15;

		#15;		
		WE = 0;
		
		#15;
		A = 6;
		WE = 1;
		BE = 4'b0100;
		WD = 255;
		
		#15;
		WE=0;
	end
   always 
	#5 clk =! clk;
endmodule

