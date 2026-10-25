`timescale 1ns / 1ps

module FFDDECU(
    input clk,
    input reset,

    input A,
    input [1:0] B,
    input C,
    input D,
    input E,
    input [2:0] F,
    input G,

    output reg H,
    output reg [1:0] I,
    output reg J,
    output reg K,
    output reg L,
    output reg [2:0] M,
    output reg N
);

initial begin
H = 1'b0;
I = 2'b0;
J = 1'b0;
K = 1'b0;
L = 1'b0;
M = 3'b0;
N = 1'b0;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        H <= 1'b0;
        I <= 2'b0;
        J <= 1'b0;
        K <= 1'b0;
        L <= 1'b0;
        M <= 3'b0;
        N <= 1'b0;
    end
    else begin
        H <= A;
        I <= B;
        J <= C;
        K <= D;
        L <= E;
        M <= F;
        N <= G;
    end
end

endmodule