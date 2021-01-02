`timescale 1ns / 1ps
// Bloque que posee 32 registros de 32 bits para realizar parte de la ejecuci�n de las instrucciones.
// Entradas: clk, A1, A2, A3 y WD3
// Enable:  WE3
// Salidas: RD1 y RD2

// clk es la se�al de reloj, la cual sincr�niza los valores de las se�ales de control.
// A1 y A2 son direcciones de memoria que se leen y su contenido se escribe en RD1 y RD2, respectivamente.
// A3 es la direcci�n de memoria a la cual se desea escribir un dato de 32bits.
// WD3 contiene el dato de 32 bits que se puede llegar a escribir.
// WE3 habilita o no la escritura de un dato. 
// RD1 y RD2 contienen datos de los datos 32 bits le�dos.

module RegisterFile(input clk, 
							input reset,
							input WE3, 
							input [4:0] A1, A2, A3, 
							input [31:0] WD3,
							output [31:0] RD1, RD2);
							
	reg [31:0] reg_file[0:31];						// Se crean 32 registros de 32 bits.
	integer i;
   integer j;
	
	initial	begin											// Se inicializan los registros en 0.
		for(i=0;i<32;i=i+1)
			reg_file[i] = 32'b0;
	end
															//Lectura del adress del banco de registros.(combinacional)
	assign RD1 = reg_file[A1];						//En RD1 se guarda el dato contenido en el registro que est� en A1
   assign RD2 = reg_file[A2];						//En RD2 se guarda el dato contenido en el registro que est� en A2

	always @(posedge clk)							//Escritura en el banco de registros.(secuencial)
	begin
		if (reset) begin										
			for(j=0; j<32; j=j+1)
				reg_file[j] <= 32'b0;
		end
		
      else if((WE3) & (A3 != 0))					
			reg_file[A3] <= WD3;						//Se permite la escritura en un registro segun el valor de A3, para A3 != 0
	end 
endmodule