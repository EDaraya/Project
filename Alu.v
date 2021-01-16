`timescale 1ns / 1ps
//	Bloque que realiza las siguientes operaciones: add, sub, and, xor, sll(slli), sra(srai) y lui
//	Entradas: Operandos RD1 y RD2, y ALU_Control, el cual es el seleccionador de la operación.  
//	Salidas: ALU_Result y Zero, los cuales son salida de la op y la bandera que indica si el resultado fue 0. 
/*
	Procedimiento:
	Se realiza un case para cada valor de la señal ALU_Control y en cada caso se realiza la operación respectiva.
	Al final, se revisa el valor de ALU_Result para establecer el valor de la bandera Zero.
*/
module Alu	(
				input wire signed [31:0] RD1,RD2, 			//	ALU 32-bit Inputs                 
				input wire [4:0] ALU_Control,					// ALU Selector
				output reg signed [31:0] ALU_Result,			// ALU 32-bit Output
				output wire Zero									// Bandera para condicional
				);
				
	//mux ALU
	always @(*)
		case(ALU_Control)
			5'b00000:	ALU_Result <= RD1 + RD2;		//	add	(add/addi/jalr/jal/j)
			5'b00010: 	ALU_Result <= RD1 - RD2;		//	sub	(sub/beq)
			5'b11100: 	ALU_Result <= RD1 & RD2;		//	and	(and/andi)	  
			5'b10000: 	ALU_Result <= RD1 ^ RD2;		//	xor	(xor/xori/bne)	  
			5'b00100: 	ALU_Result <= RD1 << RD2;		//	sll	(sll/slli)
			5'b10100: 	ALU_Result <= RD1 >> RD2;		//	srl	(srl/srli)
			5'b10110:	ALU_Result <= RD1 >>> RD2;		//	sra	(sra/srai)
			5'b11111:	ALU_Result <= RD1 + RD2;		//	lui
			default:	ALU_Result <= 32'b0;					//	Otros casos
		endcase 
	//	Condicionales
	assign Zero = (ALU_Result==0) ? 1'b1:1'b0;			// Bandera
endmodule
