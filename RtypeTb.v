`timescale 10ns / 1ps

//Funcionalidad Testbench
//Probar que el modulo tipo R posee un funcionamiento adecuado

//Procedimiento
//Crear un clock ya que este se maneja por medio de los ciclos de reloj.

module RtypeTb;

	// Inputs
	reg clk;
	reg reset;
	// Instantiate the Unit Under Test (UUT)
	Rtype uut (
		.clk(clk), 
		.reset(reset)
    );

	initial
		begin
			// Initialize Inputs
			clk = 1;
			reset = 0;
			// Wait 100 ns for global reset to finish
			#100;
			// Add stimulus here
		end
   always
		#5 clk=!clk;
endmodule


