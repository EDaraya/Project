`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:04:38 01/16/2021
// Design Name:   Microarquitectura
// Module Name:   C:/Users/Eduardo/Desktop/Proyecto/ProyectoMicroprocesador/ProyectoMicroprocesador/MicroarquitecturaTb.v
// Project Name:  ProyectoMicroprocesador
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Microarquitectura
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MicroarquitecturaTb;

	// Inputs
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	Microarquitectura uut (
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

