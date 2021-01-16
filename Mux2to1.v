`timescale 1ns / 1ps
// Bloque de un Multiplexor de 2 a 1.
//	Entradas: A, B y Seleccionador.
//	Salidas: C.
/*
	Procedimiento:
	En función del valor del seleccionador se escoge entre una de las entradas
	y el valor escogido se almacena a en salida. 
*/
module Mux2to1 ( 
					input  Sel,
					input signed [31:0] A,B,
					output reg signed [31:0] C
					);
initial
	C = 32'b0;
always @(*)											//Un case para seleccionador el valor de la salida
	case(Sel)								//dependiendo del valor del seleccionador.
		1'b0:	C <= A;		
		1'b1:	C <= B;		
		default: C <= 32'b0;
	endcase 
endmodule
