`timescale 1ns / 1ps
// Bloque que se utiliza para almacenar palabras de 32 bits, en el cual se escriben y leen datos.  
// Entradas: clk, WE, BE, A y WD.
// Salidas: RD
/*
	clk es la señal de reloj para sincronizar la escritura, ya que esta es síncrona.
	A es la dirección a la cual se realiza la lectura o escritura de un dato, dependiendo del tipo de operación.
	WD es el dato o palabra que puede llegar a escribirse en memoria.
	WE es la señal de enable que habilita la operación de escitura en memoria.
	RD es el dato de 32 bist leído en la dirección de memoria indicada por A.
*/
module DataMemory	(
						input clk,		      	   // Señal de reloj.
						input wire WE,            	// Enable de la escritura.
						input wire [3:0] BE,       // Byte al cual se habilita la escritura.
						input wire [31:0] A,      	// Dirección de lectura/escritura. 
						input wire [31:0] WD,    	// Dato a escribir.
						output [31:0] RD			  	// Dato a leer de memoria en la A.
						);
						
  // Definición de la memoria
  parameter MEM_DEPTH = 64;
  reg [7:0] RAM[3:0][MEM_DEPTH:-MEM_DEPTH];
  // Definición de variable para inicializar valores en la memoria.	
  integer i;
  // Procedimiento para el funcionamiento de una instrucción por cada +4 
  wire [31:0] ADiv4;
  wire [31:0] Ad;
  assign ADiv4 = A/4;
  //	Divido entre cuatro es un LSR, por lo que hay que extender el signo del número.
  assign Ad = {{2{A[31]}},ADiv4[29:0]};
  // Se inicializa la memoria en 0s.
  initial
		for(i=(-MEM_DEPTH);i<(MEM_DEPTH+1);i=i+1)
			begin
				RAM[0][i] = 8'b0;
				RAM[1][i] = 8'b0;
				RAM[2][i] = 8'b0;
				RAM[3][i] = 8'b0;
			end 
	// Lectura de un dato.(asíncrona)	
	assign RD = {RAM[3][Ad],RAM[2][Ad],RAM[1][Ad],RAM[0][Ad]};
	// Escritura de un dato.(síncrona)
	always @(negedge clk) 		
		if(WE == 1)
	// Se escribe un byte.(sb)
			case(BE)
				4'b0001: RAM[0][Ad] <= WD[7:0];			// Byte 0
				4'b0010: RAM[1][Ad] <= WD[15:8];			// Byte 1
				4'b0100: RAM[2][Ad] <= WD[23:16];		// Byte 2
				4'b1000: RAM[3][Ad] <= WD[31:24];		// Byte 3
	// Por defecto se escriben todos los bytes.(sw)
				default:	begin
								RAM[0][Ad] <= WD[7:0];
								RAM[1][Ad] <= WD[15:8];
								RAM[2][Ad] <= WD[23:16];
								RAM[3][Ad] <= WD[31:24];
							end
			endcase
endmodule
