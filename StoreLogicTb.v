`timescale 1ns / 1ps
/*
Objetivo:
	Probar que el modulo de la lógica de almacenamiento en la Data Memory.

Procedimiento:
	Se le asignan los siguientes valores a las entradas del módulo:
	
	D = 32'd65535;		// 2 Bytes en 0's y 2 Bytes en 1's
	ALU = 2'11;			// Byte 3
	DT = 1'b0;			// sb
	
	Como resultados, deberían obtenerse el Byte 0 del dato 65535 extendido en ceros y un valor BE (ByteEnable) de 4'b1000.
	El byte 0 de la palabra son 8 bits en 1's y por lo tanto el resultado esperado en la salida ND (NewData) sería 32'd255.
	ND = {{24{0}}, D[7:0]}
	BE = 4'b1000
*/
module StoreLogicTb;

	// Inputs
	reg [31:0] D;
	reg [1:0] ALU;
	reg DT;

	// Outputs
	wire [31:0] ND;
	wire [3:0] BE;

	// Instantiate the Unit Under Test (UUT)
	StoreLogic uut (
		.D(D), 
		.ALU(ALU), 
		.DT(DT), 
		.ND(ND), 
		.BE(BE)
	);

	initial 
		begin
			// Initialize Inputs
			D = 0;
			ALU = 0;
			DT = 0;
			// Wait 100 ns for global reset to finish
			#100;
			// Add stimulus here
			D = 32'd65535;		// 2 Bytes en 0's y 2 Bytes en 1's
			ALU = 2'b11;			// Byte 3
			DT = 1'b0;			// sb
		end
endmodule

