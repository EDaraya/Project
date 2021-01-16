`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:31:20 01/13/2021
// Design Name:   Itype
// Module Name:   C:/Users/Eduardo/Desktop/Proyecto/ProyectoMicroprocesador/ProyectoMicroprocesador/ItypeTb.v
// Project Name:  ProyectoMicroprocesador
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Itype
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ItypeTb;

	// Inputs
	reg clk;
	reg reset;
	// Outputs
	// Instantiate the Unit Under Test (UUT)
	Itype uut (
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

