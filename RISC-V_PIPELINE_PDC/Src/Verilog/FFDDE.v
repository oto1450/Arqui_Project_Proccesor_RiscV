`timescale 1ns / 1ps

module FFDDE(
    input clk,
    input reset,

    input [31:0] A,
    input [31:0] B,
    input [31:0] C,
    input [4:0] D,
    input [31:0] E,
    input [31:0] F,

    output reg [31:0] H,
    output reg [31:0] I,
    output reg [31:0] J,
    output reg [4:0] K,
    output reg [31:0] N,
    output reg [31:0] Q
);

initial begin
H = 32'b0;
I = 32'b0;
J = 32'b0;
K = 5'b0;
N = 32'b0;
Q = 32'b0;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        H <= 32'b0;
        I <= 32'b0;
        J <= 32'b0;
        K <= 5'b0;
        N <= 32'b0;
        Q <= 32'b0;
    end
    else begin
        H <= A;
        I <= B;
        J <= C;
        K <= D;
        N <= E;
        Q <= F;
    end
end

endmodule