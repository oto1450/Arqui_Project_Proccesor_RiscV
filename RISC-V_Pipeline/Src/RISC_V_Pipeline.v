`timescale 1ns / 1ps

module RISC_V_Pipeline(
    input clk,
    input reset,
    output [6:0] op,
    output [31:0] ALUResultE
);

wire [31:0] InstD;
wire Zero;

// Control Unit: etapa D
wire PCSrcD;
wire [1:0] ResultSrcD;
wire MemWriteD;
wire ALUSrcD;
wire [2:0] ImmSrcD;
wire RegWriteD;
wire [2:0] ALUControlD;
wire JumpD;
wire BranchD;

// Pipeline D -> E
wire RegWriteE;
wire [1:0] ResultSrcE;
wire MemWriteE;
wire JumpE;
wire BranchE;
wire [2:0] ALUControlE;
wire ALUSrcE;

// Pipeline E -> M
wire RegWriteM;
wire [1:0] ResultSrcM;
wire MemWriteM;

// Pipeline M -> W
wire RegWriteW;
wire [1:0] ResultSrcW;

// Control de flujo del pipeline
wire PCSrcE;


// ================================================================
// CONTROL UNIT
// ================================================================

Control_Unit CU (
    .clk(clk),
    .reset(reset),
    .Zero(Zero),
    .op(InstD[6:0]),
    .funct3(InstD[14:12]),
    .func75(InstD[30]),
    .PCSrc(PCSrcE),
    .ResultSrc(ResultSrcD),
    .MemWrite(MemWriteD),
    .ALUSrc(ALUSrcD),
    .ImmSrc(ImmSrcD),
    .RegWrite(RegWriteD),
    .ALUControl(ALUControlD)
);


// ================================================================
// PIPELINE REGISTER: D -> E
// ================================================================

FFDDECU DECU (
    .clk(clk),
    .reset(reset),
    .clear(FlushE),
    .A(RegWriteD),
    .B(ResultSrcD),
    .C(MemWriteD),
    .D(JumpD),
    .E(BranchD),
    .F(ALUControlD),
    .G(ALUSrcD),
    
    .H(RegWriteE),
    .I(ResultSrcE),
    .J(MemWriteE),
    .K(JumpE),
    .L(BranchE),
    .M(ALUControlE),
    .N(ALUSrcE)
);


// ================================================================
// PIPELINE REGISTER: E -> M
// ================================================================

FFDEMCU EMCU (
    .clk(clk),
    .reset(reset),
    .A(RegWriteE),
    .B(ResultSrcE),
    .C(MemWriteE),
    
    .H(RegWriteM),
    .I(ResultSrcM),
    .J(MemWriteM)
);


// ================================================================
// PIPELINE REGISTER: M -> W
// ================================================================

FFDMWCU MWCU (
    .clk(clk),
    .reset(reset),
    .A(RegWriteM),
    .B(ResultSrcM),
    
    .H(RegWriteW),
    .I(ResultSrcW)
);


// ================================================================
// DATAPATH
// ================================================================

Datapath DP (
    .clk(clk),
    .reset(reset),
    .PCSrc(PCSrcE),
    .ResultSrc(ResultSrcW),
    .MemWrite(MemWriteM),
    .ALUControl(ALUControlE),
    .ALUSrc(ALUSrcE),
    .ImmSrc(ImmSrcD),
    .RegWriteM(RegWriteM),
    .RegWriteW(RegWriteW),
    .InstD(InstD),
    .Zero(Zero),
    .ALUResultE(ALUResultE),
    .FlushD(FlushD),
    .FlushE(FlushE)
);

// ================================================================
// OUTPUT ASSIGNMENTS
// ================================================================

assign op = InstD[6:0];

endmodule