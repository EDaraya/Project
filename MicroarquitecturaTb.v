`timescale 1ns / 1ps
/*
Objetivo:
	Probar el correcto funcionamiento de las instrucciones de cada uno de los 6 códigos C suministrados.
Procedimiento:
	Ir al módulo de Instruction Memory y cambiar las instrucciones a cargar en la memoria mediante el 
	cambio de los nombres de los rachivos txt de cada código C.
	Para demostrar el funcionamiento se comprobó cada código con lo que se había obtenido con la crosscompilación
	y con ello se testeó que los resultados en cada caso fueran los correctos.	
*/
module MicroarquitecturaTb;

	// Inputs
	reg clk;
	reg reset;
	
	wire [31:0] OutGPIO;
	// Instantiate the Unit Under Test (UUT)
	Microarquitectura uut (
		.clk(clk), 
		.reset(reset),
		.OutGPIO(OutGPIO)
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
		
	integer f,i;
	initial
		begin
			//#280;
			//f = $fopen("MemC1.txt","w");
			//#230;
			//f = $fopen("MemC2.txt","w");
			//#210;
			//f = $fopen("MemC3.txt","w");
			//#260;
			//f = $fopen("MemC4.txt","w");
			//#320;
			//f = $fopen("MemC5.txt","w");
			//#380;
			//f = $fopen("MemC6.txt","w");
			for (i=-64;i<65;i=i+1)
				$fwrite(f, "0x%h %h%h%h%h\n", 4*i, uut.DM.RAM[3][i], uut.DM.RAM[2][i], uut.DM.RAM[1][i], uut.DM.RAM[0][i]);
			$fclose(f);
			//$finish;
		end
endmodule

