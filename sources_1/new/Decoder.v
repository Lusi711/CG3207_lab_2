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
    input [5:0] Funct,
    output reg PCS,
    output RegW,
    output MemW,
    output MemtoReg,
    output ALUSrc,
    output [1:0] ImmSrc,
    output [1:0] RegSrc,
    output reg NoWrite,
    output reg [1:0] ALUControl,
    output reg [1:0] FlagW
    );
    
    wire ALUOp, Branch ;
    reg [9:0] controls; 
    
      assign {Branch,MemtoReg, MemW, ALUSrc, ImmSrc, RegW, RegSrc, ALUOp} = controls;
 
    //chapter 3 slides 42: updates RegSrc[1:0], ImmSrc[1:0], ALUSrc, MemtoReg, RegW, MemW, Branch, ALUOp (in that order)
    always @(*) begin
      case(Op)
         2'b00: if (Funct[5]) controls = 10'b0001001001; // DP Imm
         else controls = 10'b0000001001; // DP Reg
         2'b01: if (Funct[0]) controls = 10'b0101011000;  // LDR  
         else controls = 10'b0011010100;  // STR
         2'b10: controls = 10'b1001100010;   // B
         default: controls = 10'bx;
      endcase
    
    
    //chapter 3 slides 42: updates ALUControl[1:0] and FlagW[1:0]
    if (ALUOp) begin
        case(Funct[4:1])
         4'b0100: begin ALUControl = 2'b00; if (Funct[0]) begin FlagW = 2'b11; NoWrite = 1'b0; end else 
         begin FlagW = 2'b00; NoWrite = 1'b0;  end 
         end// ADD
         
         4'b0010: begin ALUControl = 2'b01; if (Funct[0]) begin FlagW = 2'b11; NoWrite = 1'b0; end else 
         begin FlagW = 2'b00;NoWrite = 1'b0;  end 
         end // SUB
         
         4'b0000: begin ALUControl = 2'b10; if (Funct[0]) begin FlagW = 2'b10; NoWrite = 1'b0; end else 
         begin FlagW = 2'b00;NoWrite = 1'b0;  end 
         end// AND
         
         4'b1100: begin ALUControl = 2'b11; if (Funct[0]) begin FlagW = 2'b10; NoWrite = 1'b0; end else 
         begin FlagW = 2'b00; NoWrite = 1'b0; end 
         end // ORR
         
         4'b1010: begin ALUControl = 2'b01; if (Funct[0]) begin FlagW = 2'b11; NoWrite = 1'b1; end 
         end // CMP

         4'b1011: begin ALUControl = 2'b00; if (Funct[0]) begin FlagW = 2'b11; NoWrite = 1'b1; end 
         end // CMN
         
         default: begin ALUControl = 2'bx; FlagW = 2'b00; NoWrite = 1'b0; end // unimplemented (eg ALUOp = 0)
         endcase
    end
    
    
    assign PCS = ((Rd == 4'b1111) & RegW) | Branch; 
    

    
    end 
endmodule