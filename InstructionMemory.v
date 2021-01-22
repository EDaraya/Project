`timescale 10ns / 1ps
// Bloque que se utiliza para almacenar datos o palabras de 32 bits.
// Entradas: A, instrucción a leer.
// Salida: RD, el valor contenido en la direccion de memoria indicada.
/*	
	Procedimiento: 
	Se abre un espacio de memoria en donde se guardan los datos cargados desde un archivo de texto.
	Estos datos corresponden a las instrucciones de cada uno de los 6 códigos.
*/
module InstructionMemory	(
									input wire [31:0] A,
									output reg [31:0] RD
									);
									
  // Definición de la Memoria
  parameter SIZE = 32;	
  parameter MEM_DEPTH = 100;
  reg [SIZE-1:0] ROM[MEM_DEPTH-1:0];
  // Procedimiento para el funcionamiento de PC+4
  wire [31:0] ADiv4;
  wire [31:0] Ad;
  assign ADiv4 = A/4;
  // Divido entre 4 es un LSR de 2, por lo que hay que extender el signo del número.
  assign Ad = {{2{A[31]}},ADiv4[29:0]};
  // Lectura de instrucciones.
  initial 
	  begin
		$display("Loading ROM.");
		//$readmemh(filename, memname, startadr, stopadr);
		$readmemh("C6.txt", ROM);
	  end
  // Lectura del dato en la dirección A		
  always @(*) 
	RD <= ROM[Ad];
endmodule