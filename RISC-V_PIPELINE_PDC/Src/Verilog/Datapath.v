`timescale 1ns / 1ps

module Datapath(
    input clk,
    input reset,
    input PCSrc,
    input [1:0] ResultSrc,
    input MemWrite,
    input [2:0] ALUControl,
    input ALUSrc,
    input [1:0] ImmSrc,
    input RegWrite,

    output [31:0] InstD,
    output Zero,
    output [31:0] ALUResultE
);

// ================================================================
// Señales de Fetch
// ================================================================

wire [31:0] PCF;
wire [31:0] PCNext;
wire [31:0] PC4F;
wire [31:0] InstF;

// ================================================================
// Señales de Decode
// ================================================================

wire [31:0] RD1D;
wire [31:0] RD2D;
wire [31:0] ImmD;
wire [4:0]  RdD;
wire [31:0] PC4D;
wire [31:0] PCD;

// ================================================================
// Señales de Execute
// ================================================================

wire [31:0] RD1E;
wire [31:0] RD2E;
wire [31:0] ImmE;
wire [31:0] SrcBE;
wire [31:0] PCTargetE;
wire [4:0]  RdE;
wire [31:0] PC4E;
wire [31:0] PCE;

// ================================================================
// Señales de Memory
// ================================================================

wire [31:0] ALUResultM;
wire [31:0] WriteDataM;
wire [31:0] ReadDataM;
wire [4:0]  RdM;
wire [31:0] PC4M;

// ================================================================
// Señales de Writeback
// ================================================================

wire [31:0] ALUResultW;
wire [31:0] ReadDataW;
wire [31:0] PC4W;
wire [31:0] ResultW;
wire [4:0]  RdW;

assign RdD = InstD[11:7];

// ================================================================
// FETCH
// ================================================================

FFD32 Inst(
    .clk(clk),
    .reset(reset),
    .D(PCNext),
    .Q(PCF)
);

Memoria2 #(.N(20)) InsMem (
    .dir(PCF),
    .data_out(InstF)
);

SUM4 PC4 (
    .A(PCF),
    .B(PC4F)
);

MUX32 Jump (
    .A(PC4F),
    .B(PCTargetE),
    .sel(PCSrc),
    .C(PCNext)
);

// ================================================================
// FETCH -> DECODE
// ================================================================

FFDFD FD(
    .clk(clk),
    .reset(reset),
    .A(InstF),
    .B(PCF),
    .C(PC4F),
    .H(InstD),
    .I(PCD),
    .J(PC4D)
);

// ================================================================
// DECODE
// ================================================================

Register_File BR (
    .clk(clk),
    .WD3(ResultW),
    .A1(InstD[19:15]),
    .A2(InstD[24:20]),
    .A3(RdW),
    .WE3(RegWrite),
    .RD1(RD1D),
    .RD2(RD2D)
);

Extend EXT (
    .A(InstD[31:7]),
    .sel(ImmSrc),
    .Imm(ImmD)
);

// ================================================================
// DECODE -> EXECUTE
// ================================================================

FFDDE DE(
    .clk(clk),
    .reset(reset),
    .A(RD1D),
    .B(RD2D),
    .C(PCD),
    .D(RdD),
    .E(ImmD),
    .F(PCP4D),
    .H(RD1E),
    .I(RD2E),
    .J(PCE),
    .K(RdE),
    .N(ImmE),
    .Q(PCP4D)
    
);

// ================================================================
// EXECUTE
// ================================================================

MUX32 MUXALU (
    .A(RD2E),
    .B(ImmE),
    .sel(ALUSrc),
    .C(SrcBE)
);

ALU ALU (
    .A(RD1E),
    .B(SrcBE),
    .ALUControl(ALUControl),
    .C(ALUResultE),
    .Zero(Zero)
);

SUMA SUM (
    .A(PCE),
    .B(ImmE),
    .C(PCTargetE)
);

// ================================================================
// EXECUTE -> MEMORY
// ================================================================

FFDEM EM(
    .clk(clk),
    .reset(reset),
    .A(ALUResultE),
    .B(RD2E),
    .C(RdE),
    .D(PC4E),
    .H(ALUResultM),
    .I(WriteDataM),
    .J(RdM),
    .K(PC4M)
);

// ================================================================
// MEMORY
// ================================================================

Data_Memory #(.DIR(6)) DM (
    .clk(clk),
    .A(ALUResultM),
    .WD(WriteDataM),
    .WE(MemWrite),
    .RD(ReadDataM)
);

// ================================================================
// MEMORY -> WRITEBACK
// ================================================================

FFDMW MW(
    .clk(clk),
    .reset(reset),
    .A(ALUResultM),
    .B(ReadDataM),
    .C(RdM),
    .D(PC4M),
    .H(ALUResultW),
    .I(ReadDataW),
    .J(RdW),
    .K(PC4W)
);

// ================================================================
// WRITEBACK
// ================================================================

MUX4_32 MUXResult (
    .A(ALUResultW),
    .B(ReadDataW),
    .C(PC4W),
    .D(32'd0),
    .sel(ResultSrc),
    .Y(ResultW)
);

endmodule