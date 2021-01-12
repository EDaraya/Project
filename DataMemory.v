`timescale 1ns / 1ps
// Bloque que se utiliza para almacenar palabras de 32 bits, en el cual se escriben y leen datos.  
// Entradas: clk, WE, BE, A y WD.
// Salidas: RD
/*
	clk es la se�al de reloj para sincronizar la escritura, ya que esta es s�ncrona.
	A es la direcci�n a la cual se realiza la lectura o escritura de un dato, dependiendo del tipo de operaci�n.
	WD es el dato o palabra que puede llegar a escribirse en memoria.
	WE es la se�al de enable que habilita la operaci�n de escitura en memoria.
	RD es el dato de 32 bist le�do en la direcci�n de memoria indicada por A.
*/
module DataMemory	(
						input clk,		      	   // Se�al de reloj.
						input wire WE,            	// Enable de la escritura.
						input wire [3:0] BE,       // Byte al cual se habilita la escritura.
						input wire [31:0] A,      	// Direcci�n de lectura/escritura. 
						input wire [31:0] WD,    	// Dato de entrada.
						output [31:0] RD			  	// Dato a leer de memoria.
						);
						
  // Definici�n de la memoria
  parameter MEM_DEPTH = 1024;
  reg [7:0] RAM[3:0][MEM_DEPTH-1:-MEM_DEPTH+1];
  integer i;
  // Se inicializan la memoria en 0s.
  initial
	  begin
		for(i=-MEM_DEPTH+1;i<MEM_DEPTH;i=i+1)
			RAM[0][i] = 32'd0;
		for(i=-MEM_DEPTH+1;i<MEM_DEPTH;i=i+1)
			RAM[1][i] = 32'd0;
		for(i=-MEM_DEPTH+1;i<MEM_DEPTH;i=i+1)
			RAM[2][i] = 32'd0;
		for(i=-MEM_DEPTH+1;i<MEM_DEPTH;i=i+1)
			RAM[3][i] = 32'd0;
	  end  
  // Lectura de un dato.(s�ncrona)	
  assign RD = {RAM[3][A],RAM[2][A],RAM[1][A],RAM[0][A]};
  // Escritura de un dato.(as�ncrona)
  always @(posedge clk) 							
		if(WE == 1)
			case(BE)
				4'b0001: RAM[0][A] <= WD[7:0];	// Byte 0
				4'b0010: RAM[1][A] <= WD[7:0];	// Byte 1
				4'b0100: RAM[2][A] <= WD[7:0];	// Byte 2
				4'b1000: RAM[3][A] <= WD[7:0];	// Byte 3
				default:	begin
								RAM[0][A] <= WD[7:0];
								RAM[1][A] <= WD[15:8];
								RAM[2][A] <= WD[23:16];
								RAM[3][A] <= WD[31:24];
							end
			endcase
endmodule
