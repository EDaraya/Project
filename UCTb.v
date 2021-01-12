module UCTb;

    // Inputs
    reg [6:0] Opcode;
    // Outputs
    wire [3:0] ALUOp;
    wire ForceJump;
    wire Branch;
	 wire JumpPC;
    wire JumpRD;
    wire MemToReg;
    wire MemWrite;
    wire ALUscr;
    wire LUIscr;
    wire RegWrite;
    // Instantiate the Unit Under Test (UUT)
    UC uut (
        .Opcode(Opcode), 
        .ALUOp(ALUOp), 
        .ForceJump(ForceJump), 
        .Branch(Branch), 
		  .JumpPC(JumpPC),
        .JumpRD(JumpRD), 
        .MemToReg(MemToReg), 
        .MemWrite(MemWrite), 
        .ALUscr(ALUscr), 
        .LUIscr(LUIscr), 
        .RegWrite(RegWrite)
    );
    initial 
		 begin
			  // Initialize Inputs
			  Opcode = 0;
			  // Wait 100 ns for global reset to finish
			  #100;
			  // Add stimulus here
			  Opcode = 7'b0110011;    // Tipo R
			  #10;
			  Opcode = 7'b0000011;    // Tipo I	(lw,lbu)
			  #10;
			  Opcode = 7'b0010011;    // Tipo I	(addi,andi,srli,slli,srai,mv,nop)
			  #10;
			  Opcode = 7'b1100111;    // Tipo I	(jalr)
			  #10;
			  Opcode = 7'b0100011;    // Tipo S
			  #10;
			  Opcode = 7'b1100011;    // Tipo B
			  #10;
			  Opcode = 7'b0110111;    // Tipo U
			  #10;
			  Opcode = 7'b1101111;    // Tipo J
		 end
endmodule