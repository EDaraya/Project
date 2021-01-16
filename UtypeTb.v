`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:51:00 01/15/2021
// Design Name:   Utype
// Module Name:   C:/Users/Eduardo/Desktop/Proyecto/ProyectoMicroprocesador/ProyectoMicroprocesador/UtypeTb.v
// Project Name:  ProyectoMicroprocesador
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Utype
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module UtypeTb;

	// Inputs
	reg clk;
	reg reset;
	// Instantiate the Unit Under Test (UUT)
	Utype uut (
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

