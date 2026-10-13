`timescale 1ns / 1ps

//(* KEEP_HIERARCHY = "yes" *)
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
    output [31:0] Inst,
    output Zero,
    output [31:0] Result,
    output [31:0] PC
);

// Declaración de cables internos para conectar los módulos
wire [31:0] ImmExt;
wire [31:0] SrcB;
wire [31:0] ALUResult;
wire [31:0] ReadData;
wire [31:0] PCPlus4;
wire [31:0] PCTarget;
(* mark_debug = "true" *) wire [31:0] PCNext;
wire [31:0] RD1;
wire [31:0] RD2;

// Instanciación de la Memoria de Instrucciones
Memoria2 #(.N(6)) InsMem (
    .dir(PC), 
    .data_out(Inst)     
);

Register_File RegFile (
    .clk(clk),
    .WD3(Result),
    .A1(Inst[19:15]),
    .A2(Inst[24:20]),
    .A3(Inst[11:7]),
    .WE3(RegWrite),
    .RD1(RD1),
    .RD2(RD2)
);
    
Extend Extend( .A(Inst[31:7]), .sel(ImmSrc), .Imm(ImmExt));
MUX32 MUXALU( .A(RD2), .B(ImmExt), .sel(ALUSrc), .C(SrcB));
ALU ALU( .A(RD1), .B(SrcB), .ALUcontrol(ALUControl), .C(ALUResult), .Zero(Zero));
Data_Memory #(.DIR(6)) Data( .clk(clk), .A(ALUResult), .WD(RD2), .WE(MemWrite), .RD(ReadData) );
MUX4_32 MUXResul( .A(ALUResult), .B(ReadData), .C(PCPlus4), .D(32'b0), .sel(ResultSrc), .Y(Result) );
MUX32 MUXPC( .A(PCPlus4), .B(PCTarget), .sel(PCSrc), .C(PCNext));
FFD32 PCP( .clk(clk), .reset(reset), .D(PCNext), .Q(PC));
SUM4 PC4( .A(PC), .B(PCPlus4));
SUMA Salto( .A(PC), .B(ImmExt), .C(PCTarget));

endmodule
