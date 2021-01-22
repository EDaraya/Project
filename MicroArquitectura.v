`timescale 1ns / 1ps
// Bloque que soporta las instrucciones tipo R,I,S,B,U y J necesarias.
// Entradas: clk y reset.
// Salidas: ninguna.
/*
	Procedimiento:
	Se instancian todos los módulos necesarios y se definen wires para la unión de los mismos.
*/
module Microarquitectura	( 
									input clk,
									input reset,
									output wire [31:0] OutGPIO
									);
					
//	Inicialización de variables para el módulo PC Regsiter y el PC Adder
wire [31:0] PC;
wire [31:0] PC4;
wire [31:0] NextPC;	
PC RegPC (														// Inicialización módulo PC
    .clk(clk), 												// Entrada de clock
    .NextPC(NextPC), 										// Entrada para el próximo PC
    .PC(PC)														// Salida PC actual
    );
PC4 SumPC4 (													// Inicialización módulo PC4
    .PC(PC), 													// Entrada PC actual
    .PC4(PC4)													// Salida PC4 = PC+4
    );

//	Inicialización de variables para el módulo Instruction Memory
wire [31:0] Inst;
InstructionMemory IM (										// Inicialización módulo Instruction Memory
    .A(PC), 													// Entrada de PC actual
    .RD(Inst)													// Salida que corresponde a la instrucción
    );

//	Inicializacion de variables para el módulo UC
wire [6:0] Opcode;
wire ForceJump,Branch,JumpPC,JumpRD,MemToReg,MemWrite,ALUscr,LUIscr,RegWrite,MemWrite2;
wire [3:0] ALUOp;
//	Asignacion de bits para la UC
assign Opcode = Inst [6:0];								// Bist para establecer el Opcode
UC CU (															// Inicialización módulo UC
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

//	Inicialización de variables para el módulo Register File
wire [4:0] rs1;									
wire [4:0] rs2;
wire [4:0] rd;
wire [31:0] RD1;
wire [31:0] RD2;
wire [31:0] WD3;
// Asignacion de bits para el Register File
assign rd = Inst [11:7];									// Bits para establecer el registro destino
assign rs1 = Inst [19:15];									// Bits para establecer el registro operando 1  
assign rs2 = Inst [24:20];									// Bits para establecer el registro operando 2  
RegisterFile RF (												// Inicialización el módulo Register File
    .clk(clk), 												// Entrada de clock
    .A1(rs1), 													// Entrada A1
    .A2(rs2), 													// Entrada A2
    .A3(rd), 													// Entrada A3
    .WE3(RegWrite), 											// Entrada WE3
    .WD3(WD3), 												// Entrada WD3
    .reset(reset), 											// Entrada del reset
    .RD1(RD1), 												// Salida RD1
    .RD2(RD2)													// Salida RD2
    );

//	Inicializacion de variables para el módulo Immediate Generator
wire [31:0] Imm;
ImmGenerator IG (									
    .Inst(Inst), 									
    .Imm(Imm)								
    );
	 
//	Inicializacion de variables para el módulo PC+imm
wire [31:0] PCimm;
PCimm SumPCimm (												// Inicialización módulo PCimm
    .PC(PC), 													// Entrada de PC actual
    .Imm(Imm), 												// Entrada de valor inmediato
    .PCimm(PCimm)												// Salida PC actual + inmediato
    );
	 
//	Inicializacion de variables para el Mux que decide entre RD2 o el valor inmediato
wire [31:0] RD2orImm;
Mux2to1 MuxRD2orImm (										// Inicialización módulo Mux2to1						
    .Sel(ALUscr),												// Seleccionador
    .A(RD2), 													// Dato leído en la dirección A2
    .B(Imm), 													// Valor inmediato
    .C(RD2orImm)												// Salida del Mux	
    );

//	Inicializacion de variables para el módulo ALU Control
wire [2:0] Funct3;
wire [6:0] Funct7;
wire [4:0] ALU_Control;
assign Funct3 = Inst[14:12];								// Asignación de bits de Funct3
assign Funct7 = Inst[31:25];								// Asignación de bits de Funct7
ALUControl AC (												// Inicialización módulo ALU Control
	 .ALUOp(ALUOp),											// ALUOp
	 .Funct75(Funct7[5]),									// Funct7[5]
	 .Funct70(Funct7[0]),									// Funct7[0]
	 .Funct3(Funct3),											// Funct3
	 .ALU_Control(ALU_Control)								// ALU_Control
	 );

//	Inicializacion de variables para el Mux que decide entre un valor de 32'b0 o RD1.
wire [31:0] RD1orLUI;
Mux2to1 MuxRD1orLUI (								
    .Sel(LUIscr),	
    .A(32'b0), 											
    .B(RD1), 										
    .C(RD1orLUI)													
    );
//	Inicializacion de variables para el módulo ALU	 
wire [31:0] ALU_Result;
Alu ALU (														// Inicializacion módulo ALU
    .RD1(RD1orLUI), 											// Entrada RD1orLUI
    .RD2(RD2orImm), 											// Entrada RD2orImm
    .ALU_Control(ALU_Control), 							// Entrada ALU_Control.(Seleccionador de Op)
    .ALU_Result(ALU_Result), 								// Salida ALU_Result
    .Zero(Zero)												// Bandera Zero
    );
	 
//	Inicializacion de variables para el módulo Jump Control	 
wire BranchMux;
JumpControl JC (												// Inicializacion módulo ALU
		.Funct3(Funct3), 										// Entrada Funct3
		.ForceJump(ForceJump), 								// Entrada ForceJump
		.Branch(Branch), 										//	Entrada Branch
		.Zero(Zero), 											// Salida Zero
		.BranchMux(BranchMux)								// Salida BranchMux
	);
	
//	Inicializacion de variables para el Mux que decide entre PC+4 o PC+imm.(salto incondicional/incondicional o PC+imm)
wire [31:0] PC4orPCimm;							
Mux2to1 MuxPC4orPCimm (
    .Sel(BranchMux), 
    .A(PC4), 
    .B(PCimm), 
    .C(PC4orPCimm)
    );
	 
//	Inicializacion de variables para el Mux que decide entre PC+4/PC+imm o JALR
wire [31:0] JALR;							
assign JALR = {ALU_Result[31:1],1'b0};	
Mux2to1 MuxNextPC (
    .Sel(JumpPC), 
    .A(PC4orPCimm), 
    .B(JALR), 
    .C(NextPC)
    );

//	Inicializacion de variables para el módulo Store Logic.	 
wire [31:0] NDS;
wire [3:0] BE;	 
StoreLogic SL (												// Inicializacion módulo StoreLogic
    .D(RD2), 													// Entrada Data
    .ALU(ALU_Result[1:0]), 								// Entrada de los últimos 2 bits de ALU_Result
    .DT(Inst[13]), 											// Entrada Data Type.(sw/sb)												
    .ND(NDS),													// Salida New Data.(sw/sb)
	 .BE(BE)														// Salida Byte Enable		
    );

//	Inicializacion de variables del GPIO
//wire [31:0] OutGPIO;
GPIO GPIO (
    .Ar(ALU_Result), 
	 .MemWrite(MemWrite),
    .WDr(NDS), 
    .clk(clk), 
    .Outr(OutGPIO)
    );
	 
//	Inicializacion de variables para el módulo Data Memory.
wire [31:0] RD;
assign MemWrite2 = MemWrite&&(ALU_Result != 32'hABCD);

DataMemory DM (												// Inicializacion módulo DataMemory
    .clk(clk), 												// Entrada clock
    .WE(MemWrite2), 											// Entrada WE
	 .BE(BE), 													// Entrada BE
	 .A(ALU_Result), 											// Entrada de los últimos 2 bits de ALU_Result
    .WD(NDS), 													// Salida NewData
    .RD(RD)														// Salida RD
    );

//	Inicializacion de variables para el módulo Load Logic. 
wire [31:0] NDL;	 
LoadLogic LL (													// Inicializacion módulo StoreLogic
    .D(RD), 													// Entrada Data
    .ALU(ALU_Result[1:0]), 								// Entrada de los últimos 2 bits de ALU_Result
    .DT(Inst[13]), 											// Entrada Data Type.(lw/lbu/lb)
    .Sign(Inst[14]), 										//	Entrada Sign.(lb/lbu)	
    .ND(NDL)													// Salida New Data.(lb/lbu/lw)
    );
	 
//Inicializacion de variables para el Mux que decide entre el resultado de la ALU o el contenido de Data Memory
wire [31:0] ALUorMEM;
Mux2to1 MuxALUorMEM (										// Inicialización módulo Mux2to1
	 .Sel(MemToReg), 											// Seleccionador
    .A(ALU_Result),											// Entrada A
    .B(NDL), 													// Entrada B
    .C(ALUorMEM)												// Salida C
    );
	 
//Inicializacion del Mux que decide entre el (resultado de la ALU/Dato leído de memoria) o PC+4 
Mux2to1 MuxWD3 (												// Inicialización módulo Mux2to1
	 .Sel(JumpRD), 											// Seleccionador
    .A(ALUorMEM),												// Entrada A
    .B(PC4), 													// Entrada B
    .C(WD3)														// Salida C
    );	 
endmodule
