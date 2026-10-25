`timescale 1ns / 1ps

module FFDMWCU(
    input clk,
    input reset,

    input A,
    input [1:0] B,
    
    output reg H,
    output reg [1:0] I
);

initial begin
H = 1'b0;
I = 2'b0;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        H <= 1'b0;
        I <= 2'b0;
    end
    else begin
        H <= A;
        I <= B;
    end
end

endmodule
