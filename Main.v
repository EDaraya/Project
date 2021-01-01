`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Autor: Eduardo Araya Ledezma
//////////////////////////////////////////////////////////////////////////////////
module register_file(CLK, reg_write, A1, A2, A3, WD3, RD1, RD2);
	// I-O
	input CLK, reg_write;
	input [4:0] A1, A2, A3;
	input [31:0] WD3;
	output [31:0] RD1, RD2;
	
	//32 Reg de 32b
	reg [31:0] reg_file [0:31];	
	
	//Inicialización
	initial
		begin
			reg_file[0] = 0;
		end
		
	assign RD1 = reg_file[A1];
	assign RD2 = reg_file[A2];
	
	always @(posedge CLK)
			if (reg_write) reg_file [A3] <= WD3;
endmodule
