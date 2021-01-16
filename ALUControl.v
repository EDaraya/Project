`timescale 1ns / 1ps
// Bloque que genera la señal para seleccionar cual operación debe relizar la ALU
// Entradas: ALUOp, Funct7[5], Funct7[0] y Funct3.
// Salidas: ALU_Control
/*
	Procedimiento:
	Para cada tipo de instrucción se obtienen ciertos cambios en ALUOp, Funct7 y Funct3.
	En el caso de Funct7, sólo hay cambios importantes en Funct7[5] y Funct7[0].
	En función de dichas entradas se genera el valor correspondiente de la salida ALU_Control,
	ya que se trata de una lógica combinacional.
*/
module ALUControl	(
						input wire [3:0] ALUOp,
						input wire Funct75,Funct70,
						input wire [2:0] Funct3,
						output reg [4:0] ALU_Control						
						);
always @(*)
	begin
		//#################################################################################
		//	Tipo R
		if((ALUOp==4'b0110)&&(Funct75==1'b0)&&(Funct70==1'b0)&&(Funct3==3'b000))			// add
			ALU_Control <= 5'b00000;
		else if((ALUOp==4'b0110)&&(Funct75==1'b1)&&(Funct70==1'b0)&&(Funct3==3'b000))		// sub
			ALU_Control <= 5'b00010;
		else if((ALUOp==4'b0110)&&(Funct75==1'b0)&&(Funct70==1'b0)&&(Funct3==3'b111))		// and
			ALU_Control <= 5'b11100;
		//#################################################################################
		// Tipo I
		else if((ALUOp==4'b0010)&&(Funct3==3'b000))													// (addi/mv,nop)
			ALU_Control <= 5'b00000;
		else if((ALUOp==4'b0010)&&(Funct3==3'b100))													// xori
			ALU_Control <= 5'b10000;
		else if((ALUOp==4'b0010)&&(Funct3==3'b111))													// andi
			ALU_Control <= 5'b11100;
		else if((ALUOp==4'b0010)&&(Funct75==1'b0)&&(Funct70==1'b0)&&(Funct3==3'b001))		// slli
			ALU_Control <= 5'b00100;
		else if((ALUOp==4'b0010)&&(Funct75==1'b0)&&(Funct70==1'b0)&&(Funct3==3'b101))		// srli
			ALU_Control <= 5'b10100;
		else if((ALUOp==4'b0010)&&(Funct75==1'b1)&&(Funct70==1'b0)&&(Funct3==3'b101))		// srai
			ALU_Control <= 5'b10110;
		else if((ALUOp==4'b0000)&&(Funct3==3'b010))													// lw
			ALU_Control <= 5'b00000;
		else if((ALUOp==4'b0000)&&(Funct3==3'b100))													// lbu
			ALU_Control <= 5'b00000;
		else if((ALUOp==4'b1101)&&(Funct3==3'b000))													// (jalr/ret)
			ALU_Control <= 5'b00000;
		//#################################################################################
		//	Tipo S
		else if((ALUOp==4'b0100)&&(Funct3==3'b000))													// sb
			ALU_Control <= 5'b00000;
		else if((ALUOp==4'b0100)&&(Funct3==3'b010))													// sw
			ALU_Control <= 5'b00000;
		//#################################################################################
		// Tipo B
		else if((ALUOp==4'b1100)&&(Funct3==3'b001))													// bne
			ALU_Control <= 5'b10000;
		//#################################################################################
		// Tipo U
		else if(ALUOp==4'b0111)																				// lui
			ALU_Control <= 5'b11111;
		//#################################################################################
		// Tipo J
		else if(ALUOp==4'b1101)																				// (jal,j)
			ALU_Control <= 5'b00000;
		//#################################################################################
		else
			ALU_Control <= 5'b00000;																		//	Otros casos
		//#################################################################################
	end
endmodule
