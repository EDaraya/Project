`timescale 1ns / 1ps
//	Mux4to1.
// Bloque de un Multiplexor de 4 a 1.
//	Entradas: A,B,C,D y el Seleccionador.
//	Salidas: E.

module Mux4to1 ( 
					input [1:0] Sel,
					input signed [31:0] A,B,C,D,
					output reg signed [31:0] E
					);
initial
	E = 32'b0;
always @(*) 								//Un case que elije el valor de la salida D
	case(Sel)								//dependiendo del valor en la entrada del seleccionador
		2'b00: 	E <= A;		
		2'b01: 	E <= B;
		2'b10: 	E <= C;
		2'b11: 	E <= D;
		default:	E <= 32'b0;
	endcase 
endmodule