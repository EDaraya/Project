`timescale 10ns / 1ps
// Instruction Memory
/*
//	Entradas: clk, A y reset
//	Salida: el valor de la direccion
//	Procedimiento: Se abre un espacio de memoria en donde se guardaran
//	los datos cargados desde el archivo indicado.
*/
module InstructionMemory	(
									input clk,
									input wire [31:0] A,
									output reg [31:0] RD
									);
  //	Memoria
  parameter SIZE = 32;	
  parameter MEM_DEPTH = 1024;
  //	Arreglo para adecuado funcionamiento de PC+4
  reg [SIZE-1:0] ROM[MEM_DEPTH-1:0];
  integer i;
  wire [31:0] ADiv4;
  wire [31:0] Ad;
  assign ADiv4 = A/4;
  assign Ad = {{2{A[31]}},ADiv4[29:0]};	//Divido entre cuatro es un shift, entonces hay que extender el número.
 
  //Codigo para lectura de instrucciones.
  initial 
  begin
	$display("Loading ROM.");
	$readmemh("op1.txt", ROM);
  end

  always @(*) 
  begin
	RD <= ROM[Ad];
  end
endmodule