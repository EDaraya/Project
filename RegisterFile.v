`timescale 1ns / 1ps
// Bloque que posee 32 registros de 32 bits para realizar parte de la ejecuci�n de las instrucciones.
// Entradas:	clk, A1, A2, A3, WD3 y WE3
// Salidas:		RD1 y RD2
/* 
	clk es la se�al de reloj, la cual sincr�niza las transiciones del PC y de la escritura en memoria.
	A1 y A2 son direcciones de memoria que se leen y su contenido se escribe en RD1 y RD2, respectivamente.
	A3 es la direcci�n de memoria a la cual se desea escribir un dato.
	WD3 contiene el dato que se puede llegar a escribir.
	WE3 habilita o no la escritura de un dato. 
*/

module RegisterFile	(
							input clk, 
							input reset,
							input wire WE3, 
							input wire [4:0] A1, A2, A3, 
							input wire signed [31:0] WD3,
							output wire signed [31:0] RD1, RD2
						   );
							
	// Creaci�n de los 32 registros de 32 bits.	
	parameter SIZE = 32;	
	parameter MEM_DEPTH = 32;
	reg [SIZE-1:0] reg_file[MEM_DEPTH-1:0];	
	// Definici�n de variable para inicializar valores en los registros.	
	integer i;
	// Se inicializan los registros.
	initial	
		for(i=0;i<32;i=i+1)
			reg_file[i] = 32'b0;
	//	Lectura del valor en el adress de memoria.(combinacional)
	assign RD1 = reg_file[A1];	
   assign RD2 = reg_file[A2];	
	//	Escritura en memoria.(secuencial)
	always @(posedge clk)	
		begin
			// Se reestablecen los registros a un valor de 32'b0.
			if (reset == 1'b1)
				begin
					for(i=0; i<32; i=i+1)
						reg_file[i] <= 32'd0;
				end
			// Se habilita la escritura si el enable est� 1 y el adrres a escribir no es el r0.
			else if((WE3 == 1)&&(A3 != 0))					
				reg_file[A3] <= WD3;	
		end
endmodule