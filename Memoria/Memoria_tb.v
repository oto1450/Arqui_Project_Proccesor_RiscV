`timescale 1ns / 1ps

module Memoria_tb;

    parameter N = 4;
    parameter M = 8;

    reg clk;
    reg we;
    reg [N-1:0] dir;
    reg [M-1:0] data_in;

    wire [M-1:0] data_out;

    Memoria #(
        .N(N),
        .M(M)
    ) DUT (
        .clk(clk),
        .we(we),
        .dir(dir),
        .data_in(data_in),
        .data_out(data_out)
    );


    // Clock de 10 ns
    initial begin
        clk = 0;

        forever #5 clk = ~clk;
    end


    initial begin

        // Valores iniciales
        we = 0;
        dir = 0;
        data_in = 0;

        // Esperamos un poco
        #10;


        // =====================
        // ESCRIBIR EN dir = 3
        // =====================

        @(negedge clk);

        we = 1;
        dir = 4'd3;
        data_in = 8'hAA;


        // =====================
        // ESCRIBIR EN dir = 5
        // =====================

        @(negedge clk);

        we = 1;
        dir = 4'd5;
        data_in = 8'h55;


        // =====================
        // LEER dir = 3
        // =====================

        @(negedge clk);

        we = 0;
        dir = 4'd3;


        // =====================
        // LEER dir = 5
        // =====================

        @(negedge clk);

        we = 0;
        dir = 4'd5;


        #20;

        $finish;

    end

endmodule
