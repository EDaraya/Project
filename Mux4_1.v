`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:42:16 01/02/2021 
// Design Name: 
// Module Name:    Mux4_1 
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
module Mux4_1 #(parameter Mux_Width = 8)(
input [Mux_Width-1:0] A,
input [Mux_Width-1:0] B,
input [Mux_Width-1:0] C,
input [Mux_Width-1:0] D,
input [1:0] Control,
output reg [Mux_Width-1:0] Y
    );
always @(Control, A, B, C, D)
      case (Control)
         2'b00: Y = A;
         2'b01: Y = B;
         2'b10: Y = C;
         2'b11: Y = D;
      endcase

endmodule
