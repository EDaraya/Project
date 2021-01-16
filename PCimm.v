`timescale 1ns / 1ps
// Bloque del sumador que genera el dato PC + inmediato.
// Entrada: PC
// Salida: PCimm 
/*	
	Procedimiento: 
	Se le suma al valor de PC un inmediato y dicho resultado se almacena en la salida PCimm.
*/
module PCimm	( 
					input wire signed  [31:0] PC,
					input wire signed  [31:0] Imm,
					output wire signed [31:0] PCimm
					);
	
	assign PCimm = PC + Imm;
endmodule
