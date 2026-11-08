`timescale 1ns / 1ps

module Hazard_Unit(
    input [4:0] Rs1E,
    input [4:0] Rs2E,
    input [4:0] RdM,
    input [4:0] RdW,
    input RegWriteM,
    input RegWriteW,
    input PCSrc,
    output reg [1:0] ForwardAE,
    output reg [1:0] ForwardBE,
    output reg FlushD,
    output reg FlushE
);

initial begin
    ForwardAE = 2'b0;
    ForwardBE = 2'b0;
    FlushD = 1'b0;
    FlushE = 1'b0;
end
    
always @(*) begin
    // --- Lógica de Forwarding para el operando A (Rs1E) ---
    if ((Rs1E == RdM) && RegWriteM && (Rs1E != 5'b0))
        ForwardAE = 2'b10; // Viene de la etapa Memory
    else if ((Rs1E == RdW) && RegWriteW && (Rs1E != 5'b0))
        ForwardAE = 2'b01; // Viene de la etapa Writeback
    else
        ForwardAE = 2'b00; // Sin reenvío (usa el Register File)
        
    // --- Lógica de Forwarding para el operando B (Rs2E) ---
    if ((Rs2E == RdM) && RegWriteM && (Rs2E != 5'b0))
        ForwardBE = 2'b10; // Viene de la etapa Memory
    else if ((Rs2E == RdW) && RegWriteW && (Rs2E != 5'b0))
        ForwardBE = 2'b01; // Viene de la etapa Writeback
    else
        ForwardBE = 2'b00; // Sin reenvío (usa el Register File)

    // --- Lógica de Control Hazards (Flush por salto tomado) ---
    if (PCSrc == 1'b1) begin
        FlushD = 1'b1;
        FlushE = 1'b1;
    end
    else begin
        FlushD = 1'b0;
        FlushE = 1'b0;
    end
end

endmodule
