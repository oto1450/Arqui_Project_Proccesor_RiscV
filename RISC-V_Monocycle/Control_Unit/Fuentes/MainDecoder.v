`timescale 1ns / 1ps

// Decodificador principal con ResultSrc de 1 bit
module MainDecoder(
    input [6:0] op,
    output reg RegWrite,
    output reg [1:0] ImmSrc,
    output reg ALUSrc,
    output reg MemWrite,
    output reg [1:0] ResultSrc,    // Modificado a 1 bit
    output reg [1:0] ALUOp,
    output reg Branch,
    output reg Jump
);

initial begin
RegWrite = 1'b0;
ImmSrc = 2'b0;
ALUSrc = 1'b0;
MemWrite = 1'b0;
ResultSrc = 2'b0;
ALUOp = 2'b0;
Branch = 1'b0;
Jump = 1'b0;
end

always @(*) begin

    // Valores por defecto
    RegWrite  = 1'b0;
    ImmSrc    = 2'b00;
    ALUSrc    = 1'b0;
    MemWrite  = 1'b0;
    ResultSrc = 2'b00;
    ALUOp     = 2'b00;
    Branch    = 1'b0;
    Jump      = 1'b0;
    
    case (op)
        
        // Cargas (lw, lb, lh, lbu, lhu)
        7'd3: begin
            RegWrite  = 1'b1;
            ImmSrc    = 2'b00;
            ALUSrc    = 1'b1;
            MemWrite  = 1'b0;
            ResultSrc = 2'b01;
            Branch    = 1'b0;
            ALUOp     = 2'b00;
            Jump      = 1'b0;
        end       

        // Almacenamiento (sw, sb, sh)
        7'd35: begin
            RegWrite  = 1'b0;
            ImmSrc    = 2'b01;
            ALUSrc    = 1'b1;
            MemWrite  = 1'b1;
            ResultSrc = 2'b00;
            Branch    = 1'b0;
            ALUOp     = 2'b00;
            Jump      = 1'b0;
        end
        
        // Tipo R (add, sub, and, or, slt)
        7'd51: begin
            RegWrite  = 1'b1;
            ImmSrc    = 2'bxx;
            ALUSrc    = 1'b0;
            MemWrite  = 1'b0;
            ResultSrc = 2'b00;
            Branch    = 1'b0;
            ALUOp     = 2'b10;
            Jump      = 1'b0;
        end
        
        // Tipo B (beq, bne, blt, bge, bltu, bgeu)
        7'd99: begin
            RegWrite  = 1'b0;
            ImmSrc    = 2'b10;
            ALUSrc    = 1'b0;
            MemWrite  = 1'b0;
            ResultSrc = 2'b00;
            Branch    = 1'b1;
            ALUOp     = 2'b01;
            Jump      = 1'b0;
        end               
        
        // Tipo I Aritmético (addi, andi, ori)
        7'd19: begin
            RegWrite  = 1'b1;
            ImmSrc    = 2'b00;
            ALUSrc    = 1'b1;
            MemWrite  = 1'b0;
            ResultSrc = 2'b00; 
            Branch    = 1'b0;
            ALUOp     = 2'b10;
            Jump      = 1'b0;
        end
        
        //Tipo J Saltos: jal, j, etc.
        7'd111: begin 
            RegWrite  = 1'b1;
            ImmSrc    = 2'b11;
            ALUSrc    = 1'b0;
            MemWrite  = 1'b0;
            ResultSrc = 2'b10;
            Branch    = 1'b0;
            ALUOp     = 2'b00;
            Jump      = 1'b1;
        end

        default: begin
            RegWrite  = 1'b1;
            ImmSrc    = 2'b00;
            ALUSrc    = 1'b0;
            MemWrite  = 1'b0;
            ResultSrc = 2'b0;
            ALUOp     = 2'b10;
            Branch    = 1'b0;
        end
                
    endcase
end

endmodule
