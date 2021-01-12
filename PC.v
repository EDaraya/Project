`timescale 1ns / 1ps

//Entrada:clock y PC4
//Salida: PCactualizado
//Procedimiento: con el cambio del clock se actualiza el dato de la salida.

module PC	( 
				input clk,
				input wire [31:0] PC4,
				output reg [31:0] PC
				);
initial
	PC = 32'd0;
always@(posedge clk)
	PC <= PC4;
endmodule
