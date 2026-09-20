`timescale 1ns / 1ps

//Este primer maindecoder unicamente decodificara las instrucciones
//Tipo I: ADDI
//Tipo R: sub, add
//Tipo B: beq, bge
//Tipo J: J

module MainDecoder(
input [6:0] op,
input [2:0] funt3,
input [6:0] func7,
output reg RegWrite,
output reg [1:0] ImmSrc,
output reg ALUSrc,
output reg MemWrite,
output reg [1:0] ResultSrc,
output reg [1:0] ALUOp,
output reg Branch,
output reg Jump
    );
    
always @(*) begin

    // Valores por defecto
    RegWrite  = 0;
    ImmSrc    = 2'b00;
    ALUSrc    = 0;
    MemWrite  = 0;
    ResultSrc = 2'b00;
    ALUOp     = 2'b00;
    Branch    = 0;
    Jump      = 0;
    
    case (op)
        
        7'd3: begin
               RegWrite  = 1;
               ImmSrc    = 2'b00;
               ALUSrc    = 1;
               MemWrite  = 0;
               ResultSrc = 2'b01;
               Branch    = 0;
               ALUOp     = 2'b00;
               Jump      = 0;
        end //Tipo lw, ln, lh, lbu, lhu       

        7'd35: begin
               RegWrite  = 0;
               ImmSrc    = 2'b01;
               ALUSrc    = 1;
               MemWrite  = 1;
               ResultSrc = 2'bXX;
               Branch    = 0;
               ALUOp     = 2'b00;
               Jump      = 0;
        end //Tipo sw, sb,sh
        
        7'd51: begin
               RegWrite  = 1;
               ImmSrc    = 2'bXX;
               ALUSrc    = 0;
               MemWrite  = 0;
               ResultSrc = 2'b00;
               Branch    = 0;
               ALUOp     = 2'b10;
               Jump      = 0;
        end //Tipo R
        
        7'd99: begin
               RegWrite  = 0;
               ImmSrc    = 2'b10;
               ALUSrc    = 0;
               MemWrite  = 0;
               ResultSrc = 2'bXX;
               Branch    = 1;
               ALUOp     = 2'b01;
               Jump      = 0;
        end //Tipo beq, bne, blt, bge, bltu y bgeu                
        
        7'd19: begin
               RegWrite  = 1;
               ImmSrc    = 2'b00;
               ALUSrc    = 1;
               MemWrite  = 0;
               ResultSrc = 2'b00;
               Branch    = 0;
               ALUOp     = 2'b10;
               Jump      = 0;
        end //Tipo I
        
        7'd51: begin
               RegWrite  = 1;
               ImmSrc    = 2'bXX;
               ALUSrc    = 1;
               MemWrite  = 1;
               ResultSrc = 2'bXX;
               Branch    = 0;
               ALUOp     = 2'b00;
               Jump      = 0;
        end //Tipo jal
                
    endcase
end

endmodule
