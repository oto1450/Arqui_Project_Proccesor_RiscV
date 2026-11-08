`timescale 1ns / 1ps

module ALU(
    input  [31:0] A,
    input  [31:0] B,
    input  [2:0]  ALUcontrol,
    output [31:0] C,
    output Zero
);

    wire [31:0] Bneg, S, resul, AANDB, AORB, Ext, ExtIgual;

    // Complemento a 1 de B
    assign Bneg = ~B;
    
    // MUX para seleccionar entre B y ~B
    assign S = ALUcontrol[0] ? Bneg : B;
    
    // Sumador/Restador unificado (A + B o A + ~B + 1)
    assign resul = A + S + ALUcontrol[0];
    
    // Operaciones lógicas
    assign AANDB = A & B;
    assign AORB  = A | B;
    
    // Extensión con ceros tomando el bit MSB de la resta (bit 31)
    // 31 ceros + 1 bit MSB = 32 bits
    assign Ext = {31'b0, ($signed(A) < $signed(B))}; //SLT y se usa para BGE A es menor que B? Si es cierto 1 si no 0
    
    assign ExtIgual = {31'b0, ($signed(A) == $signed(B))}; //BEQ Si son iguales 1 de lo contrario 1

    // MUX 8:1 de salida usando ternarios anidados
    assign C = (ALUcontrol == 3'b000) ? resul :  // Suma (A + B)
               (ALUcontrol == 3'b001) ? resul :  // Resta (A - B)
               (ALUcontrol == 3'b010) ? AANDB :  // AND
               (ALUcontrol == 3'b011) ? AORB  :  // OR
               (ALUcontrol == 3'b101) ? Ext   :  // SLT / Sign Extension
                                        32'h0;   // Caso por defecto (Default)
                                        
    assign Zero =(ALUcontrol == 3'b000) ? ExtIgual[0]:
                 (ALUcontrol == 3'b001) ? ~Ext[0] :    
                                        1'b0;  
endmodule

//Posible mejora es realizar un submodulo de la suma y no con + podria mejorar la eficiencia
//Posible mejora seria la comparacion, para hacerla mas eficiente
//Se cambio la arquitectura del ZeroExt ya que se esta haciendo la comparacion desde un inicio y se va a realizar un MUX para seleccionarlo