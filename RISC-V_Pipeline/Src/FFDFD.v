`timescale 1ns / 1ps

module FFDFD(
    input clk,
    input reset,
    input clear,        // Señal de limpieza (flush) añadida

    input [31:0] A,
    input [31:0] B,
    input [31:0] C,

    output reg [31:0] I,
    output reg [31:0] J,
    output reg [31:0] K
);

initial begin
    I = 32'b0;
    J = 32'b0;
    K = 32'b0;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        I <= 32'b0;
        J <= 32'b0;
        K <= 32'b0;
    end
    else if (clear) begin
        // Si hay un clear/flush, reiniciamos todas las salidas a cero (burbuja / NOP)
        I <= 32'b0;
        J <= 32'b0;
        K <= 32'b0;
    end
    else begin
        // Cada salida guarda el valor de su respectiva compañera de entrada
        I <= A;
        J <= B;
        K <= C;
    end
end

endmodule