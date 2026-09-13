`timescale 1ns / 1ps

module Memoria #(
    parameter N = 6,
    parameter M = 32)
(
input clk,
input we,
input [N-1:0] dir,
input [M-1:0] data_in,
output reg [M-1:0] data_out
    );
    
    reg [M-1:0] my_mem [2**N-1:0];
    
    always @ (posedge clk)
    if (we) 
        my_mem [dir] <= data_in;
        
    always @ (posedge clk)    
        data_out <= my_mem[dir];
    
endmodule
