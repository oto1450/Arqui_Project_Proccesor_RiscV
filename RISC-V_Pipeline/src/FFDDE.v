`timescale 1ns / 1ps

module FFDDE(
    input clk,
    input reset,
    input clear,        // Señal de limpieza (flush) añadida

    input [31:0] A,
    input [31:0] B,
    input [4:0] C,
    input [31:0] D,
    input [31:0] E,
    input [31:0] F,
    input [4:0] G,
    input [4:0] H,

    output reg [31:0] I,
    output reg [31:0] J,
    output reg [4:0] K,
    output reg [31:0] L,
    output reg [31:0] M,
    output reg [31:0] N,
    output reg [4:0] O,
    output reg [4:0] P
);

initial begin
    I = 32'b0;
    J = 32'b0;
    K = 5'b0;
    L = 32'b0;
    M = 32'b0;
    N = 32'b0;
    O = 5'b0;
    P = 5'b0;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        I <= 32'b0;
        J <= 32'b0;
        K <= 5'b0;
        L <= 32'b0;
        M <= 32'b0;
        N <= 32'b0;
        O <= 5'b0;
        P <= 5'b0;
    end
    else if (clear) begin
        // Si hay un clear/flush, reiniciamos todas las salidas a cero (burbuja / NOP)
        I <= 32'b0;
        J <= 32'b0;
        K <= 5'b0;
        L <= 32'b0;
        M <= 32'b0;
        N <= 32'b0;
    end
    else begin
        // Cada salida guarda el valor de su respectiva compañera de entrada
        I <= A;
        J <= B;
        K <= C;
        L <= D;
        M <= E;
        N <= F;
        O <= G;
        P <= H;
    end
end

endmodule