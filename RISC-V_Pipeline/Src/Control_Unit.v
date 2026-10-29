`timescale 1ns / 1ps

//(* KEEP_HIERARCHY = "yes" *)
module Control_Unit(
    input clk,
    input reset,
    input Zero,
    input [6:0] op,
    input [2:0] funct3,
    input func75,
    output PCSrc,
    output [1:0] ResultSrc,
    output MemWrite,
    output ALUSrc,
    output [1:0] ImmSrc,
    output RegWrite,
    output [2:0] ALUControl
);
    
// Señales internas para conectar la salida del MainDecoder
wire BranchD;
wire BranchE;
wire JumpD;
wire JumpE;
wire [1:0] ALUOp;

// Instanciación completa del MainDecoder
MainDecoder Main (
    .op(op),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .ALUOp(ALUOp),
    .Branch(BranchD),
    .Jump(JumpD)
);

// Registro Branch DE
FFD Branch_DE (
    .clk(clk),
    .reset(reset),
    .D(BranchD),
    .Q(BranchE)
);

// Registro Jump DE
FFD Jump_DE (
    .clk(clk),
    .reset(reset),
    .D(JumpD),
    .Q(JumpE)
);

assign PCSrc = (BranchE & Zero) | JumpE ;

ALU_Decoder ALU_Dec (
    .op5(op[5]),
    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct75(func75),
    .ALUControl(ALUControl)
);

endmodule
