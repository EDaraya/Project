`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:20:40 01/12/2021 
// Design Name: 
// Module Name:    LoadLogic 
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
module LoadLogic	(
						input wire [31:0] Data,
						input wire [1:0] ALUResult10,
						input wire DataType,Sign,
						output wire [31:0] NewData
						);
						
reg [7:0] MuxByte;	
reg [31:0] LoadByte;

always @(*)
	begin
		case(ALUResult10)								//dependiendo del valor en la entrada del seleccionador
			2'b00: 	MuxByte <= Data[7:0];		
			2'b01: 	MuxByte <= Data[15:8];
			2'b10: 	MuxByte <= Data[23:16];
			2'b11: 	MuxByte <= Data[31:24];
			default:	MuxByte <= 7'd0;
		endcase 
		if (Sign == 1'b1)
			LoadByte <= {24'b0,MuxByte};
		else if (Sign == 1'b0)
			LoadByte <= {{24{MuxByte[7]}},MuxByte};
		else
			LoadByte <= 32'd0;
	end

Mux2to1 OutMux (
    .Sel(DataType), 
    .A(LoadByte), 
    .B(Data), 
    .C(NewData)
    );
endmodule
