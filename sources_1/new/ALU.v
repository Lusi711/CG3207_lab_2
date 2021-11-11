`timescale 1ns / 1ps
/*
----------------------------------------------------------------------------------
-- Company: NUS
-- Engineer: (c) Shahzor Ahmad and Rajesh Panicker  
-- 
-- Create Date:   21:06:18 24/09/2015
-- Design Name: 	ALU
-- Target Devices: Nexys 4 (Artix 7 100T)
-- Tool versions: Vivado 2015.2
-- Description: ALU Module
--
-- Dependencies:
--
-- Revision: 
-- Revision 0.01
-- Additional Comments: 
----------------------------------------------------------------------------------
--	License terms :
--	You are free to use this code as long as you
--		(i) DO NOT post it on any public repository;
--		(ii) use it only for educational purposes;
--		(iii) accept the responsibility to ensure that your implementation does not violate any intellectual property of ARM Holdings or other entities.
--		(iv) accept that the program is provided "as is" without warranty of any kind or assurance regarding its suitability for any particular purpose;
--		(v) send an email to rajesh.panicker@ieee.org briefly mentioning its use (except when used for the course CG3207 at the National University of Singapore);
--		(vi) retain this notice in this file or any files derived from this.
----------------------------------------------------------------------------------
*/

module ALU(
    input [31:0] Src_A,
    input [31:0] Src_B,
    input C_Flag,
    input shifter_carry_out,
    input [3:0] ALUControl,
    output [31:0] ALUResult,
    output [3:0] ALUFlags
    );
    
    wire [32:0] S_wider ;
    reg [32:0] Src_A_comp ;
    reg [32:0] Src_B_comp ;
    reg [31:0] ALUResult_i ;
    reg [32:0] C_0 ;
    wire N, Z;
    reg C, V ;
    
    assign S_wider = Src_A_comp + Src_B_comp + C_0 ;
    
    always@(Src_A, Src_B, C_Flag, shifter_carry_out, ALUControl, S_wider) 
    begin 
		// default values; help avoid latches
        C_0 <= 0 ; 
        Src_A_comp <= {1'b0, Src_A} ;
        Src_B_comp <= {1'b0, Src_B} ;
        ALUResult_i <= Src_B ;
        C <= S_wider[32] ;
        V <= 0 ;
    
        case(ALUControl)
            // ADD / CMN
            4'b0000:  
            begin
                ALUResult_i <= S_wider[31:0] ;
                V <= ( Src_A[31] ~^ Src_B[31] ) & ( Src_B[31] ^ S_wider[31] );          
            end
            // ADC
            4'b0001:  
            begin
                C_0 <= C_Flag;
                ALUResult_i <= S_wider[31:0] ;
                V <= ( Src_A[31] ~^ Src_B[31] ) & ( Src_B[31] ^ S_wider[31] );          
            end
            // SUB / CMP
            4'b0010:  
            begin
                C_0[0] <= 1;  
                Src_B_comp <= {1'b0, ~ Src_B} ;
                ALUResult_i <= S_wider[31:0] ;
                V <= ( Src_A[31] ^ Src_B[31] ) & ( Src_B[31] ~^ S_wider[31] );       
            end
            // SBC
            4'b0011:  
            begin
                C_0[0] <= C_Flag ;  
                Src_B_comp <= {1'b0, ~ Src_B} ;
                ALUResult_i <= S_wider[31:0] ;
                V <= ( Src_A[31] ^ Src_B[31] ) & ( Src_B[31] ~^ S_wider[31] );     
            end
            // AND / TST
            4'b0100: 
            begin
                ALUResult_i <= Src_A & Src_B ;
                C <= shifter_carry_out;
            end
            // BIC
            4'b0101: 
            begin
                ALUResult_i <= Src_A & (~Src_B);
                C <= shifter_carry_out;
            end
            // ORR
            4'b0110: 
            begin
                ALUResult_i <= Src_A | Src_B ; 
                C <= shifter_carry_out;
            end
            // RSB
            4'b1000: 
            begin
                C_0[0] <= 1 ;  
                Src_A_comp <= {1'b0, Src_B};
                Src_B_comp <= {1'b0, ~Src_A};
                ALUResult_i <= S_wider[31:0];
                V <= ( Src_B[31] ^ Src_A[31] ) & ( Src_A[31] ~^ S_wider[31] );
            end
            // RSC
            4'b1001:
            begin
                C_0[0] <= C_Flag;
                Src_A_comp <= {1'b0, Src_B};
                Src_B_comp <= {1'b0, ~Src_A};
                ALUResult_i <= S_wider[31:0];
                V <= ( Src_B[31] ^ Src_A[31] ) & ( Src_A[31] ~^ S_wider[31] );
            end
            // EOR / TEQ
            4'b1010: 
            begin
                ALUResult_i <= Src_A ^ Src_B;
                C <= shifter_carry_out;
            end
            // MOV
            4'b1100: 
            begin
                ALUResult_i <= Src_B;
                C <= shifter_carry_out;
            end
            // MVN
            4'b1101: begin
                ALUResult_i <= ~Src_B;
                C <= shifter_carry_out;
            end
        endcase ;
    end
    
    assign N = ALUResult_i[31] ;
    assign Z = (ALUResult_i == 0) ? 1 : 0 ;
    
    assign ALUResult = ALUResult_i ;
    assign ALUFlags = {N, Z, C, V} ;
        
endmodule