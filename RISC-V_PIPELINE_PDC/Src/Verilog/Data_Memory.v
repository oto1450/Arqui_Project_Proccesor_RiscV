`timescale 1ns / 1ps

module Data_Memory #(
    parameter DIR = 6   // Bits de dirección (2^DIR = 64 posiciones)
)(
    input clk,
    input [31:0] A,     // Dirección de memoria (viene de la ALU)
    input [31:0] WD,    // Dato a escribir
    input WE,           // Write Enable (Habilitación de escritura)
    output [31:0] RD    // Dato leído
);
    
    // Declaración del banco de memoria (Palabras de 32 bits)
    reg [31:0] datos [0:(1<<DIR)-1];  

    integer i;
    initial begin
        // Inicializar toda la memoria en ceros para evitar 'X' en simulación
        for (i = 0; i < (1<<DIR); i = i + 1) begin
            datos[i] = 32'd0;
        end
    end
    
    // Escritura sincrónica (con flanco de reloj)
    always @(posedge clk) begin
        if (WE)
            datos[A] <= WD; 
    end
   
    // Lectura combinacional
    assign RD = datos[A];
    
endmodule
