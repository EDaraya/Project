`timescale 10ns / 1ps

//Funcionalidad Testbench
//Probar que el modulo tipo R posee un funcionamiento adecuado

//Procedimiento
//Crear un clock ya que este se maneja por medio de los ciclos de reloj.

module RtypeTb;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [31:0] Out;

	// Instantiate the Unit Under Test (UUT)
	Rtype Rtype (
    .clk(clk), 
    .reset(reset), 
    .Out(Out)
    );

	initial
		begin
			// Initialize Inputs
			clk = 0;
			reset = 0;
		end
   always
		#5 clk=!clk;
endmodule


