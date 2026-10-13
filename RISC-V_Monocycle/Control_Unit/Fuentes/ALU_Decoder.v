`timescale 1ns / 1ps

module ALU_Decoder(
input op5,
input [1:0] ALUOp,
input [2:0] funct3,
input funct75,
output reg [2:0] ALUControl
    );

initial begin
ALUControl = 3'b000;
end

always @(*) begin

    ALUControl = 3'b000;
        
    casex ({ALUOp, funct3, op5, funct75})
    
        7'b01_000_x_x: begin
            ALUControl = 3'b000;
        end //beq
        
        7'b01_101_x_x: begin
            ALUControl = 3'b001;
        end //bge        
    
        7'b10_000_0_0,
        7'b10_000_0_1,
        7'b10_000_1_0: begin
            ALUControl = 3'b000;
        end //Suma
    
        7'b10_000_1_1: begin
            ALUControl = 3'b001;
        end //Resta
    
        7'b10_010_x_x: begin
            ALUControl = 3'b101;
        end //SLT

        7'b10_110_x_x: begin
            ALUControl = 3'b011;
        end //OR

        7'b10_111_x_x: begin
            ALUControl = 3'b010;
        end //AND

        default: begin
            ALUControl = 3'b000;
        end
    
    endcase
end
    
endmodule
//Se podrian simplificar algunas expresiones como las de suma
