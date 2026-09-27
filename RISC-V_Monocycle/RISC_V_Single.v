`timescale 1ns / 1ps

module RISC_V_Single(
    input clk,
    output [31:0] RD1,
    output [31:0] RD2
);

    wire PCSrc;
    wire [1:0] ResultSrc;
    wire MemWrite;
    wire ALUSrc;
    wire [1:0] ImmSrc;
    wire RegWrite;
    wire [2:0] ALUControl;

    wire [31:0] Inst;   // Copia de la instrucción leída para decodificar
    wire Zero;         // Bandera Zero de la ALU

    wire [6:0] op     = Inst[6:0];
    wire [2:0] funct3 = Inst[14:12];
    wire func75       = Inst[30];

    Control_Unit control_unit_inst (
        .Zero(Zero),
        .op(op),
        .funct3(funct3),
        .func75(func75),
        .PCSrc(PCSrc),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .ALUControl(ALUControl)
    );

    Datapath datapath_inst (
        .clk(clk),
        .PCSrc(PCSrc),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .RD1(RD1),
        .RD2(RD2),
        .Inst(Inst),
        .Zero(Zero)
    );

endmodule
