`timescale 1ns / 1ps

module RISC_V_Single_tb;

    // ============================================
    // Señales del testbench
    // ============================================

    reg clk;

    wire [31:0] Result;

    // ============================================
    // Instancia del procesador
    // ============================================

    RISC_V_Single dut (
        .clk(clk),
        .Result(Result)
    );

    // ============================================
    // Generación del reloj
    // Periodo = 10 ns
    // Frecuencia = 100 MHz
    // ============================================

    initial begin
        clk = 1'b0;

        forever begin
            #5 clk = ~clk;
        end
    end

    // ============================================
    // Monitor de señales
    // ============================================

    initial begin
        $monitor(
            "T=%0t",
            $time,
        );
    end

    // ============================================
    // Duración de la simulación
    // ============================================

    initial begin
        #500;

        $display("--------------------------------------");
        $display("Fin de la simulacion");
        $display("--------------------------------------");

        $finish;
    end

endmodule
