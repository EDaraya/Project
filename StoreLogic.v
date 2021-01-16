`timescale 1ns / 1ps
// Bloque para manejar la las operaciones sw y sb.
// Entradas: D = RD2, ALU = ALU_Result[1:0], DT = Inst[13]. 
// Salidas: ND = dato a almacenar y BE = byte/bytes a almacenar(sb/sw).
/*
	Procedimiento:
	Dependiendo de la operaci�n (sw/sb) escribe en ND(New Data) la palabra completa, para en el caso de sw,
	y BE(Byte Enable) en 4'b1111.
	Para el caso de sb se escribe en ND el byte a escribir extendido a 32 bits y el valor respectivo de BE 
	para saber cual byte es el que se va escribir en el bloque de Data Memory. 
*/
module StoreLogic	(
						input wire [31:0] D,
						input wire [1:0] ALU,
						input wire DT,
						output reg [31:0] ND,
						output reg [3:0] BE
						);
						
reg [31:0] Word;

always @(*)
	begin
		// Se almacena el byte menos significativo de RD2 en la posici�n adecuada y se extiende a 32 bits.
		case(ALU)
			2'b00:	Word <= {24'b0,D[7:0]};
			2'b01:	Word <= {16'b0,D[7:0],8'b0};	
			2'b10:	Word <= {8'b0,D[7:0],16'b0};	
			2'b11:	Word <= {D[7:0],24'b0};		
			default:	Word <= 32'b0;
		endcase
		// Se almacena la palabra completa o el byte extendido a 32 bist.(sw/sb)	
		case(DT)
			1'b0:		ND <= Word;
			1'b1:		ND <= D;
			default:	ND <= 32'b0;
		endcase
		// Se establece el valor de BE para saber cual byte/bytes se van escribir en Data Memory.(sb/sw)
		if((ALU == 2'b00)&&(DT == 1'b0))
			BE <= 4'b0001;
		else if((ALU == 2'b01)&&(DT == 1'b0))
			BE <= 4'b0010;
		else if((ALU == 2'b10)&&(DT == 1'b0))
			BE <= 4'b0100;
		else if((ALU == 2'b11)&&(DT == 1'b0))
			BE <= 4'b1000;
		else
			BE <= 4'b1111;
	end
endmodule
