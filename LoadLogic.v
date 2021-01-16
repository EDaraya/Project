`timescale 1ns / 1ps
// Bloque para manejar la carga de un byte extendido en ceros o todos los bytes de un dato.(lbu/lw).
// Entradas: D = dato o palabra leída de memoria, ALU = ALU_Result[1:0], DT = Inst[13] y Sign = Inst[14].
// Salidas: ND = Byte extendido a 32 bits con/sin signo o toda la palabra de entrada.
/*
	Procedimiento:
	Dependiendo de la operación (lw/lb) escribe en ND(New Data) la palabra completa, para en el caso de lw.
	y para el caso de lb se escribe en ND el byte escogido extendido a 32 bits con/sin signo en la parte más significativa. 
*/
module LoadLogic	(
						input wire [31:0] D,
						input wire [1:0] ALU,
						input wire DT,Sign,
						output reg [31:0] ND
						);
						
reg [7:0] Byte;	
reg [31:0] Word;

always @(*)
	begin
		// Se selecciona el byte.
		case(ALU)								
			2'b00: 	Byte <= D [7:0];		
			2'b01: 	Byte <= D [15:8];
			2'b10: 	Byte <= D [23:16];
			2'b11: 	Byte <= D [31:24];
			default:	Byte <= 8'b0;
		endcase
		// Se selecciona la extensión del byte a 32 bits con/sin signo.
		case(Sign)
			1'b0:		Word <= {{24{Byte[7]}},Byte};
			1'b1:		Word <= {{24'b0},Byte};
			default:	Word <= 32'b0;
		endcase
		// Se selecciona cual dato almacenar en ND.(lw/lb)
		case(DT)
			1'b0:		ND <= Word;
			1'b1:		ND <= D;
			default:	ND <= 32'b0;
		endcase
	end
endmodule
