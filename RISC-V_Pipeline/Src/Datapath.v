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
    input RegWriteM,       
    input RegWriteW,      

    output [31:0] InstD,
    output Zero,
    output [31:0] ALUResultE,
    output FlushD,
    output FlushE
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
wire [4:0]  Rs1D;        // Extraído de la instrucción en Decode
wire [4:0]  Rs2D;        // Extraído de la instrucción en Decode

// ================================================================
// Señales de Execute
// ================================================================

wire [31:0] RD1E;
wire [31:0] RD2E;
wire [31:0] ImmE;
wire [31:0] SrcAE;       
wire [31:0] SrcBE;       
wire [31:0] WriteDataE;  
wire [31:0] PCTargetE;
wire [4:0]  RdE;
wire [31:0] PC4E;
wire [31:0] PCE;
wire [4:0]  Rs1E;        // Propagado a Execute para la Hazard Unit
wire [4:0]  Rs2E;        // Propagado a Execute para la Hazard Unit

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

// ================================================================
// Señales de Forwarding y Hazard Unit
// ================================================================

wire [1:0] ForwardAE;
wire [1:0] ForwardBE;

assign RdD  = InstD[11:7];
assign Rs1D = InstD[19:15];
assign Rs2D = InstD[24:20];

// ================================================================
// FETCH
// ================================================================

FFD32 Inst(
    .clk(clk),
    .reset(reset),
    .D(PCNext),
    .Q(PCF)
);

Memoria2 #(.N(6)) InsMem (
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
    .clear(FlushD), 
    .A(InstF),
    .B(PCF),
    .C(PC4F),
    .I(InstD),
    .J(PCD),
    .K(PC4D)
);

// ================================================================
// DECODE
// ================================================================

Register_File BR (
    .clk(clk),
    .WD3(ResultW),
    .A1(Rs1D),
    .A2(Rs2D),
    .A3(RdW),
    .WE3(RegWriteW),
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
    .clear(FlushE),
    .A(RD1D),
    .B(RD2D),
    .C(RdD),
    .D(PCD),
    .E(ImmD),
    .F(PC4D),
    .G(Rs1D),         
    .H(Rs2D),         
    
    .I(RD1E),
    .J(RD2E),
    .K(RdE),
    .L(PCE),
    .M(ImmE),
    .N(PC4E),
    .O(Rs1E),         
    .P(Rs2E)          
);

// ================================================================
// EXECUTE
// ================================================================

MUX4_32 MUXHUA(
    .A(RD1E), 
    .B(ResultW), 
    .C(ALUResultM),
    .D(32'b0),
    .sel(ForwardAE),
    .Y(SrcAE)
);

MUX4_32 MUXHUB(
    .A(RD2E), 
    .B(ResultW), 
    .C(ALUResultM), 
    .D(32'b0),
    .sel(ForwardBE),
    .Y(WriteDataE)
);

MUX32 MUXALUB (
    .A(WriteDataE),
    .B(ImmE),
    .sel(ALUSrc),
    .C(SrcBE)
);

ALU ALU (
    .A(SrcAE),
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
    .clear(1'b0),      
    .A(ALUResultE),
    .B(WriteDataE),
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

Data_Memory #(.DIR(1)) DM (
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
    .clear(1'b0),      
    .A(ALUResultM),
    .B(ReadDataM),
    .C(RdM),
    .D(PC4M),
    .H(ALUResultW),
    .I(ReadDataW),
    .J(RdW),
    .K(PC4W)
);

MUX4_32 MUXMW(
    .A(ALUResultW),
    .B(ReadDataW),
    .C(PC4W),
    .D(32'b0),
    .sel(ResultSrc),
    .Y(ResultW)
);
    
// ================================================================
// Hazard Unit Instantiation
// ================================================================    

Hazard_Unit HU_inst (
    .Rs1E(Rs1E),
    .Rs2E(Rs2E),
    .RdM(RdM),
    .RdW(RdW),
    .RegWriteM(RegWriteM),
    .RegWriteW(RegWriteW),
    .PCSrc(PCSrc),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE),
    .FlushD(FlushD),
    .FlushE(FlushE)
);

endmodule