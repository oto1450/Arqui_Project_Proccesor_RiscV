`timescale 1ns / 1ps

module FFD(
input clk,
input D,
input reset,
output reg Q = 1'd0
    );
    
always @(posedge clk)
    begin
        Q <= D;
    end    

endmodule
