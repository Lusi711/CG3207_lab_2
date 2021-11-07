`timescale 1ns / 1ps
/*
----------------------------------------------------------------------------------
-- Company: NUS	
-- Engineer: (c) Shahzor Ahmad and Rajesh Panicker
-- 
-- Create Date: 09/23/2015 06:49:10 PM
-- Module Name: Shifter
-- Project Name: CG3207 Project
-- Target Devices: Nexys 4 (Artix 7 100T)
-- Tool Versions: Vivado 2015.2
-- Description: Shifter Module
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

module Shifter(
    input [1:0] ShOp,
    input [1:0] Sh,
    input [4:0] Shamt5,
    input [31:0] ShIn,
    input C_Flag,
    output [31:0] ShOut,
    output shifter_carry_out
    );
    
    reg [1:0] sh;
    reg [4:0] shamt5;
    
    wire [31:0] ShTemp0 ;
    wire [31:0] ShTemp1 ;
    wire [31:0] ShTemp2 ;
    wire [31:0] ShTemp3 ;
    wire [31:0] ShTemp4 ;
    
    reg shifterTempCarryIn;
    wire shifterTempCarryOut1;
    wire shifterTempCarryOut2;
    wire shifterTempCarryOut3;
    wire shifterTempCarryOut4;
    
    assign ShTemp0 = ShIn;
                    
    always@(ShOp, Sh, Shamt5, C_Flag, ShIn, sh, shamt5, shifterTempCarryIn) begin
        if (ShOp == 2'b00) 
        begin
            sh <= 2'b11;
            shamt5 <= { Shamt5[4:1], 1'b0 };
            shifterTempCarryIn <= ShIn[0];
        end else if (ShOp == 2'b01)
        begin
            sh <= Sh;
            shamt5 <= Shamt5 ;
            case(Sh)
                2'b00: shifterTempCarryIn <= C_Flag;
                2'b01: shifterTempCarryIn <= ShIn[31];
                2'b10: shifterTempCarryIn <= ShIn[31];
                2'b11: shifterTempCarryIn <= ShIn[0];
            endcase
        end else 
        begin
            sh <= 2'b00 ;
            shamt5 <= 5'b0 ;
            shifterTempCarryIn <= C_Flag;
        end
	end
	
    shiftByNPowerOf2#(0) shiftBy0PowerOf2( sh, shamt5[0], ShTemp0, shifterTempCarryIn, ShTemp1, shifterTempCarryOut1) ;
    shiftByNPowerOf2#(1) shiftBy1PowerOf2( sh, shamt5[1], ShTemp1, shifterTempCarryOut1, ShTemp2, shifterTempCarryOut2) ;
    shiftByNPowerOf2#(2) shiftBy2PowerOf2( sh, shamt5[2], ShTemp2, shifterTempCarryOut2, ShTemp3, shifterTempCarryOut3 ) ;
    shiftByNPowerOf2#(3) shiftBy3PowerOf2( sh, shamt5[3], ShTemp3, shifterTempCarryOut3, ShTemp4, shifterTempCarryOut4 ) ;
    shiftByNPowerOf2#(4) shiftBy4PowerOf2( sh, shamt5[4], ShTemp4, shifterTempCarryOut4, ShOut, shifter_carry_out ) ;
	
endmodule


module shiftByNPowerOf2
//module Shifter
    #(parameter i = 0) // exponent
    (   
        input [1:0] Sh,
        input flagShift,
        input [31:0] ShTempIn,
        input shifterTempCarryIn,
        output reg [31:0] ShTempOut,
        output reg shifterTempCarryOut
    ) ;
    
    always@(Sh, ShTempIn, flagShift, shifterTempCarryIn, ShTempOut, shifterTempCarryOut) begin
        if(flagShift)
            case(Sh)
                2'b00: begin
                    ShTempOut <= { ShTempIn[31-2**i:0], {2**i{1'b0}} } ; // LSL
                    shifterTempCarryOut <= ShTempIn[32 - 2**i];
                end
                2'b01: begin
                    ShTempOut <= { {2**i{1'b0}}, ShTempIn[31:2**i] } ; // LSR
                    shifterTempCarryOut <= ShTempIn[2**i - 1];
                end
                2'b10: begin
                    ShTempOut <= { {2**i{ShTempIn[31]}}, ShTempIn[31:2**i] } ; // ASR
                    shifterTempCarryOut <= ShTempIn[2**i - 1];
                end
                2'b11: begin
                    ShTempOut <= { ShTempIn[2**i-1:0], ShTempIn[31:2**i] } ; // ROR
                    shifterTempCarryOut <= ShTempIn[2**i - 1];
                end
            endcase   
        else begin
            ShTempOut <= ShTempIn ;
            shifterTempCarryOut <= shifterTempCarryIn;
        end
    end
    
endmodule