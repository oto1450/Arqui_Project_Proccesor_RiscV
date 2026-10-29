`timescale 1ns / 1ps

module FFDMW(
    input clk,
    input reset,
    input clear,        // Señal de limpieza (flush) añadida

    input [31:0] A,
    input [31:0] B,
    input [4:0] C,
    input [31:0] D,
    
    output reg [31:0] H,
    output reg [31:0] I,
    output reg [4:0] J,
    output reg [31:0] K
);

initial begin
    H = 32'b0;
    I = 32'b0;
    J = 5'b0;
    K = 32'b0;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        H <= 32'b0;
        I <= 32'b0;
        J <= 5'b0;
        K <= 32'b0;
    end
    else if (clear) begin
        // Si hay un clear/flush, anulamos los datos que viajan hacia la etapa Writeback
        H <= 32'b0;
        I <= 32'b0;
        J <= 5'b0;
        K <= 32'b0;
    end
    else begin
        H <= A;
        I <= B;
        J <= C;
        K <= D;
    end
end

endmodule