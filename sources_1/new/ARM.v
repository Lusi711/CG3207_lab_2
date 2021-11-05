`timescale 1ns / 1ps
/*
----------------------------------------------------------------------------------
-- Company: NUS	
-- Engineer: (c) Shahzor Ahmad and Rajesh Panicker  
-- 
-- Create Date: 09/23/2015 06:49:10 PM
-- Module Name: ARM
-- Project Name: CG3207 Project
-- Target Devices: Nexys 4 (Artix 7 100T)
-- Tool Versions: Vivado 2015.2
-- Description: ARM Module
-- 
-- Dependencies: NIL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: The interface SHOULD NOT be modified. The implementation can be modified
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

//-- R15 is not stored
//-- Save waveform file and add it to the project
//-- Reset and launch simulation if you add interal signals to the waveform window

module ARM(
    input CLK,
    input RESET,
    //input Interrupt,  // for optional future use
    input [31:0] Instr,
    input [31:0] ReadData,
    output MemWrite,
    output [31:0] PC,
    output [31:0] ALUResult,
    output [31:0] WriteData
    );
    
    // RegFile signals
    //wire CLK ;
    wire WE3 ;
    wire [3:0] A1 ;
    wire [3:0] A2 ;
    wire [3:0] A3 ;
    wire [31:0] WD3 ;
    wire [31:0] R15 ;
    wire [31:0] RD1 ;
    wire [31:0] RD2 ;
    
    // Extend Module signals
    wire [1:0] ImmSrc ;
    wire [23:0] InstrImm ;
    wire [31:0] ExtImm ;
    
    // Decoder signals
    wire [3:0] Rd ;
    wire [1:0] Op ;
    wire [5:0] Funct ;
    wire [3:0] MulBits;
    wire MemtoReg ;
    wire ALUSrc ;
    wire [1:0] RegSrc ;
    
    // CondLogic signals
    //wire CLK ;
    wire PCS ;
    wire RegW ;
    wire NoWrite ;
    wire MemW ;
    wire [2:0] FlagW ;
    wire [3:0] Cond ;
    wire PCSrc ;
    wire RegWrite ; 
    //wire MemWrite
    wire C_Flag;
       
    // Shifter signals
    wire [1:0] Sh ;
    wire [4:0] Shamt5 ;
    wire [31:0] ShIn ;
    wire [31:0] ShOut ;
    wire shifter_carry_out;
    
    // ALU signals
    wire [31:0] Src_A ;
    wire [31:0] Src_B ;
    wire [3:0] ALUControl ;
    wire [31:0] ALUResultFromALU ;
    wire [3:0] ALUFlagsFromALU ;
    wire [3:0] ALUFlags;
    
    // MCycle signals
    wire Start;
    wire [1:0] MCycleOp; // "00" for signed multiplication, "01" for unsigned multiplication, 
                         // "10" for signed division, "11" for unsigned division
    wire [31:0] Operand1;
    wire [31:0] Operand2;
    wire Busy;
    wire [31:0] Result2; // Discarded MSB product or Quotient
    wire [31:0] ALUResultFromMCycle;
    wire [3:0] ALUFlagsFromMCycle;
    
    // ProgramCounter signals
    wire WE_PC ;    
    wire [31:0] PC_IN ;
        
    // Other internal signals here
    wire [31:0] PCPlus4 ;
    wire [31:0] PCPlus8 ;
    wire [31:0] Result ;
    
    // datapath connections here
    
    // CondLogic Logic
    assign Cond = Instr[31:28];
    
    // Decoder Logic
    assign Op = Instr[27:26];
    assign Funct = Instr[25:20];
    assign Rd = Instr[15:12];
    assign MulBits = Instr[7:4];
    
    //Extender Logic
    assign InstrImm = Instr[23:0];
    
    // Programme Counter Logic
    assign PCPlus4 = PC + 32'b100;
    assign PCPlus8 = PCPlus4 + 32'b100;
    assign PC_IN = (PCSrc == 1) ? Result : PCPlus4;    
    assign WE_PC = (Busy == 1) ? 0 : 1; // Will need to control it for multi-cycle operations (Multiplication, Division) and/or Pipelining with hazard hardware.

    // Register File Logic
    assign WE3 = RegWrite;
    assign A1 = (Start == 1) ? Instr[3:0] : (RegSrc[0] == 1) ? 4'b1111 : Instr[19:16];
    assign A2 = (Start == 1) ? Instr[11:8] : (RegSrc[1] == 1) ? Instr[15:12] : Instr[3:0];
    assign A3 = (Start == 1) ? Instr[19:16] : Instr[15:12];
    assign Result = (MemtoReg == 1) ? ReadData : ALUResult;
    assign WD3 = Result;
    assign R15 = PCPlus8;
    assign WriteData = RD2;
    
    //Shifter Logic
    assign ShIn = RD2;
    assign Shamt5 = Instr[11:7];
    assign Sh = Instr[6:5];
    
    // ALU Logic
    assign Src_A = RD1;
    assign Src_B = (ALUSrc == 1) ? ExtImm : ShOut;
    
    // MCycle Logic
    assign Operand1 = RD1;
    assign Operand2 = RD2;
    
    assign ALUResult = (Start == 0) ? ALUResultFromALU : ALUResultFromMCycle;
    assign ALUFlags = (Start == 0) ? ALUFlagsFromALU : ALUFlagsFromMCycle;
    // Instantiate RegFile
    RegFile RegFile1( 
                    CLK,
                    WE3,
                    A1,
                    A2,
                    A3,
                    WD3,
                    R15,
                    RD1,
                    RD2     
                );
                
     // Instantiate Extend Module
    Extend Extend1(
                    ImmSrc,
                    InstrImm,
                    ExtImm
                );
                
    // Instantiate Decoder
    Decoder Decoder1(
                    Rd,
                    Op,
                    Funct,
                    MulBits,
                    PCS,
                    RegW,
                    MemW,
                    MemtoReg,
                    ALUSrc,
                    ImmSrc,
                    RegSrc,
                    NoWrite,
                    ALUControl,
                    FlagW,
                    Start,
                    MCycleOp
                );
                                
    // Instantiate CondLogic
    CondLogic CondLogic1(
                    CLK,
                    PCS,
                    RegW,
                    NoWrite,
                    MemW,
                    FlagW,
                    Cond,
                    ALUFlags,
                    PCSrc,
                    RegWrite,
                    MemWrite,
                    C_Flag
                );
                
    // Instantiate Shifter        
    Shifter Shifter1(
                    Sh,
                    Shamt5,
                    ShIn,
                    C_Flag,
                    ShOut,
                    shifter_carry_out
                );
                
    // Instantiate ALU        
    ALU ALU1(
                    Src_A,
                    Src_B,
                    C_Flag,
                    shifter_carry_out,
                    ALUControl,
                    ALUResultFromALU,
                    ALUFlagsFromALU
                );                
    
    // Instantiate MCycle for Multiplication and Division
    MCycle Mcycle1(
                    CLK,
                    RESET, // Connect this to the reset of the ARM processor.
                    Start, // Multi-cycle Enable. The control unit should assert this when an instruction with a multi-cycle operation is detected.
                    MCycleOp, // Multi-cycle Operation. "00" for signed multiplication, "01" for unsigned multiplication, "10" for signed division, "11" for unsigned division. Generated by Control unit
                    Operand1, // Multiplicand / Dividend
                    Operand2, // Multiplier / Divisor
                    ALUResultFromMCycle, // LSW of Product / Quotient
                    Result2, // MSW of Product / Remainder
                    Busy,
                    ALUFlagsFromMCycle
    );
    
    // Instantiate ProgramCounter    
    ProgramCounter ProgramCounter1(
                    CLK,
                    RESET,
                    WE_PC,    
                    PC_IN,
                    PC  
                );                             
endmodule