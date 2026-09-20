`timescale 1ns / 1ps

module Extend(

input [24:0] A,
input [1:0] sel,
output [31:0] Imm
    );
    
    assign Imm = (sel == 2'b00) ? { {20{A[24]}}, A[24:13] } :  // Tipo I
           (sel == 2'b01) ? { {20{A[24]}}, A[24:18], A[4:0] } : // Tipo S
           (sel == 2'b10) ? { {19{A[24]}}, A[24], A[0], A[23:18], A[4:1], 1'b0 } : //Tipo B
                                    32'h0;   // Caso por defecto (Default)
endmodule

//Hacerlo mas eficiente de otra manera?