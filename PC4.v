`timescale 1ns / 1ps

//Entrada: PC
//Salida: PC4 
//Procedimiento: Se le suma al valor de PC 4 entonces queda guardado en PC+4.

module PC4	( 
				input wire  [31:0] PC,
				output wire [31:0] PC4
				);
	
	assign PC4 = PC + 32'd4;
endmodule
