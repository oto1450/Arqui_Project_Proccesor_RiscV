`timescale 1ns / 1ps

module FFD32 (
    input clk,
    input reset,      // Señal de reset asíncrono
    input [31:0] D,
    output reg [31:0] Q
);

initial begin
Q = 32'd0;
end

    always @(posedge clk) begin
        if (reset) begin
            Q <= 32'd0; // Valor al que se reinicia el PC
        end else begin
            Q <= D;
        end
    end

endmodule