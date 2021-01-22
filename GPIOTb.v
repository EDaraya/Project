`timescale 1ns / 1ps
/*
Objetivo:
	Probar que el modulo sólo escribe al GPIO cuando es la dirección 0xABCD y cuando se trata de una escritura en memoria.

Procedimiento:
	Se inicializa el clk en 0 y luego se pasa a 1 para generar el flanco positivo de reloj.
	Se asigna el valor de 32'hABCD a la entrada Ar.
	Se le asigna el valor de 1'b1 a la entrada MemWrite.
	Se le asigna el valor de 32'd255 a la entrada WDr.
	La salida debería ser 32'd255, ya que esta es la única condición que permite escribir en el GPIO.
*/
module GPIOTb;

	// Inputs
	reg [31:0] Ar;
	reg MemWrite;
	reg [31:0] WDr;
	reg clk;

	// Outputs
	wire [31:0] Outr;

	// Instantiate the Unit Under Test (UUT)
	GPIO uut (
		.Ar(Ar), 
		.MemWrite(MemWrite), 
		.WDr(WDr), 
		.clk(clk), 
		.Outr(Outr)
	);

	initial 
		begin
			// Initialize Inputs
			Ar = 0;
			MemWrite = 0;
			WDr = 0;
			clk = 0;
			// Wait 100 ns for global reset to finish
			#100;
			// Add stimulus here
			clk = 1;
			Ar = 32'hABCD;
			MemWrite = 1'b1;
			WDr = 32'd255;
		end
endmodule

