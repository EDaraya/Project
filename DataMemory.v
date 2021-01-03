`timescale 1ns / 1ps
// Data Memory
// Bloque que se utiliza para almacenar palabras de 32 bits, en el cual se escriben y leen datos.  
// Entradas: clk, A, WE, WD.
// Salidas: RD

/*
	clk es la señal de reloj para sincronizar la escritura, ya que esta es síncrona.
	A es la dirección a la cual se realiza la lectura o escritura de un dato, dependiendo del tipo de operación.
	WD es el dato o palabra que puede llegar a escribirse en memoria.
	WE es la señal de enable que hanilita la operación de escitura en memoria.
	RD es el dato de 32 bist leído en la dirección de memoria indicada por A.
*/
module DataMemory (
						input clk,      	        	// Señal de reloj
						input wire [31:0] A,      	// Dirección
						input wire WE,            	// Enable
						input wire [31: 0] WD,    	// Dato de entrada
						output  [31:0] RD			  	// Dato a leer de memoria
						);

  // Definición de la memoria
  reg [31: 0] Ram [30:-30];	
  integer i;
  
  // Elaboración de la nueva dirección
  wire [31:0] ADiv4;
  wire [31:0] NewA;
  assign ADiv4 = A/4;
  assign NewA = {{2{A[31]}},ADiv4[29:0]};		//Dividir entre 4 es dos LSL, hay que extender el número.
  
  // Escritura de un dato.
  always @(posedge clock) 							
  begin
	 if(WE == 1)
		ram[NewA] <= WD;
  end
  
  // Lectura de un dato.	
  assign RD = ram[NewA];												
endmodule