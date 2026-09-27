`timescale 1ns / 1ps

module MUX4_32(
    input [31:0] A, //00
    input [31:0] B, //01
    input [31:0] C, //10
    input [31:0] D, //11
    input [1:0] sel,
    output [31:0] Y
    );

    assign Y = (sel == 2'b00) ? A :
               (sel == 2'b01) ? B :
               (sel == 2'b10) ? C :
                                D;

endmodule
