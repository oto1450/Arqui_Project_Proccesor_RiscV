`timescale 1ns / 1ps

module FFD(
input clk,
input reset,
input D,
output reg Q = 1'd0
    );

initial begin
Q = 1'd0;
end    
    
always @(posedge clk or posedge reset) begin 
    if (reset) begin
        Q <= 1'd0;
    end    
    else begin
        Q <= D;
    end
end                

endmodule
