`timescale 1ns / 1ps
// Bloque que posee 32 registros de 32 bits para realizar parte de la ejecución de las instrucciones.
// Entradas:	clk, A1, A2, A3, WD3 y WE3
// Salidas:		RD1 y RD2
/* 
	clk es la señal de reloj, la cual sincróniza las transiciones del PC y de la escritura en memoria.
	A1 y A2 son direcciones de memoria que se leen y su contenido se escribe en RD1 y RD2, respectivamente.
	A3 es la dirección de memoria a la cual se desea escribir un dato.
	WD3 contiene el dato que se puede llegar a escribir.
	WE3 habilita o no la escritura de un dato. 
*/

module RegisterFile	(
							input clk, 
							input reset,
							input wire WE3, 
							input wire [4:0] A1, A2, A3, 
							input wire [31:0] WD3,
							output wire [31:0] RD1, RD2
						   );
							
	// Creación de los 32 registros de 32 bits.	
	parameter SIZE = 32;	
	parameter MEM_DEPTH = 32;
	reg [SIZE-1:0] reg_file[MEM_DEPTH-1:0];	
	// Definición de variable para inicializar y restablecer valores de los registros.	
	integer i;
	// Se inicializan los registros.
	initial	
		for(i=0;i<32;i=i+1)
			reg_file[i] = i;
	//	Lectura del valor en el adress de memoria.(combinacional)
	assign RD1 = reg_file[A1];	//	Se escribe en RD1 el dato contenido en la dirección A1
   assign RD2 = reg_file[A2];	//	Se escribe en RD2 el dato contenido en la dirección A2
	//	Escritura en memoria.(secuencial)
	always @(posedge clk)	
		begin
			if (reset == 1'b1)
				begin
					for(i=0; i<32; i=i+1)
						reg_file[i] <= 32'd0;
				end
			else if((WE3) && (A3 != 0))					
				reg_file[A3] <= WD3;	
		end
endmodule