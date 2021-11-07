`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.11.2021 21:25:45
// Design Name: 
// Module Name: test_ARM
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


module test_ARM(

    );
    
    // DECLARE INPUT SIGNALS
    reg CLK;
    reg RESET;
    reg [31:0] Instr;
    reg [31:0] ReadData;
    
    // DECLARE OUTPUT SIGNALS
    wire MemWrite;
    wire [31:0] PC;
    wire [31:0] ALUResult;
    wire [31:0] WriteData;
    
    // INSTANTIATE DUT
    ARM dut(CLK, RESET, Instr, ReadData, MemWrite, PC, ALUResult, WriteData);
    
    // STIMULI
    initial begin
        CLK = 0;
        RESET = 1; #5;
        RESET = 0;
        // ADD R2, R3, #0x0FF0
        Instr = 32'hE2832EFF; ReadData = 32'h0; #20;
        // ADC Rd, Rn, #Imm8_rot
        Instr = 32'hE2A32EFF; ReadData = 32'h0; #20;
        // SUB Rd, Rn, #Imm8_rot
        Instr = 32'hE2432EFF; ReadData = 32'h0; #20;
        // SBC Rd, Rn, #Imm8_rot
        Instr = 32'hE2C32EFF; ReadData = 32'h0; #20;
        // AND Rd, Rn, #Imm8_rot
        Instr = 32'hE2032EFF; ReadData = 32'h0; #20;
        // BIC Rd, Rn, #Imm8_rot
        Instr = 32'hE3C32EFF; ReadData = 32'h0; #20;
        // ORR Rd, Rn, #Imm8_rot
        Instr = 32'hE3832EFF; ReadData = 32'h0; #20;
        // RSB Rd, Rn, #Imm8_rot
        Instr = 32'hE2632EFF; ReadData = 32'h0; #20;
        // RSC Rd, Rn, #Imm8_rot
        Instr = 32'hE2E32EFF; ReadData = 32'h0; #20;
        // EOR Rd, Rn, #Imm8_rot
        Instr = 32'hE2232EFF; ReadData = 32'h0; #20;
        // CMP Rn, #Imm8_rot
        Instr = 32'hE3530EFF; ReadData = 32'h0; #20;
        // CMN Rn, #Imm8_rot
        Instr = 32'hE3730EFF; ReadData = 32'h0; #20;
        // TST Rn, #Imm8_rot
        Instr = 32'hE3130EFF; ReadData = 32'h0; #20;
        // TEQ Rd, Rn, #Imm8_rot
        Instr = 32'hE3330EFF; ReadData = 32'h0; #20;
        // MOV Rd, #Imm8_rot
        Instr = 32'hE3A02EFF; ReadData = 32'h0; #20;
        // MVN Rd, #Imm8_rot
        Instr = 32'hE3E02EFF; ReadData = 32'h0; #20;
        
        // ADD Rd, Rn, Rm, ST #Imm8_rot
        Instr = 32'hE0818103; ReadData = 32'h0; #20;
        // ADC Rd, Rn, Rm, ST #Imm8_rot
        Instr = 32'hE0A18123; ReadData = 32'h0; #20;
        // SUB Rd, Rn, Rm, ST #Imm8_rot
        Instr = 32'hE0418143; ReadData = 32'h0; #20;
        // SBC Rd, Rn, Rm, ST #Imm8_rot
        Instr = 32'hE0018163; ReadData = 32'h0; #20;
        // AND Rd, Rn, Rm, ST #Imm8_rot
        Instr = 32'hE1C18103; ReadData = 32'h0; #20;
        // BIC Rd, Rn, Rm, ST #Imm8_rot
        Instr = 32'hE1818123; ReadData = 32'h0; #20;
        // ORR Rd, Rn, Rm, ST #Imm8_rot
        Instr = 32'hE1818143; ReadData = 32'h0; #20;
        // RSB Rd, Rn, Rm, ST #Imm8_rot
        Instr = 32'hE0618163; ReadData = 32'h0; #20;
        // RSC Rd, Rn, Rm, ST #Imm8_rot
        Instr = 32'hE0E18103; ReadData = 32'h0; #20;
        // EOR Rd, Rn, Rm, ST #Imm8_rot
        Instr = 32'hE0218123; ReadData = 32'h0; #20;
        // CMP Rn, Rm, ST #Imm8_rot
        Instr = 32'hE1510143; ReadData = 32'h0; #20;
        // CMN Rn, Rm, ST #Imm8_rot
        Instr = 32'hE1710163; ReadData = 32'h0; #20;
        // TST Rn, Rm, ST #Imm8_rot
        Instr = 32'hE1310103; ReadData = 32'h0; #20;
        // TEQ Rd, Rm, ST #Imm8_rot
        Instr = 32'hE1110123; ReadData = 32'h0; #20;
        // MOV Rd, Rm, ST #Imm8_rot
        Instr = 32'hE1A08143; ReadData = 32'h0; #20;
        // MVN Rd, Rm, ST #Imm8_rot
        Instr = 32'hE1E08163; ReadData = 32'h0; #20;
        
        // MUL Rd, Rm, Rs
        Instr = 32'hE0080C9A; ReadData = 32'h0; #20;
        // MLA (DIV) Rd, Rm, Rs, Rn
        Instr = 32'hE0289C9A; ReadData = 32'h0; #20;
        
        // LDR Rd, [Rn, #Imm12]
        Instr = 32'hE595B01A; ReadData = 32'h0; #20;
        // STR Rd, [Rn, #Imm12]
        Instr = 32'hE585B01A; ReadData = 32'h0; #20;
        // LDR Rd, [Rn, #-Imm12]
        Instr = 32'hE515B01A; ReadData = 32'h0; #20
        // STR Rd, [Rn, #-Imm12]
        Instr = 32'hE505B01A; ReadData = 32'h0; #20;
        
        // B #Imm24
        Instr = 32'hEA000003; ReadData = 32'h0; #20;
        
        // End of operation
        Instr = 32'h0; ReadData = 32'h0;
    end
    
    // GENERATE CLOCK
    always begin
        #5 CLK = ~CLK;
    end
    
endmodule
