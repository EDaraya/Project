`timescale 10ns / 1ps
// Bloque que se utiliza para almacenar datos o palabras de 32 bits.
// Entradas: A
// Salida: el valor contenido en la direccion de memoria indicada.
/*	
	Procedimiento: Se abre un espacio de memoria en donde se guardan los datos cargados desde un archivo de texto.
	Estos datos corresponden a las instrucciones de cada uno de los 6 c�digos.
*/
module InstructionMemory	(
									input wire [31:0] A,
									output reg [31:0] RD
									);
									
  // Definici�n de la Memoria
  parameter SIZE = 32;	
  parameter MEM_DEPTH = 32;
  reg [SIZE-1:0] ROM[MEM_DEPTH-1:0];
  //	Procedimiento para funcionamiento de PC+4
  wire [31:0] ADiv4;
  wire [31:0] Ad;
  assign ADiv4 = A/4;
  //	Divido entre cuatro es un LSR, por lo que hay que extender el n�mero.
  assign Ad = {{2{A[31]}},ADiv4[29:0]};
  //	Lectura de instrucciones.
  initial 
	  begin
		$display("Loading ROM.");
		$readmemh("Rtype.txt", ROM);
	  end
  //	Lectura del dato en la direcci�n A		
  always @(*) 
	RD <= ROM[Ad];
endmodule