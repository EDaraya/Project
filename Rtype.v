`timescale 1ns / 1ps

//Entradas: Clock y reset
//Salida de prueba: SalidaPrueba

module Rtype	( 
					input clk,
					input reset
					);

//Se inicializa variables para PC
wire [31:0] PC;
wire [31:0] NextPC;

PC RegPC (											//Inicializa módulo PC
    .clk(clk), 							//Entrada de clock
    .NextPC(NextPC), 								//Entrada PC4
    .PC(PC)						//Salida PCactualizado
    );
PC4 SumPC4 (								//Inicializa el Sumador de PC + 4
    .PC(PC), 					//Entrada PCactualizado
    .PC4(NextPC)									//Salida PC4
    );
	 
//Inicializa variables de memorias de instrucciones
wire [31:0] Inst;
InstructionMemory IM (					// Inicializa funcion de Memoria Instrucciones
    .A(PC), 						//Entrada de PCactualizado
    .RD(Inst)										//Salida Rd
    );
	 
//Inicializacion de variables para unidad de control
wire [6:0] Opcode;
wire [3:0] ALUOp;
wire RegWrite;
//Asignacion de bits para unidad de control
assign Opcode = Inst[6:0];
UC CU (									//Inicializacion de unidad de control
    .Opcode(Opcode), 						//Entrada de Opcode
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
	 
//Inicializa variables de banco de registros
wire [4:0] rs1;									
wire [4:0] rs2;
wire [4:0] rd;
wire [31:0] RD1;
wire [31:0] RD2;
wire [31:0] ALU_Result;
//Asignacion de bits para A1/A2/A3
assign rs1 = Inst[19:15];
assign rs2 = Inst[24:20];
assign rd = Inst[11:7];
RegisterFile RF (			//Inicializa funcion de banco de registros
    .clk(clk), 							//Entrada de clock
    .A1(rs1), 									//Entrada A1
    .A2(rs2), 									//Entrada A2
    .A3(rd), 									//Entrada A3
    .WE3(RegWrite), 								//Entrada WE3
    .WD3(ALU_Result), 							//Entrada de salida de la ALU
    .reset(reset), 							//Entrada del reset
    .RD1(RD1), 								//Salida RD1
    .RD2(RD2)									//Salida RD2
    );

//Inicializacion de variables de ALU Control
wire [2:0] Funct3;
wire [6:0] Funct7;
wire [4:0] ALU_Control;
// Asignación de bits para Funct3 y Funct7
assign Funct3 = Inst[14:12];
assign Funct7 = Inst[31:25];
ALUControl AC (
	 .ALUOp(ALUOp),
	 .Funct75(Funct7[5]),
	 .Funct70(Funct7[0]),
	 .Funct3(Funct3),
	 .ALU_Control(ALU_Control)	
	 );

Alu ALU (										//Inicializacion de la funcion de la ALU
    .RD1(RD1), 									//Entrada RD1
    .RD2(RD2), 									//Entrada RD2
    .ALU_Control(ALU_Control), 						//Entrada de ALU_Sel (seleccionador de alu)
    .ALU_Result(ALU_Result), 						//Salida ALU_Out
    .Zero(Zero) 								//Condicion not equal
    );
endmodule

