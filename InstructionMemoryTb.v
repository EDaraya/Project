`timescale 10ns / 1ps
//	Instruction Memory Testbench
/*	Objetivo:
	Desmostrar la correcta lectura de datos en los distintos registros
	del conjunto del número de instrucciones. Ademas para comprobar la correcta fucionalidad del reset.

//Procedimiento
//Debido al funcionamiento en la memoria de isntruciones
//debido a que esta avanza cada +4, entonces se tiene que esperar que
//A recorra 4 ciclos o avance 4 numeros para obtener la siguiente instruccion.
//Se deberia apreciar como Rd posee diferentes valores cada 4 ciclos de A.
*/
module InstructionMemoryTb;

	// Inputs
	reg clk;
	reg [31:0] A;


	// Outputs
	wire [31:0] RD;

	// Instantiate the Device Under Test (UUT)
	InstructionMemory DUT (
		.clk(clk), 
		.A(A), 
		.RD(RD)
	);
	integer i;
	initial 
	begin
		// Initialize Inputs
		#15;
		clk = 1;
		A = 0;
		//A = 48;
		
		for(i=1;i<100;i=i+1)
		begin
			A=A+1;
			#2;
		end
		#1;
	end
	always
      #5 clk =! clk;
endmodule

