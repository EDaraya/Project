`timescale 1ns / 1ps
// Bloque que permite seleccionar si realiza un salto condicional(Branch) o uno incondicinal(Jump)
// Entradas: Funct3, ForceJump, Branch y Zero
// Salidas: BranchMux
/*
	Procedimiento:
	Si se trata de un Jump la salida siempre debe ser 1, y en caso de un Branch la salida sólo es 1
	si el condicional sí se cumple 
*/
module JumpControl	(
							input [2:0] Funct3,
							input ForceJump,Branch,Zero,
							output reg BranchMux
							);

always @(*)
	begin
		if(ForceJump == 1'b1)																					//	jal/j
			BranchMux <= 1'b1;
		else if((Funct3 == 3'b000)&&(ForceJump == 1'b0)&&(Branch == 1'b1)&&(Zero==1'b1))		//	beq
			BranchMux <= 1'b1;
		else if((Funct3 == 3'b001)&&(ForceJump == 1'b0)&&(Branch == 1'b1)&&(Zero==1'b0))		//	bne
			BranchMux <= 1'b1;
		else
			BranchMux <= 1'b0;																					// PC+4
	end
endmodule
