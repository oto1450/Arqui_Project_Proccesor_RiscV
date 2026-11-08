`timescale 1ns / 1ps

module ALU_tb;

    // Declaración con 'signed' para que Vivado interprete los números con signo
    reg  signed [31:0] A;
    reg  signed [31:0] B;
    reg         [2:0]  ALUcontrol;
    wire signed [31:0] C;
    wire Zero;
    // Instanciación de la Unidad Bajo Prueba (UUT)
    ALU uut (
        .A(A),
        .B(B),
        .ALUcontrol(ALUcontrol),
        .C(C),
        .Zero(Zero)
    );

    initial begin
        // Inicialización de señales
        A = 32'sd0;
        B = 32'sd0;
        ALUcontrol = 3'b000;

        #10;
        $display("\n=======================================================");
        $display("   SIMULACION ALU (A SIEMPRE POSITIVO | B SIGNED)      ");
        $display("=======================================================\n");

        // -------------------------------------------------------------
        // PRUEBA 1: RESTA CON B POSITIVO (A = 20, B = 5 -> A - B = 15)
        // -------------------------------------------------------------
        A = 32'sd20;
        B = 32'sd5;
        ALUcontrol = 3'b001; // Resta
        #10;
        $display("[PRUEBA 1] RESTA con B positivo (%sd - %sd):", A, B);
        if (C === 32'sd15)
            $display("  -> PASO: C = %sd (Esperado: 15)", C);
        else
            $display("  -> ERROR: C = %sd (Esperado: 15)", C);

        // -------------------------------------------------------------
        // PRUEBA 2: RESTA CON B NEGATIVO (A = 20, B = -5 -> A - (-5) = 25)
        // -------------------------------------------------------------
        A = 32'sd20;
        B = -32'sd5; // B es negativo (-5)
        ALUcontrol = 3'b001; // Resta: 20 - (-5) = 25
        #10;
        $display("\n[PRUEBA 2] RESTA con B negativo (%sd - (%sd)):", A, B);
        if (C === 32'sd25)
            $display("  -> PASO: C = %sd (Esperado: 25)", C);
        else
            $display("  -> ERROR: C = %sd (Esperado: 25)", C);

        // -------------------------------------------------------------
        // PRUEBA 3: SUMA CON B NEGATIVO (A = 30, B = -10 -> 30 + (-10) = 20)
        // -------------------------------------------------------------
        A = 32'sd30;
        B = -32'sd10;
        ALUcontrol = 3'b000; // Suma
        #10;
        $display("\n[PRUEBA 3] SUMA con B negativo (%sd + (%sd)):", A, B);
        if (C === 32'sd20)
            $display("  -> PASO: C = %sd (Esperado: 20)", C);
        else
            $display("  -> ERROR: C = %sd (Esperado: 20)", C);

        // -------------------------------------------------------------
        // PRUEBA 4: SLT CUANDO B ES NEGATIVO (A = 10, B = -15)
        // A (positivo) NUNCA es menor que B (negativo), por lo que A < B es FALSO (0)
        // -------------------------------------------------------------
        A = 32'sd10;
        B = -32'sd15;
        ALUcontrol = 3'b101; // SLT / Ext
        #10;
        $display("\n[PRUEBA 4] SLT con B negativo (%sd < %sd):", A, B);
        if (C === 32'sd0)
            $display("  -> PASO: C = %sd (Esperado: 0)", C);
        else
            $display("  -> ERROR: C = %sd (Esperado: 0)", C);

        // -------------------------------------------------------------
        // PRUEBA 5: SLT CUANDO B ES POSITIVO Y MAYOR QUE A (A = 10, B = 30)
        // A < B es VERDADERO (1)
        // -------------------------------------------------------------
        A = 32'sd10;
        B = 32'sd30;
        ALUcontrol = 3'b101; // SLT / Ext
        #10;
        $display("\n[PRUEBA 5] SLT con B positivo (%sd < %sd):", A, B);
        if (C === 32'sd1)
            $display("  -> PASO: C = %sd (Esperado: 1)", C);
        else
            $display("  -> ERROR: C = %sd (Esperado: 1)", C);

        $display("\n=======================================================");
        $display("             SIMULACION FINALIZADA CON EXITO           ");
        $display("=======================================================\n");
        $finish;
    end

endmodule
