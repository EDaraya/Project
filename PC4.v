`timescale 1ns / 1ps
// Bloque del sumador que genera el valor de PC+4
// Entrada: PC
// Salida: PC4 
/* 
	Procedimiento: 
	Se le suma al PC el valor de 4 y a la salida PC4 se le asigna dicho resultado.
*/
module PC4	( 
				input wire  [31:0] PC,
				output wire [31:0] PC4
				);
	
	assign PC4 = PC + 32'd4;
endmodule
