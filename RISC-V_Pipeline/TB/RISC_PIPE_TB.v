
`timescale 1ns / 1ps

module RISC_PIPE_TB;

    reg clk;
    reg reset;

    wire [6:0] op;
    wire [31:0] ALUResultE;

    // ============================================================
    // DUT: Device Under Test
    // ============================================================

    RISC_V_Pipeline DUT (
        .clk(clk),
        .reset(reset),
        .op(op),
        .ALUResultE(ALUResultE)
    );

    // ============================================================
    // CLOCK: Periodo de 10 ns (100 MHz)
    // ============================================================

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // ============================================================
    // RESET Y DURACION DE LA SIMULACION
    // ============================================================

    initial begin
        reset = 1'b1;

        repeat (5) @(negedge clk);
        reset = 1'b0;

        // Ejecutar el programa y dejar vaciar el pipeline
        repeat (30) @(posedge clk);

        #1;
        $finish;
    end

    // ============================================================
    // MONITOREO DE SALIDAS
    // ============================================================

    initial begin
        $display("========================================================");
        $display("   SIMULACION RISC-V PIPELINE");
        $display("========================================================");
        $display("Tiempo(ns) | Reset | Opcode | ALUResultE");
        $display("--------------------------------------------------------");

        $monitor("%10t |   %b   |  %02h    | %08h",
                 $time, reset, op, ALUResultE);
    end
endmodule

