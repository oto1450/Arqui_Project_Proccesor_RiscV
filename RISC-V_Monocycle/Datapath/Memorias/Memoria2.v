`timescale 1ns / 1ps

module Memoria2 #(
    parameter N = 12
)(
    input [N-1:0] dir,
    output [31:0] data_out
);

reg [7:0] my_mem [0:2**N-1];

integer k;

initial begin
    // Inicializar todo en 0 para evitar valores X en direcciones vacías
    for (k = 0; k < (2**N); k = k + 1) begin
        my_mem[k] = 8'h00;
    end

    // Cargar los bytes secuencialmente desde el archivo
    $readmemh("programa2.mem", my_mem, 0);
end

// Corrección del orden de ensamblaje de los 32 bits (Little Endian de RISC-V: 
// el byte menos significativo está en la dirección más baja `dir`)
assign data_out = {
    my_mem[dir + 3],  // Byte más significativo
    my_mem[dir + 2],
    my_mem[dir + 1],
    my_mem[dir]     // Byte menos significativo
};

endmodule
