`timescale 1ns / 1ps

module FFD32(
    input clk,
    input reset,
    input [31:0] D,
    output reg [31:0] Q = 32'd0
);

always @(posedge clk or posedge reset) begin
    if (reset)
        Q <= 32'd0;
    else
        Q <= D;
end

endmodule