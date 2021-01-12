`timescale 10ns / 1ps

//Funcionalidad del testbench
//Observar que el modulo de extension funcione correctamente
//dependiendo de su seleccionador.

//Procedimiento
//Posee un funcionamiento similar a un mux por lo tanto
//se pondran diferentes numeros en las entradas,
//luego se cambiara el seleccionador y se observara que la extension de
//signo se este dando correctamente.
//En este caso en el primer ciclo el seleccionador indica que el numero a
//extender es A, por lo tanto la salida Extendido tendra el numero 10 extendido a 32bits.
//luego sucede lo mismo con el numero en B-C y D.

module ImmGeneratorTb;

	// Inputs
	reg [31:0] Inst;
	// Outputs
	wire [31:0] Imm;
	// Instantiate the Unit Under Test (uut)
	ImmGenerator uut (
		.Inst(Inst), 
		.Imm(Imm)
	);
	initial 
		begin
			// Initialize Inputs
			Inst = 32'hfd010113;	// Tipo I
			#10;
			Inst = 32'h02812623;	// Tipo S
			#10;
			Inst = 32'h00f71863;	// Tipo B
			#10;
			Inst = 32'h0000b7b7;	//	Tipo U
			#10;
			Inst = 32'h00c0006f;	//	Tipo J
		end
endmodule


