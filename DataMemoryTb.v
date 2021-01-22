`timescale 10ns / 1ps
/* 
Objetivo: 
	Comprobar el correcto almacenamiento y lectura de datos, dependiendo de sus entradas.
	Debe probarse la correcta lectura de un dato para WE = 0 y la correcta escritura para WE = 1
Procedimiento:
	Escribir datos en distintas addres y comprobar que la salida posea el valor de estos.
	En esta prueba debido a que WE es 1, el primer valor a esperar en RD es el valor de 15 en el byte más significativo. 
	Este valor debe escribirse en el otro ciclo de reloj, por lo tanto
	RD tendra un momento un valor indeterminado. Luego sucede lo mismo con el valor de 10.
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
	// Instantiate the Unit Under Test (uut)
	DataMemory uut (
		.clk(clk), 
		.WE(WE), 
		.BE(BE),
		.A(A), 
		.WD(WD),
		.RD(RD)
	);
	initial 
		begin
			// Initialize Inputs
			clk = 0;
			WE = 0;
			BE = 4'b0000;
			A = 0;
			WD = 0;
			// Wait 100 ns for global reset to finish
			#100
			// Add stimulus here
			WE = 1;
			BE = 4'b1000;
			A = 0;
			WD = 255;
			
			#15;		
			WE = 0;
			#15;
			
			WE = 1;
			BE = 4'b0100;
			WD = 255;
			
			#15;
			WE=0;
			#15;
			
			WE = 1;
			BE = 4'b0010;
			WD = 255;
			
			#15;
			WE=0;
			#15;
			
			WE = 1;
			BE = 4'b0001;
			WD = 255;
			
			#15;
			WE=0;
			#15;
			
			WE = 1;
			BE = 4'b0000;
			A = 4;
			WD = -255;
		end
   always 
		#5 clk=!clk;
endmodule
