`timescale 1ns / 1ps
/*
----------------------------------------------------------------------------------
-- Company: NUS	
-- Engineer: (c) Shahzor Ahmad and Rajesh Panicker  
-- 
-- Create Date: 09/23/2015 06:49:10 PM
-- Module Name: Decoder
-- Project Name: CG3207 Project
-- Target Devices: Nexys 4 (Artix 7 100T)
-- Tool Versions: Vivado 2015.2
-- Description: Decoder Module
-- 
-- Dependencies: NIL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
--	License terms :
--	You are free to use this code as long as you
--		(i) DO NOT post it on any public repository;
--		(ii) use it only for educational purposes;
--		(iii) accept the responsibility to ensure that your implementation does not violate any intellectual property of ARM Holdings or other entities.
--		(iv) accept that the program is provided "as is" without warranty of any kind or assurance regarding its suitability for any particular purpose;
--		(v)	acknowledge that the program was written based on the microarchitecture described in the book Digital Design and Computer Architecture, ARM Edition by Harris and Harris;
--		(vi) send an email to rajesh.panicker@ieee.org briefly mentioning its use (except when used for the course CG3207 at the National University of Singapore);
--		(vii) retain this notice in this file or any files derived from this.
----------------------------------------------------------------------------------
*/

module Decoder(
    input [3:0] Rd,
    input [1:0] Op,
    input [5:0] Funct, //Instr[25:20]
    input [3:0] MulBits, // Instr[7:4] 1001 for MUL and MLA
    output PCS,
    output RegW,
    output MemW,
    output MemtoReg,
    output ALUSrc,
    output [1:0] ImmSrc,
    output [1:0] RegSrc,
    output NoWrite,
    output reg [3:0] ALUControl,
    output reg [2:0] FlagW,
    output Start,
    output reg [1:0] MCycleOp
    );
    
    wire [1:0] ALUOp;
    wire Branch;
    reg [10:0] controls;
    
    assign {Branch, MemtoReg, MemW, ALUSrc, ImmSrc, RegW, RegSrc, ALUOp} = controls;
    assign PCS = ((Rd == 4'b1111) & RegW) | Branch;
    assign NoWrite = (Op == 2'b00) & (Funct[4:3] == 2'b10) & Funct[0];
    assign Start = (MulBits == 4'b1001) & (Op == 2'b00) & (Funct[5:2] == 4'b0000);
    
    //chapter 3 slides 42: updates Branch, MemtoReg, MemW, ALUSrc, ImmSrc[1:0], RegW, RegSrc[1:0], ALUOp[1:0] (in that order)
    always @(*) 
    begin
        if (Start == 0)
        begin
            case(Op)
                2'b00: controls = (Funct[5]) ? 11'b0001001x010 : 11'b0000xx10010; // DP Imm : DP Reg
                2'b01: 
                begin
                    controls = (Funct[0]) ? 11'b0101011x000 : 11'b0x110101000;  // LDR : STR
                    controls[0] = ~Funct[3];
                end
                2'b10: controls = 11'b1001100x100;   // B
                default: controls = 10'bx;
            endcase
            
            //chapter 3 slides 42: updates ALUControl[1:0] and FlagW[1:0]
            if (ALUOp == 2'b00) 
            begin
                ALUControl = 4'b0000;
                FlagW = 3'b000;
            end else if (ALUOp == 2'b01) 
            begin
                ALUControl = 4'b0010;
                FlagW = 3'b000;
            end else if (ALUOp == 2'b10) 
            begin
                case(Funct[4:1])
                    // ADD
                    4'b0100: begin 
                        ALUControl = 4'b0000;
                        FlagW = (Funct[0]) ? 3'b111 : 3'b000;
                    end
                    // SUB
                    4'b0010: begin
                        ALUControl = 4'b0010;
                        FlagW = (Funct[0]) ? 3'b111 : 3'b000;
                    end
                    // AND
                    4'b0000: begin 
                        ALUControl = 4'b0100; 
                        FlagW = (Funct[0]) ? 3'b110 : 3'b000;
                    end
                    // ORR
                    4'b1100: begin 
                        ALUControl = 4'b0110; 
                        FlagW = (Funct[0]) ? 3'b110 : 3'b000;
                    end
                    // CMP
                    4'b1010: begin 
                        ALUControl = 4'b0010;
                        FlagW = 3'b111;
                    end
                    // CMN
                    4'b1011: begin 
                        ALUControl = 4'b0000;
                        FlagW = 3'b111;
                    end
                    // RSC
                    4'b0111: begin
                        ALUControl = 4'b1001;
                        FlagW = (Funct[0]) ? 3'b111 : 3'b000;
                    end
                    // TST
                    4'b1000: begin
                        ALUControl = 4'b0100;
                        FlagW = 3'b110;
                    end
                    // TEQ
                    4'b1001: begin
                        ALUControl = 4'b1010;
                        FlagW = 3'b110;
                    end
                    // BIC
                    4'b1110: begin
                        ALUControl = 4'b0101; 
                        FlagW = (Funct[0]) ? 3'b110 : 3'b000;
                    end
                    // MOV
                    4'b1101: begin
                        ALUControl = 4'b1100; 
                        FlagW = (Funct[0]) ? 3'b110 : 3'b000;
                    end
                    // MVN
                    4'b1111: begin
                        ALUControl = 4'b1101; 
                        FlagW = (Funct[0]) ? 3'b110 : 3'b000;
                    end
                    // EOR
                    4'b0001: begin
                        ALUControl = 4'b1010; 
                        FlagW = (Funct[0]) ? 3'b110 : 3'b000;
                    end
                    // ADC
                    4'b0101: begin
                        ALUControl = 4'b0001; 
                        FlagW = (Funct[0]) ? 3'b110 : 3'b000;
                    end
                    // SBC
                    4'b0110: begin
                        ALUControl = 4'b0011; 
                        FlagW = (Funct[0]) ? 3'b110 : 3'b000;
                    end
                    // RSB
                    4'b0011: begin
                        ALUControl = 4'b1000; 
                        FlagW = (Funct[0]) ? 3'b110 : 3'b000;
                    end
                    default: begin
                        ALUControl = 4'b1111; 
                        FlagW = 3'b000;
                    end
                endcase
            end else 
            begin
                ALUControl = 4'b1111;
                FlagW = 3'b000;
            end
        end else // For MUL and DIV  updates Branch, MemtoReg, MemW, ALUSrc, ImmSrc[1:0], RegW, RegSrc[1:0], ALUOp[1:0]
        begin
            controls = 11'b0000XX10011;
            ALUControl = 4'b1111;
            FlagW = (Funct[1:0] == 2'b01) ? 3'b100 : 3'b000;
            MCycleOp = Funct[1] ? 2'b11 : 2'b01; // MUL if Funct[1] = 0, DIV if Funct[1] = 1
        end
    end
endmodule