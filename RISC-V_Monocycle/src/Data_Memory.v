`timescale 1ns / 1ps


module Data_Memory #(
    parameter DIR = 20   // Bits de dirección (2^DIR)
)(
input clk,
input [31:0] A,
input [31:0] WD,
input WE,
output [31:0] RD
    );
    
reg [31:0] datos [2**DIR:0]; 

integer i;
initial begin
    for (i = 0; i < 32; i = i + 1) begin
        datos[i] = 32'd0;
    end
end
    
always @(posedge clk) begin
    if (WE)
        datos[A] <= WD;
end
   
assign RD = datos[A];
    
endmodule
