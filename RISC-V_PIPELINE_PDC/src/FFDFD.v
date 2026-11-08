`timescale 1ns / 1ps

module FFDFD(
    input clk,
    input reset,

    input [31:0] A,
    input [31:0] B,
    input [31:0] C,

    output reg [31:0] H,
    output reg [31:0] I,
    output reg [31:0] J
);

initial begin
H = 32'b0;
I = 32'b0;
J = 32'b0;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        H <= 32'b0;
        I <= 32'b0;
        J <= 32'b0;
    end
    else begin
        H <= A;
        I <= B;
        J <= C;
    end
end

endmodule