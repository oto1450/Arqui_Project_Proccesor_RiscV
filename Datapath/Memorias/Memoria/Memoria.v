`timescale 1ns / 1ps

module Memoria #(
    parameter N = 4,
    parameter M = 32)
(
input clk,
input [N-1:0] dir,
output reg [M-1:0] data_out
    );
    
reg [M-1:0] my_mem [2**N-1:0];

initial begin
    $readmemh("programa.mem", my_mem);
end

always @ (posedge clk)    
    data_out <= my_mem[dir];
    
endmodule
