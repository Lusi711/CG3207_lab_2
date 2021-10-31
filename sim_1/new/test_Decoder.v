`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.09.2021 10:04:19
// Design Name: 
// Module Name: test_Decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_Decoder(

    );
    
    reg [3:0] Rd;
    reg [1:0] Op;
    reg [5:0] Funct;
    reg [3:0] MulBits;
    wire PCS, RegW, MemW, MemtoReg, ALUSrc;
    wire [1:0] ImmSrc;
    wire [1:0] RegSrc;
    wire NoWrite;
    wire [1:0] ALUControl;
    wire [1:0] FlagW;
    wire Start;
    wire [1:0] MCycleOp;
    
    Decoder dut (Rd, Op, Funct, MulBits, PCS, RegW, MemW, MemtoReg, ALUSrc, ImmSrc, RegSrc, NoWrite, ALUControl, FlagW, Start, MCycleOp);
    
    initial begin
        // LDR with +ve immediate offset
        Rd = 4'b0000; Op = 2'b01; Funct = 6'b0x10x1; MulBits = 4'bx; #20;
        // STR with +ve immediate offset
        Rd = 4'b0001; Op = 2'b01; Funct = 6'b0x10x0; MulBits = 4'bx; #20;
        // LDR with -ve immediate offset
        Rd = 4'b0000; Op = 2'b01; Funct = 6'b0x00x1; MulBits = 4'bx; #20;
        // STR with -ve immediate offset
        Rd = 4'b0001; Op = 2'b01; Funct = 6'b0x00x0; MulBits = 4'bx; #20;
        // Add Imm 
        Rd = 4'b0010; Op = 2'b00; Funct = 6'b101000; MulBits = 4'bx; #20;
        // Sub Reg without imm shift
        Rd = 4'b0011; Op = 2'b00; Funct = 6'b000100; MulBits = 4'bx000; #50;
        // And Reg with Imm Shift
        Rd = 4'b0100; Op = 2'b00; Funct = 6'b000000; MulBits = 4'b1xx0; #50;
        // B
        Rd = 4'b0100; Op = 2'b10; Funct = 6'b10xxxx; MulBits = 4'bx; #50; 
        // CMP
        Rd = 4'b0101; Op = 2'b00; Funct = 6'b110101; MulBits = 4'bX; #50;
        // CMN
        Rd = 4'b0110; Op = 2'b00; Funct = 6'b110111; MulBits = 4'bx; #50;
        // MUL
        Rd = 4'b0111; Op = 2'b00; Funct = 6'b000000; MulBits = 4'b1001; #50;
        // DIV (MLA)
        Rd = 4'b1000; Op = 2'b00; Funct = 6'b000010; MulBits = 4'b1001; #50;
        // RSC Imm
        Rd = 4'b1001; Op = 2'b00; Funct = 6'b101110; MulBits = 4'bx; #50;
        // RSC Reg
        Rd = 4'b1001; Op = 2'b00; Funct = 6'b001110; MulBits = 4'bxxx0; #50;
        // TST Imm
        Rd = 4'b0; Op = 2'b00; Funct = 6'b110001; MulBits = 4'bx; #50;
        // TST Reg
        Rd = 4'b0; Op = 2'b00; Funct = 6'b010001; MulBits = 4'bxxx0; #50;
        // TEQ Imm
        Rd = 4'b0; Op = 2'b00; Funct = 6'b110011; MulBits = 4'bx; #50;
        // TEQ Reg
        Rd = 4'b0; Op = 2'b00; Funct = 6'b010011; MulBits = 4'bxxx0; #50;
        // BIC Imm
        Rd = 4'b1001; Op = 2'b00; Funct = 6'b111100; MulBits = 4'bx; #50;
        // BIC Reg
        Rd = 4'b1001; Op = 2'b00; Funct = 6'b011100; MulBits = 4'bxxx0; #50;
        // MOV Imm
        Rd = 4'b1001; Op = 2'b00; Funct = 6'b111010; MulBits = 4'bx; #50;
        // MOV Reg
        Rd = 4'b1001; Op = 2'b00; Funct = 6'b011010; MulBits = 4'bxxx0; #50;
        // MVN Imm
        Rd = 4'b1001; Op = 2'b00; Funct = 6'b111110; MulBits = 4'bx; #50;
        // MVN Reg
        Rd = 4'b1001; Op = 2'b00; Funct = 6'b011110; MulBits = 4'bxxx0; #50;
        // End operation
        Rd = 4'b0; Op = 2'b00; Funct = 6'b0; MulBits = 4'b0; #50;
    end
        
endmodule