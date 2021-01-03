`timescale 1ns / 1ps
// Data Memory
// Bloque que se utiliza para almacenar palabras de 32 bits, en el cual se escriben y leen datos.  
// Entradas: clk, A, WE, WD.
// Salidas: RD

/*
	clk es la se�al de reloj para sincronizar la escritura, ya que esta es s�ncrona.
	A es la direcci�n a la cual se realiza la lectura o escritura de un dato, dependiendo del tipo de operaci�n.
	WD es el dato o palabra que puede llegar a escribirse en memoria.
	WE es la se�al de enable que hanilita la operaci�n de escitura en memoria.
	RD es el dato de 32 bist le�do en la direcci�n de memoria indicada por A.
*/
module DataMemory (
						input clk,      	        	// Se�al de reloj
						input wire [31:0] A,      	// Direcci�n
						input wire WE,            	// Enable
						input wire [31: 0] WD,    	// Dato de entrada
						output  [31:0] RD			  	// Dato a leer de memoria
						);

  // Definici�n de la memoria
  reg [31: 0] Ram [30:-30];	
  integer i;
  
  // Elaboraci�n de la nueva direcci�n
  wire [31:0] ADiv4;
  wire [31:0] NewA;
  assign ADiv4 = A/4;
  assign NewA = {{2{A[31]}},ADiv4[29:0]};		//Dividir entre 4 es dos LSL, hay que extender el n�mero.
  
  // Escritura de un dato.
  always @(posedge clock) 							
  begin
	 if(WE == 1)
		ram[NewA] <= WD;
  end
  
  // Lectura de un dato.	
  assign RD = ram[NewA];												
endmodule