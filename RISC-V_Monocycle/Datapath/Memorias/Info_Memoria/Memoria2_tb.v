`timescale 1ns / 1ps

module Memoria2_tb;

    reg [5:0] dir;
    wire [31:0] data_out;

    Memoria2 uut (
        .dir(dir),
        .data_out(data_out)
    );

    // Clock de 10 ns

    initial begin
        dir = 0;

        // Leer posición 0
        #10;
        dir = 6'd0;

        #10;
        $display("MEM[0] = %h", data_out);

        dir = 6'd4;

        #10;
        $display("MEM[1] = %h", data_out);

        dir = 6'd8;

        #10;
        $display("MEM[2] = %h", data_out);

        dir = 6'd12;

        #10;
        $display("MEM[3] = %h", data_out);

        dir = 6'd16;

        #10;
        $display("MEM[4] = %h", data_out);

        // Leer posición 5
        dir = 6'd1;

        #10;
        $display("MEM[5] = %h", data_out);

        // Leer posición 6
        dir = 6'd2;

        #10;
        $display("MEM[6] = %h", data_out);

        // Leer posición 7
        dir = 6'd3;

        #10;
        $display("MEM[7] = %h", data_out);

        #10;
        $finish;

    end

endmodule
