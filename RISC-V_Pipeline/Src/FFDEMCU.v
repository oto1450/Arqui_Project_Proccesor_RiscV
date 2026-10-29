`timescale 1ns / 1ps

module FFDEMCU(
    input clk,
    input reset,
    input clear,        // Señal de limpieza (flush) añadida

    input A,
    input [1:0] B,
    input C,
    
    output reg H,
    output reg [1:0] I,
    output reg J
);

initial begin
    H = 1'b0;
    I = 2'b0;
    J = 1'b0;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        H <= 1'b0;
        I <= 2'b0;
        J <= 1'b0;
    end
    else if (clear) begin
        // Si hay un clear/flush, anulamos las señales de control de la etapa
        H <= 1'b0;
        I <= 2'b0;
        J <= 1'b0;
    end
    else begin
        H <= A;
        I <= B;
        J <= C;
    end
end

endmodule
