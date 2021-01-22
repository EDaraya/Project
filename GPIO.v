`timescale 1ns / 1ps
//Entradas: clk, MemWrite, Ar, WDr
//Salidas: Outr
/*
Procedimiento: 
	De acuerdo a cada flanco positivo del clk y si la direccion Ar corresponde a la GPIO (0xABCD)
	y se trata de una operación de escritura, se guarda el dato en WDr en la salida Outr del registro GPIO.
*/
module GPIO	( 
				input wire signed MemWrite, clk,
				input wire signed [31:0] Ar, WDr,
				output reg signed [31:0] Outr
				);
// Se inicializa la salida en cero
initial
	Outr = 32'b0; 
// Se verifica si es la dirección del GPIO y si se trata de una Op de escritura en memoria 
always @(posedge clk)
	if ((Ar == 32'hABCD) && (MemWrite == 1'b1))
		Outr <= WDr;
endmodule
