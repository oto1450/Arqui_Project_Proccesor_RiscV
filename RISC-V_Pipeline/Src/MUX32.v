`timescale 1ns / 1ps

module MUX32(
input [31:0] A, // sel = 0
input [31:0] B, // sel = 1
input sel,
output [31:0] C
    );
    
    assign C = sel ? B : A; 
    
endmodule
