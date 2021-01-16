`timescale 1ns / 1ps


module Itype 	( 
					input clk,
					input reset
					);
					
//	Inicialización de variables para el PC Regsiter
wire [31:0] PC;
wire [31:0] PC4;
wire [31:0] NextPC;	
PC RegPC (														//Inicializa Módulo PC
    .clk(clk), 												//Entrada de clock
    .NextPC(NextPC), 												//Entrada Dirección PC
    .PC(PC)														//Salida PC actualizado
    );
PC4 RegPC4 (													//Inicializa el Sumador de PC + 4
    .PC(PC), 													//Entrada PC actualizado
    .PC4(PC4)													//Salida PC4 = PC+4
    );

//	Inicialización de variables para la Instruction Memory
wire [31:0] Inst;
InstructionMemory IM (								//Inicializa funcion de Memoria Instrucciones
    .A(PC), 									//Entrada de PCactualizado
    .RD(Inst)													//Salida Rd
    );

//	Inicializacion de variables para la UC
wire [6:0] Opcode;
wire JumpPC,JumpRD,MemToReg,ALUscr,RegWrite;
wire [3:0] ALUOp;
//	Asignacion de bits para la UC
assign Opcode = Inst [6:0];
UC CU (								
    .Opcode(Opcode), 					
	 .ForceJump(ForceJump),
	 .Branch(Branch),
	 .JumpPC(JumpPC),
	 .JumpRD(JumpRD),
	 .MemToReg(MemToReg),
	 .MemWrite(MemWrite),
	 .ALUscr(ALUscr),
	 .LUIscr(LUIscr),
	 .ALUOp(ALUOp),
	 .RegWrite(RegWrite)
    );

//	Inicialización de variables para el Register File
wire [4:0] rs1;									
wire [4:0] rs2;
wire [4:0] rd;
wire [31:0] RD1;
wire [31:0] RD2;
wire [31:0] WD3;
//Asignacion de bits para los Address
assign rd = Inst [11:7];
assign rs1 = Inst [19:15];
assign rs2 = Inst [24:20];
RegisterFile RF (						//Inicializa funcion de banco de registros
    .clk(clk), 										//Entrada de clock
    .A1(rs1), 												//Entrada A1
    .A2(rs2), 												//Entrada A2
    .A3(rd), 												//Entrada A3
    .WE3(RegWrite), 											//Entrada WE3
    .WD3(WD3), 							//Entrada de salida de la ALU
    .reset(reset), 										//Entrada del reset
    .RD1(RD1), 											//Salida RD1
    .RD2(RD2)												//Salida RD2
    );

//	Inicializacion de variables para el Immediate Generator
wire [31:0] Imm;
ImmGenerator IG (									
    .Inst(Inst), 									
    .Imm(Imm)								
    );
 
//	Inicializacion de variables para el Mux que decide entre RD2 o un valor inmediato
wire [31:0] RD2orImm;
Mux2to1 MuxRD2orImm (								
    .Sel(ALUscr),	
    .A(RD2), 											
    .B(Imm), 										
    .C(RD2orImm)													
    );

//	Inicializacion de variables para la ALU Control
wire [2:0] Funct3;
wire [6:0] Funct7;
wire [4:0] ALU_Control;
assign Funct3 = Inst[14:12];
assign Funct7 = Inst[31:25];
ALUControl AC (
	 .ALUOp(ALUOp),
	 .Funct75(Funct7[5]),
	 .Funct70(Funct7[0]),
	 .Funct3(Funct3),
	 .ALU_Control(ALU_Control)	
	 );

//	Inicializacion de variables para la ALU	 
wire [31:0] ALU_Result;
Alu ALU (													//Inicializacion de la funcion de la ALU
    .RD1(RD1), 												//Entrada RD1
    .RD2(RD2orImm), 												//Entrada RD2
    .ALU_Control(ALU_Control), 									//Entrada de ALU_Sel (seleccionador de alu)
    .ALU_Result(ALU_Result), 									//Salida ALU_Out
    .Zero(Zero)											//Condicion not equal
    );

//	Inicializacion de variables para el Mux que decide entre PC+4 o JALR
wire [31:0] JALR;							
assign JALR = {ALU_Result[31:1],1'b0};	
Mux2to1 MuxNextPC (
    .Sel(JumpPC), 
    .A(PC4), 
    .B(JALR), 
    .C(NextPC)
    );

//	Inicializacion de variables para el Store Logic	 
/*wire [31:0] NDS;
wire [3:0] BE;	 
StoreLogic SL (						//Inicializacion de la funcion UnidadDeMemoria
    .D(RD2), 										//Entrada de clock a UnidadDeMemoria
    .ALU(ALU_Result[1:0]), 											//Entrada de ALU_Out
    .DT(Inst[13]), 												//Entrada de WE												
    .ND(NDS),	
	 .BE(BE)		
    );
*/
//	Inicializacion de variables para la Data Memory
wire [31:0] RD;
DataMemory DM (						//Inicializacion de la funcion UnidadDeMemoria
    .clk(clk), 										//Entrada de clock a UnidadDeMemoria
    .WE(MemWrite), 												//Entrada de WE
	 .BE(4'b0000), 												//Entrada de WE
	 .A(ALU_Result), 											//Entrada de ALU_Out
    .WD(RD2), 												//Entrada de RD2
    .RD(RD)									//Salida de SalidaMemoria
    );
	 
//	Inicializacion de variables para el Load Logic	 
wire [31:0] NDL;	 
LoadLogic LL (						//Inicializacion de la funcion UnidadDeMemoria
    .D(RD), 										//Entrada de clock a UnidadDeMemoria
    .ALU(ALU_Result[1:0]), 											//Entrada de ALU_Out
    .DT(Inst[13]), 												//Entrada de WE
    .Sign(Inst[14]), 												
    .ND(NDL)									
    );
	 
//Inicializacion de variables para el Mux que decide entre el resultado de la ALU o el contenido de Data Memory
wire [31:0] ALUorMEM;
Mux2to1 MuxALUorMEM (		
	 .Sel(MemToReg), 			
    .A(ALU_Result),											
    .B(NDL), 									
    .C(ALUorMEM)								
    );
//Inicializacion del Mux que decide entre la salida del Mux ALUorMEM o PC+4 
Mux2to1 MuxWD3 (										
	 .Sel(JumpRD), 			
    .A(ALUorMEM),											
    .B(PC4), 									
    .C(WD3)								
    );	 
endmodule
