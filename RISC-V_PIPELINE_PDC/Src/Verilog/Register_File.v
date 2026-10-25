`timescale 1ns / 1ps

module Register_File(
input clk,
input [31:0] WD3,
input [4:0] A1,
input [4:0] A2,
input [4:0] A3,
input WE3,
output [31:0] RD1,
output [31:0] RD2
    );
    
reg [31:0] banco [31:0];

integer i;
initial begin
    for (i = 0; i < 32; i = i + 1) begin
        banco[i] = 32'b0;
    end
end

always @(posedge clk) begin
    if (WE3 && (A3 != 5'b00000))
        banco[A3] <= WD3;
end
   
assign RD1 = banco[A1];
assign RD2 = banco[A2];

endmodule

//Como puedo hacerlo mas eficiente?
