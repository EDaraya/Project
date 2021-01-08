`timescale 1ns / 1ps
// Multiplexor 2 a 1
//Entradas: A, B y Seleccionador
//Salidas: C

module Mux2to1( 
					input  Sel,
					input [31:0] A,B,
					output reg [31:0] C
					);
initial
	assign C = 32'd0;
always @(*)											//Un case para seleccionador el valor de la salida
	case(Sel)								//dependiendo del valor del seleccionador.
		1'b0:	C <= A;		
		1'b1:	C <= B;		
		default: C <= 32'd0;
	endcase 
endmodule
