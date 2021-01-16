`timescale 1ns / 1ps
//	Bloque que se encarga de poner los valores correspondientes a cada una de las senales de control.
//	Entradas: Opcode
//	Salida: ALUOp,ForceJump,Branch,JumpPC,JumpRD,MemToReg,MemWrite,ALUscr,LUIscr,RegWrite 
/*
	Procedimiento: 
	Se realiza un case para hacer referencia a la lógica combinacional y en función de cada caso
	del valor de Opcode se generan los valores correspondientes de las señales de control.
*/

module UC	(
				input wire [6:0] Opcode,
				output wire [3:0] ALUOp,
				output reg ForceJump,Branch,JumpPC,JumpRD,MemToReg,MemWrite,ALUscr,LUIscr,RegWrite 
				); 
	
	assign ALUOp = {Opcode[6:4],Opcode[2]};
	always @(*)
		case(Opcode)
		//######################################################################################
			7'b0110011:		begin							// Tipo R	(add/sub)
									ForceJump	<= 1'b0;
									Branch 		<= 1'b0;
									JumpPC 		<= 1'b0;
									JumpRD 		<= 1'b0;
									MemToReg		<= 1'b0;
									MemWrite		<= 1'b0;
									ALUscr 		<= 1'b0;
									LUIscr 		<= 1'b1;
									RegWrite 	<= 1'b1;
								end
		//######################################################################################
			7'b0000011:		begin							// Tipo I	(lw/lbu)
									ForceJump 	<= 1'b0;
									Branch 		<= 1'b0;
									JumpPC 		<= 1'b0;
									JumpRD 		<= 1'b0;
									MemToReg 	<= 1'b1;
									MemWrite 	<= 1'b0;
									ALUscr 		<= 1'b1;
									LUIscr 		<= 1'b1;
									RegWrite 	<= 1'b1;
								end
		//######################################################################################
			7'b0010011:		begin							// Tipo I	(addi/andi/srli/slli/srai/mv/nop)
									ForceJump 	<= 1'b0;
									Branch 		<= 1'b0;
									JumpPC 		<= 1'b0;
									JumpRD 		<= 1'b0;
									MemToReg 	<= 1'b0;
									MemWrite 	<= 1'b0;
									ALUscr 		<= 1'b1;
									LUIscr 		<= 1'b1;
									RegWrite 	<= 1'b1;
								end
		//######################################################################################
			7'b1100111:		begin							// Tipo I	(jalr)
									ForceJump 	<= 1'b1;
									Branch 		<= 1'b0;
									JumpPC 		<= 1'b1;
									JumpRD 		<= 1'b1;
									MemToReg 	<= 1'bx;
									MemWrite 	<= 1'b0;
									ALUscr 		<= 1'b1;
									LUIscr 		<= 1'b1;
									RegWrite 	<= 1'b1;
								end
		//######################################################################################
			7'b0100011:		begin							// Tipo S	(sw,sb)
									ForceJump 	<= 1'b0;
									Branch 		<= 1'b0;
									JumpPC 		<= 1'b0;
									JumpRD 		<= 1'bx;
									MemToReg 	<= 1'bx;
									MemWrite 	<= 1'b1;
									ALUscr 		<= 1'b1;
									LUIscr 		<= 1'b1;
									RegWrite 	<= 1'b0;
								end
		//######################################################################################
			7'b1100011:		begin							// Tipo B	(bne)
									ForceJump 	<= 1'b0;
									Branch 		<= 1'b1;
									JumpPC 		<= 1'b0;
									JumpRD 		<= 1'bx;
									MemToReg 	<= 1'bx;
									MemWrite 	<= 1'b0;
									ALUscr 		<= 1'b0;
									LUIscr 		<= 1'b1;
									RegWrite 	<= 1'b0;
								end
		//######################################################################################
			7'b0110111:		begin							// Tipo U	(lui)
									ForceJump 	<= 1'b0;
									Branch 		<= 1'b0;
									JumpPC 		<= 1'b0;
									JumpRD 		<= 1'b0;
									MemToReg 	<= 1'b0;
									MemWrite 	<= 1'b0;
									ALUscr 		<= 1'b1;
									LUIscr 		<= 1'b0;
									RegWrite 	<= 1'b1;
								end
		//######################################################################################
			7'b1101111:		begin							// Tipo J	(jal,j)
									ForceJump 	<= 1'b1;
									Branch 		<= 1'b0;
									JumpPC 		<= 1'b0;
									JumpRD		<= 1'b1;
									MemToReg 	<= 1'b0;
									MemWrite 	<= 1'b0;
									ALUscr 		<= 1'b1;
									LUIscr 		<= 1'b1;
									RegWrite 	<= 1'b1;
								end
		//######################################################################################
			default:			begin							// Otros casos
									ForceJump 	<= 1'b0;
									Branch 		<= 1'b0;
									JumpPC 		<= 1'b0;
									JumpRD 		<= 1'b0;
									MemToReg 	<= 1'b0;
									MemWrite 	<= 1'b0;
									ALUscr 		<= 1'b0;
									LUIscr 		<= 1'b0;
									RegWrite 	<= 1'b0;
								end
		//######################################################################################
		endcase
endmodule
