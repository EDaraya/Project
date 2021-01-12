`timescale 1ns / 1ps

//Entradas: Numero con signo, numero sin signo y seleccionador
//Salidas: Numero extendido
//Procedimiento: se agarra el bit mas significativo de cada numero
//y se concatena hasta llegar a los bits deseados.
module ImmGenerator	(
							input [31:0] Inst,
							output reg signed [31:0] Imm
							);
 
initial
	Imm = 32'd0;
always@(*) 
	case(Inst[6:0])								
		7'b0000011:		Imm <= {{20{Inst[31]}}, {Inst[31:20]}};												//Tipo I	(lw,lbu)
		7'b0010011:		Imm <= {{20{Inst[31]}}, {Inst[31:20]}};												//Tipo I	(addi/mv/nop/andi/xori/srli/slli/srai)
		7'b1100111:		Imm <= {{20{Inst[31]}}, {Inst[31:20]}};												//Tipo I	(jalr,ret)
		7'b0100011: 	Imm <= {{20{Inst[31]}}, {Inst[31:25],Inst[11:7]}};									//Tipo S
		7'b1100011:		Imm <= {{19{Inst[31]}}, {Inst[31],Inst[7],Inst[30:25],Inst[11:8],1'b0}};	//Tipo B
		7'b0110111:		Imm <= {Inst[31:12], 12'b0};																//Tipo U
		7'b1101111:		Imm <= {{11{Inst[31]}}, {Inst[31],Inst[19:12],Inst[20],Inst[30:21],1'b0}};	//Tipo J
		default:	Imm <= 32'd0;
	endcase 
endmodule
