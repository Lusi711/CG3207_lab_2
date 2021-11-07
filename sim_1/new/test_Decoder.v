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
    
    // DECLARE INPUT VARIABLES
    reg [3:0] Rd;
    reg [1:0] Op;
    reg [5:0] Funct;
    reg [3:0] MulBits;
    
    // DECLARE OUTPUT SIGNALS
    wire PCS, RegW, MemW, MemtoReg, ALUSrc;
    wire [1:0] ImmSrc;
    wire [1:0] RegSrc;
    wire NoWrite;
    wire [3:0] ALUControl;
    wire [2:0] FlagW;
    wire Start;
    wire [1:0] MCycleOp;
    wire [1:0] ShOp;
    
    // INSTANTIATE DUT
    Decoder dut (Rd, Op, Funct, MulBits, PCS, RegW, MemW, MemtoReg, ALUSrc, ImmSrc, RegSrc, NoWrite, ALUControl, FlagW, Start, MCycleOp, ShOp);
    
    // STIMULI
    initial begin
        // ADD Rd, Rn, #Imm8_rot
        Rd = 4'b0010; Op = 2'b00; Funct = 6'b101000; MulBits = 4'b1001; #20;
        // ADC Rd, Rn, #Imm8_rot
        Rd = 4'b0010; Op = 2'b00; Funct = 6'b101010; MulBits = 4'b1001; #20;
        // SUB Rd, Rn, #Imm8_rot
        Rd = 4'b0010; Op = 2'b00; Funct = 6'b100100; MulBits = 4'b1001; #20;
        // SBC Rd, Rn, #Imm8_rot
        Rd = 4'b0010; Op = 2'b00; Funct = 6'b101100; MulBits = 4'b1001; #20;
        // AND Rd, Rn, #Imm8_rot
        Rd = 4'b0010; Op = 2'b00; Funct = 6'b100000; MulBits = 4'b1001; #20;
        // BIC Rd, Rn, #Imm8_rot
        Rd = 4'b0010; Op = 2'b00; Funct = 6'b111100; MulBits = 4'b1001; #20;
        // ORR Rd, Rn, #Imm8_rot
        Rd = 4'b0010; Op = 2'b00; Funct = 6'b111000; MulBits = 4'b1001; #20;
        // RSB Rd, Rn, #Imm8_rot
        Rd = 4'b0010; Op = 2'b00; Funct = 6'b100110; MulBits = 4'b1001; #20;
        // RSC Rd, Rn, #Imm8_rot
        Rd = 4'b0010; Op = 2'b00; Funct = 6'b101110; MulBits = 4'b1001; #20;
        // EOR Rd, Rn, #Imm8_rot
        Rd = 4'b0010; Op = 2'b00; Funct = 6'b100010; MulBits = 4'b1001; #20;
        // CMP Rn, #Imm8_rot
        Rd = 4'b0000; Op = 2'b00; Funct = 6'b110101; MulBits = 4'b1001; #20;
        // CMN Rn, #Imm8_rot
        Rd = 4'b0000; Op = 2'b00; Funct = 6'b110111; MulBits = 4'b1001; #20;
        // TST Rn, #Imm8_rot
        Rd = 4'b0000; Op = 2'b00; Funct = 6'b110001; MulBits = 4'b1001; #20;
        // TEQ Rn, #Imm_rot
        Rd = 4'b0000; Op = 2'b00; Funct = 6'b110011; MulBits = 4'b1001; #20;
        // MOV Rd, #Imm_rot
        Rd = 4'b0010; Op = 2'b00; Funct = 6'b111010; MulBits = 4'b1001; #20;
        // MVN Rd, #Imm_rot
        Rd = 4'b0010; Op = 2'b00; Funct = 6'b111110; MulBits = 4'b1001; #20;
        
        // ADD Rd, Rn, Rm, ST #shamt5
        Rd = 4'b1000; Op = 2'b00; Funct = 6'b001000; MulBits = 4'bxxx0; #20;
        // ADC Rd, Rn, Rm, ST #shamt5
        Rd = 4'b1000; Op = 2'b00; Funct = 6'b001010; MulBits = 4'bxxx0; #20;
        // SUB Rd, Rn, Rm, ST #shamt5
        Rd = 4'b1000; Op = 2'b00; Funct = 6'b000100; MulBits = 4'bxxx0; #20;
        // SBC Rd, Rn, Rm, ST #shamt5
        Rd = 4'b1000; Op = 2'b00; Funct = 6'b001100; MulBits = 4'bxxx0; #20;
        // AND Rd, Rn, Rm, ST #shamt5
        Rd = 4'b1000; Op = 2'b00; Funct = 6'b000000; MulBits = 4'bxxx0; #20;
        // BIC Rd, Rn, Rm, ST #shamt5
        Rd = 4'b1000; Op = 2'b00; Funct = 6'b011100; MulBits = 4'bxxx0; #20;
        // ORR Rd, Rn, Rm, ST #shamt5
        Rd = 4'b1000; Op = 2'b00; Funct = 6'b011000; MulBits = 4'bxxx0; #20;
        // RSB Rd, Rn, Rm, ST #shamt5
        Rd = 4'b1000; Op = 2'b00; Funct = 6'b000110; MulBits = 4'bxxx0; #20;
        // RSC Rd, Rn, Rm, ST #shamt5
        Rd = 4'b1000; Op = 2'b00; Funct = 6'b001110; MulBits = 4'bxxx0; #20;
        // EOR Rd, Rn, Rm, ST #shamt5
        Rd = 4'b1000; Op = 2'b00; Funct = 6'b000010; MulBits = 4'bxxx0; #20;
        // CMP Rn, Rm, ST #shamt5
        Rd = 4'b0000; Op = 2'b00; Funct = 6'b010101; MulBits = 4'bxxx0; #20;
        // CMN Rn, Rm, ST #shamt5
        Rd = 4'b0000; Op = 2'b00; Funct = 6'b010111; MulBits = 4'bxxx0; #20;
        // TST Rn, Rm, ST #shamt5
        Rd = 4'b0000; Op = 2'b00; Funct = 6'b010001; MulBits = 4'bxxx0; #20;
        // TEQ Rn, Rm, ST #shamt5
        Rd = 4'b0000; Op = 2'b00; Funct = 6'b010011; MulBits = 4'bxxx0; #20;
        // MOV Rd, Rm, ST #shamt5
        Rd = 4'b0010; Op = 2'b00; Funct = 6'b011010; MulBits = 4'b1001; #20;
        // MVN Rd, Rm, ST #shamt5
        Rd = 4'b0010; Op = 2'b00; Funct = 6'b011110; MulBits = 4'b1001; #20;
        
        // MUL Rd, Rm, Rs
        Rd = 4'b0000; Op = 2'b00; Funct = 6'b000000; MulBits = 4'b1001; #20;
        // MLA (DIV) Rd, Rm, Rs, Rn
        Rd = 4'b0001; Op = 2'b00; Funct = 6'b000010; MulBits = 4'b1001; #20;
        
        // LDR Rd, [Rn, #Imm12]
        Rd = 4'b1011; Op = 2'b01; Funct = 6'b011001; MulBits = 4'b1001; #20;
        // STR Rd, [Rn, #Imm12]
        Rd = 4'b1011; Op = 2'b01; Funct = 6'b011000; MulBits = 4'b1001; #20;
        // LDR Rd, [Rn, #-Imm12]
        Rd = 4'b1011; Op = 2'b01; Funct = 6'b010001; MulBits = 4'b1001; #20;
        // STR Rd, [Rn, #-Imm12]
        Rd = 4'b1011; Op = 2'b01; Funct = 6'b010000; MulBits = 4'b1001; #20;
        
        // B #Imm24
        Rd = 4'b1111; Op = 2'b10; Funct = 6'b101111; MulBits = 4'b1001; #20; 
        
        // End operation
        Rd = 4'b0; Op = 2'b00; Funct = 6'b0; MulBits = 4'b0; #50;
    end
        
endmodule