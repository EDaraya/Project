`timescale 10ns / 1ps
// Register File TestBench
// Objetivo: Probar el correcto funcionamiento de la lectura y almacenamiento de los datos en el banco de registros.
/*Procedimiento:
Primero se coloca el clock en 1, y luego se inicializan las entradas. 
Se realiza una operacion de escritura en un registro destino (A3) y la idea es leer ese registro en A1 o A2.
Por ultimo aplicar reset para verificar que haga su función esperada.
En este caso se coloca A3 (Direccion que se desea leer) en 10 y WE esta en 1, para habilitar la escritura.
WD3 posee el valor de 10 entonces, en la direccion 10 del banco de registros se guarda un valor de 10
Finalmente, se recorre todo el banco de registros y cuando se pasa por la posicion 10, RD1
debe tener el valor de 10 en decimal.
*/

module RegisterFileTb;

	// Inputs
	reg clk;
	reg [4:0] A1;
	reg [4:0] A2;
	reg [4:0] A3;
	reg WE3;
	reg [31:0] WD3;
	reg reset;

	// Outputs
	wire [31:0] RD1;
	wire [31:0] RD2;

	// Instantiate the Unit Under Test (UUT)
	RegisterFile uut (
		.clk(clk), 
		.A1(A1), 
		.A2(A2), 
		.A3(A3), 
		.WE3(WE3), 
		.WD3(WD3),
		.reset(reset),
		.RD1(RD1), 
		.RD2(RD2)
	);
	integer i;
	initial begin
		// Initialize Inputs
		clk = 1;
		reset = 0;
		A1 = 0;						//Direccion de RD1
		A2 = 0;						//Direccion de RD2
		A3 = 8;						//Direccion a escribir
		WE3 = 1;						//Enable para escritura
		WD3 = 10;					//Valor a escribir
		
		for(i=1;i<15;i=i+1)begin
			A1=A1+1;
			#2;
			end
			
		
	/*
		#10;
		
		WD3 = 5;
		A1 = 1;
		A2 = 8;
		A3 = 1;
		
		#15
		
		reset = 1;
	*/
	end
   
	always 
	#5 clk =! clk;
endmodule

