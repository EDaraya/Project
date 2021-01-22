`timescale 1ns / 1ps
/*
Objetivo:
	Probar que el modulo de la lógica en carga en registros del Register File.

Procedimiento:
	Se le asignan los siguientes valores a las entradas del módulo:
	
	D = 32'd65535;		// 2 Bytes en 0's y 2 Bytes en 1's 	
	ALU = 2'b01;		// Byte 1 
	Sign = 1'b1;		// Unsigned
	DT = 1'b0;			// lb
	
	Como resultado, debería obtenerse el Byte 1 del dato 65535 extendido en ceros, ya que Sign es 1.
	El byte 1 de la palabra 65535 son 8 bits en 1's y por lo tanto el resultado esperado en la salida sería 32'd255.
	ND = {{24{0}}, D[7:0]}
*/
module LoadLogicTb;

	// Inputs
	reg [31:0] D;
	reg [1:0] ALU;
	reg DT;
	reg Sign;
	// Outputs
	wire [31:0] ND;
	// Instantiate the Unit Under Test (UUT)
	LoadLogic uut (
		.D(D), 
		.ALU(ALU), 
		.DT(DT), 
		.Sign(Sign), 
		.ND(ND)
	);

	initial 
		begin
			// Initialize Inputs
			D = 0;
			ALU = 0;
			DT = 0;
			Sign = 0;
			// Wait 100 ns for global reset to finish
			#100;
			// Add stimulus here
			D = 32'd65535;		// 2 Bytes en 0's y 2 Bytes en 1's 	
			ALU = 2'b01;		// Byte 1 
			Sign = 1'b1;		// Unsigned
			DT = 1'b0;			// lb
		end
endmodule

