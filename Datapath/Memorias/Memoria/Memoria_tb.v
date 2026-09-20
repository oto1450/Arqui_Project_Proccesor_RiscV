`timescale 1ns / 1ps

module Memoria_tb;

    reg clk;
    reg [5:0] dir;
    wire [31:0] data_out;

    Memoria uut (
        .clk(clk),
        .dir(dir),
        .data_out(data_out)
    );

    // Clock de 10 ns
    always #5 clk = ~clk;

    initial begin

        clk = 0;
        dir = 0;

        // Leer posición 0
        #10;
        dir = 6'd0;

        #10;
        $display("MEM[0] = %h", data_out);

        // Leer posición 1
        dir = 6'd1;

        #10;
        $display("MEM[1] = %h", data_out);

        // Leer posición 2
        dir = 6'd2;

        #10;
        $display("MEM[2] = %h", data_out);

        // Leer posición 3
        dir = 6'd3;

        #10;
        $display("MEM[3] = %h", data_out);

        // Leer posición 4
        dir = 6'd4;

        #10;
        $display("MEM[4] = %h", data_out);

        // Leer posición 5
        dir = 6'd5;

        #10;
        $display("MEM[5] = %h", data_out);

        // Leer posición 6
        dir = 6'd6;

        #10;
        $display("MEM[6] = %h", data_out);

        // Leer posición 7
        dir = 6'd7;

        #10;
        $display("MEM[7] = %h", data_out);

        #10;
        $finish;

    end

endmodule