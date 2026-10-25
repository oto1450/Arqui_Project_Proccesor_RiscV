`timescale 1ns / 1ps

module Memoria2 #(
    parameter N = 12
)(
    input [N-1:0] dir,
    output [31:0] data_out
);

reg [7:0] my_mem [0:2**N-1];

initial begin
    $readmemh("Datapath.mem", my_mem, 0);
end

assign data_out = {
    my_mem[dir + 3],
    my_mem[dir + 2],
    my_mem[dir + 1],
    my_mem[dir]
};

endmodule