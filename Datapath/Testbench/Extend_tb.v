`timescale 1ns / 1ps

module Extend_tb;

    reg  [24:0] A;
    reg  [1:0]  sel;
    wire [31:0] Imm;

    Extend uut (
        .A(A),
        .sel(sel),
        .Imm(Imm)
    );

    // Helper task para pasar la instruccion completa [31:0] al puerto A[24:0]
    reg [31:0] instr_full;

    initial begin
        // -------------------------------------------------------------
        // PRUEBA Tipo I: addi x5, x6, -10 (0xFF630293)
        // Inmediato esperado: -10 (32'hFFFF_FFF6)
        // -------------------------------------------------------------
        instr_full = 32'hFF630293;
        A   = instr_full[31:7]; // Extrae los 25 bits [31:7]
        sel = 2'b00;
        #10;
        $display("[Tipo I]  Entrada: -10 | Resultado: %d (Hex: %h)", $signed(Imm), Imm);

        // -------------------------------------------------------------
        // PRUEBA Tipo S: sw x5, 40(x6) (0x02532423)
        // Inmediato esperado: +40 (32'h0000_0028)
        // -------------------------------------------------------------
        instr_full = 32'h02532423;
        A   = instr_full[31:7];
        sel = 2'b01;
        #10;
        $display("[Tipo S]  Entrada: +40 | Resultado: %d (Hex: %h)", $signed(Imm), Imm);

        // -------------------------------------------------------------
        // PRUEBA Tipo B: beq x1, x2, -16 (0xFE2088E3)
        // Inmediato esperado: -16 (32'hFFFF_FFF0)
        // -------------------------------------------------------------
        instr_full = 32'hFE2088E3;
        A   = instr_full[31:7];
        sel = 2'b10;
        #10;
        $display("[Tipo B]  Entrada: -16 | Resultado: %d (Hex: %h)", $signed(Imm), Imm);

        $finish;
    end

endmodule
