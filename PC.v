`timescale 1ns / 1ps
// Bloque del registro PC que pasa el valor de entrada hacia su salida por cada flanco positivo de reloj.
// Entrada: PC y clk.
//	Salida: NextPC.	
/* 
	Procedimiento: 
	Con el cambio del clk se actualiza la salida con el dato que se encuentra a la entrada.
*/
module PC	( 
				input clk,
				input wire [31:0] NextPC,
				output reg [31:0] PC
				);
initial 
	PC = 32'b0;
always@(posedge clk)
	PC <= NextPC;
endmodule
