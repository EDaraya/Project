`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:06:33 01/12/2021 
// Design Name: 
// Module Name:    Store_Logic 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Store_Logic(
		input wire [1:0] ALU,
		input wire [31:0] Data,
		input wire DT,
		output reg[31:0] ND,
		output reg [3:0] BE
    );
		
		reg [31:0] zero;
		always @(*)
			begin
			case(ALU)
				2'b00: zero = {24'b0, Data[7:0]};
				2'b01: zero = {16'b0, Data[7:0], 8'b0};
				2'b10: zero = {8'b0, Data[7:0], 16'b0};
				2'b11: zero = {Data[7:0], 24'b0};
			endcase 
			
			case (DT)
				1'b0: begin
							ND = zero;
							if (ALU == 2'b00)
								BE = 4'b0001;
							else if (ALU == 2'b01)
								BE = 4'b0010;
							else if (ALU == 2'b10)
								BE = 4'b0100;
							else if (ALU == 2'b11)
								BE = 4'b1000;	
							else 
								BE = 4'b0000;
						end
				1'b1: begin
							ND = Data;
							BE = 4'b0000;
						end
			endcase
		
			end
endmodule
