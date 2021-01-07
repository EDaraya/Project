`timescale 1ns / 1ps
//	Alu Testbench 
/*
Objetivo:
	Verificar que los resultados de la ALU
	sean los correctos, y que la bandera de Zero fucnione.
Procedimiento:
	Se inicializan las entradas RD1, RD2 y ALU_Control.
	Esta última se inicia en 5'b00000 y se realiza un bucle FOR para ir aumentado su valor y ver los resultados.
*/

/*
 CASO #1 
 RD1 = 5, RD2 = 3
 ALU_Control: 
				5'b00000:	ADD => RD1 + RD2 y se guarda en Result, Result = 32'd8.
				5'b00010:	SUB => RD1 - RD2 y se guarda en Result, Result = 32'd2.
				5'b00100:	SLL => RD1 << RD2 y se guarda en Result, Result = 32'd40.
				5'b10000:	XOR => RD1 ^ RD2 y se guarda en Result, Result = 32d'6. 
				5'b10100: 	SRL => RD1 >> RD2  y se guarda en Result, Result = 32'd0.
				5'b10110:	SRA => RD1 >>> RD2 y se guarda en Result, Result = 32'd0. 
				5'b11100:	AND => RD1 & RD2 y se guarda en Result, Result = 32'd1. 
				5'b11111:	LUI => RD1 + RD2 y se guarda en Result, Result = 32'd8. 
CASO #2  
 RD1 = 5, RD2 = 8
 ALU_Control: 
				5'b00000:	ADD => RD1 + RD2 y se guarda en Result, Result = 32'd13.
				5'b00010:	SUB => RD1 - RD2 y se guarda en Result, Result = 32'd-3.
				5'b00100:	SLL => RD1 << RD2 y se guarda en Result, Result = 32'd1280.
				5'b10000:	XOR => RD1 ^ RD2 y se guarda en Result, Result = 32d'13. 
				5'b10100: 	SRL => RD1 >> RD2  y se guarda en Result, Result = 32'd0.
				5'b10110:	SRA => RD1 >>> RD2 y se guarda en Result, Result = 32'd0. 
				5'b11100:	AND => RD1 & RD2 y se guarda en Result, Result = 32'd0. 
				5'b11111:	LUI => RD1 + RD2 y se guarda en Result, Result = 32'd13. 
CASO #3
 RD1 = 5, RD2 = 5
 ALU_Control: 
				5'b00000:	ADD => RD1 + RD2 y se guarda en Result, Result = 32'd10.
				5'b00010:	SUB => RD1 - RD2 y se guarda en Result, Result = 32'd0.
				5'b00100:	SLL => RD1 << RD2 y se guarda en Result, Result = 32'd160.
				5'b10000:	XOR => RD1 ^ RD2 y se guarda en Result, Result = 32d'0. 
				5'b10100: 	SRL => RD1 >> RD2  y se guarda en Result, Result = 32'd0.
				5'b10110:	SRA => RD1 >>> RD2 y se guarda en Result, Result = 32'd0. 
				5'b11100:	AND => RD1 & RD2 y se guarda en Result, Result = 32'd5. 
				5'b11111:	LUI => RD1 + RD2 y se guarda en Result, Result = 32'd10. 
*/
module AluTb;

	// Inputs
	reg [31:0] RD1;
	reg [31:0] RD2;
	reg [4:0] ALU_Control;

	// Outputs
	wire [31:0] ALU_Result;
	wire Zero;
	
	integer i;

	// Instantiate the Unit Under Test (UUT)
	Alu DUT (
		.RD1(RD1), 
		.RD2(RD2), 
		.ALU_Control(ALU_Control), 
		.ALU_Result(ALU_Result), 
		.Zero(Zero)
	);

	initial 
	begin
		// Initialize Input

		RD1= 5;
		RD2 = 3;
		ALU_Control = 5'b00000;
		for (i=0; i<32; i=i+1)
			begin
			#50 ALU_Control = ALU_Control + 5'b00001;
			end
		ALU_Control = 5'b00000;
		i=0;
		RD1 = 5;
		RD2 = 8;
		for (i=0; i<32; i=i+1)
			begin
			#50 ALU_Control = ALU_Control + 5'b00001;
			end
		ALU_Control = 5'b00000;
		i=0;
		RD1 = 5;
		RD2 = 5;
		for (i=0; i<32; i=i+1)
			begin
			#50 ALU_Control = ALU_Control + 5'b00001;
			end
	end
endmodule

