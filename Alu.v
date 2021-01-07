`timescale 1ns / 1ps
//	ALU
//	Realiza las siguientes operaciones: suma, resta, and, xor, sll(slli) y sra(srai)
//	Entradas: Operandos RD1 y RD2, y ALU_Control el seleccionador de la op.  
//	Salidas: Salida de la operación entre RD1 y RD2, y la bandera de zero 

module Alu	(
				input signed [31:0] RD1,RD2, 		// ALU 32-bit Inputs                 
				input [4:0] ALU_Control,			// ALU Selector
				output signed[31:0] ALU_Result,	// ALU 32-bit Output
				output Zero								// Bandera para condicional
				);
				
    reg signed [31:0] Result;
    assign ALU_Result = Result;
	 
	 //mux ALU
	 always @(*)
	 begin
	 case(ALU_Control)
		 5'b00000: 	Result <= RD1 + RD2;		//ADD(add/addi)
		 5'b00010: 	Result <= RD1 - RD2;		//SUB
		 5'b11100: 	Result <= RD1 & RD2;		//AND(and/andi)	  
		 5'b10000: 	Result <= RD1 ^ RD2;		//XOR(xori/bne)	  
		 5'b00100: 	Result <= RD1 << RD2;	//SLL(SLLI)
		 5'b10100: 	Result <= RD1 >> RD2;	//SRL(SRLI)
		 5'b10110:	Result <= RD1 >>> RD2;	//SRA(SRAI)
		 5'b11111:	Result <= RD1 + RD2;		//LUI
		 default:	Result <= 32'b0;			//casos que no importan
	 endcase 
	 end
	 
	//condicionales
	assign Zero = (ALU_Result==0) ? 1'b1:1'b0;
endmodule