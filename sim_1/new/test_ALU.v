`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2021 14:47:06
// Design Name: 
// Module Name: test_ALU
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


module test_ALU(

    );
    
    // DECLARE INPUT SIGNALs
    reg [31:0] Src_A;
    reg [31:0] Src_B;
    reg C_Flag;
    reg shifter_carry_out;
    reg [3:0] ALUControl;
    
    // DECLARE OUTPUT SIGNALs
    wire [31:0] ALUResult;
    wire [3:0] ALUFlags;
    
    // INSTANTIATE DEVICE/UNIT UNDER TEST (DUT/UUT)
    ALU dut (Src_A, Src_B, C_Flag, shifter_carry_out, ALUControl, ALUResult, ALUFlags);
    
    //STIMULI
    initial begin
        // ADD / CMN
        Src_A = 32'hFFFFFFFF; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0; #20; // FFFFFFFF + FFFFFFFF = 1 FFFFFFFE
        Src_A = 32'h1; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0; #20; // 1 + FFFFFFFF = 1 00000000
        Src_A = 32'hFFFFFFFF; Src_B = 32'h1; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0; #20; // FFFFFFFF + 1 = 1 00000000
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b1; ALUControl = 4'b0; #20; // 0 + FFFFFFFF = 0 FFFFFFFF
        Src_A = 32'hFFFFFFFF; Src_B = 32'h0; C_Flag = 1'b1; shifter_carry_out = 1'b0; ALUControl = 4'b0; #20; // FFFFFFFF + 0 = 0 FFFFFFFF
        
        // ADC Rd, Rn, #Imm8_rot
        Src_A = 32'hFFFFFFFF; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0001; #20; // FFFFFFFF + FFFFFFFF + 0 = 1 FFFFFFFE
        Src_A = 32'h1; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0001; #20; // 1 + FFFFFFFF + 0 = 1 00000000
        Src_A = 32'hFFFFFFFF; Src_B = 32'h1; C_Flag = 1'b0; shifter_carry_out = 1'b1; ALUControl = 4'b0001; #20; // FFFFFFFF + 1 + 0 = 1 00000000
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0001; #20; // 0 + FFFFFFFF + 0 = FFFFFFFF
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b1; shifter_carry_out = 1'b0; ALUControl = 4'b0001; #20; // 0 + FFFFFFFF + 1 = 1 00000000
        Src_A = 32'hFFFFFFFF; Src_B = 32'h0; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0001; #20; // FFFFFFFF + 0 + 0 = FFFFFFFF
        Src_A = 32'hFFFFFFFF; Src_B = 32'h0; C_Flag = 1'b1; shifter_carry_out = 1'b0; ALUControl = 4'b0001; #20; // FFFFFFFF + 0 + 1 = 1 00000000
        
        // SUB / CMP
        Src_A = 32'hFFFFFFFF; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0010; #20; // FFFFFFFF - FFFFFFFF = 0
        Src_A = 32'h1; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0010; #20; // 1 - FFFFFFFF  = 0 00000002
        Src_A = 32'hFFFFFFFF; Src_B = 32'h1; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0010; #20; // FFFFFFFF - 1 = FFFF FFFE
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b1; ALUControl = 4'b0010; #20; // 0 - FFFFFFFF = 1 00000001
        Src_A = 32'hFFFFFFFF; Src_B = 32'h0; C_Flag = 1'b1; shifter_carry_out = 1'b0; ALUControl = 4'b0010; #20; // FFFFFFFF - 0 = FFFFFFFF
        
        // SBC
        Src_A = 32'hFFFFFFFF; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0011; #20; // FFFFFFFF - FFFFFFFF - 1 = 1 FFFFFFFF
        Src_A = 32'hFFFFFFFF; Src_B = 32'hFFFFFFFF; C_Flag = 1'b1; shifter_carry_out = 1'b0; ALUControl = 4'b0011; #20; // FFFFFFFF - FFFFFFFF - 0 = 0
        Src_A = 32'h1; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0011; #20; // 1 - FFFFFFFF - 1 = 0 00000001
        Src_A = 32'hFFFFFFFF; Src_B = 32'h1; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0011; #20; // FFFFFFFF - 1 - 1 = FFFF FFFD
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0011; #20; // 0 - FFFFFFFF - 1 = 1 00000000
        Src_A = 32'hFFFFFFFF; Src_B = 32'h0; C_Flag = 1'b0; shifter_carry_out = 1'b1; ALUControl = 4'b0011; #20; // FFFFFFFF - 0 - 1 = FFFFFFFE
        
        // AND / TST
        Src_A = 32'hFFFFFFFF; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0100; #20; // FFFFFFFF & FFFFFFFF = FFFFFFFF
        Src_A = 32'h1; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0100; #20; // 1 & FFFFFFFF = 1
        Src_A = 32'hFFFFFFFF; Src_B = 32'h1; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0100; #20; // FFFFFFFF & 1 = 1
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0100; #20; // 0 & FFFFFFFF = 0
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b1; ALUControl = 4'b0100; #20; // 0 & FFFFFFFF = 0
        Src_A = 32'hFFFFFFFF; Src_B = 32'h0; C_Flag = 1'b1; shifter_carry_out = 1'b0; ALUControl = 4'b0100; #20; // FFFFFFFF & 0 = 0
        
        // BIC
        Src_A = 32'hFFFFFFFF; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0101; #20; // FFFFFFFF & ¬FFFFFFFF = 0
        Src_A = 32'h1; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0101; #20; // 1 & ~FFFFFFFF = 0
        Src_A = 32'hFFFFFFFF; Src_B = 32'h1; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0101; #20; // FFFFFFFF & ~1 = FFFFFFFE
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0101; #20; // 0 & ~FFFFFFFF = 0
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b1; ALUControl = 4'b0101; #20; // 0 & ~FFFFFFFF = 0
        Src_A = 32'hFFFFFFFF; Src_B = 32'h0; C_Flag = 1'b1; shifter_carry_out = 1'b0; ALUControl = 4'b0101; #20; // FFFFFFFF & ~0 = FFFFFFFF
        
        // ORR
        Src_A = 32'hFFFFFFFF; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0110; #20; // FFFFFFFF | FFFFFFFF = FFFFFFFF
        Src_A = 32'h1; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0110; #20; // 1 | FFFFFFFF  = FFFFFFFF
        Src_A = 32'hFFFFFFFF; Src_B = 32'h1; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0110; #20; // FFFFFFFF | 1 = FFFFFFFF
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b0110; #20; // 0 | FFFFFFFF = FFFFFFFF
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b1; ALUControl = 4'b0110; #20; // 0 | FFFFFFFF = FFFFFFFF
        Src_A = 32'hFFFFFFFF; Src_B = 32'h0; C_Flag = 1'b1; shifter_carry_out = 1'b0; ALUControl = 4'b0110; #20; // FFFFFFFF | 0 = FFFFFFFF
        
        // RSB
        Src_A = 32'hFFFFFFFF; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1000; #20; // FFFFFFFF - FFFFFFFF = 0
        Src_A = 32'h1; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1000; #20; // 1 - FFFFFFFF = 1 00000002
        Src_A = 32'hFFFFFFFF; Src_B = 32'h1; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1000; #20; // FFFFFFFF - 1 = FFFFFFFE
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1000; #20; // 0 - FFFFFFFFF = 1 00000001
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b1; ALUControl = 4'b1000; #20;
        Src_A = 32'hFFFFFFFF; Src_B = 32'h0; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1000; #20; // FFFFFFFF - 0 = FFFFFFFFF
        Src_A = 32'hFFFFFFFF; Src_B = 32'h0; C_Flag = 1'b1; shifter_carry_out = 1'b0; ALUControl = 4'b1000; #20; // FFFFFFFF - 0 = FFFFFFFFF
        
        // RSC
        Src_A = 32'hFFFFFFFF; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1001; #20; // FFFFFFFF - FFFFFFFF - 1 = 1 FFFFFFFF
        Src_A = 32'hFFFFFFFF; Src_B = 32'hFFFFFFFF; C_Flag = 1'b1; shifter_carry_out = 1'b0; ALUControl = 4'b1001; #20; // FFFFFFFF - FFFFFFFFF - 0 = 0
        Src_A = 32'h1; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1001; #20; // FFFFFFFF - 1 - 1 = FFFFFFFD
        Src_A = 32'hFFFFFFFF; Src_B = 32'h1; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1001; #20; // 1 - FFFFFFFF - 1 = 1 00000001
        Src_A = 32'hFFFFFFFF; Src_B = 32'h1; C_Flag = 1'b1; shifter_carry_out = 1'b0; ALUControl = 4'b1001; #20; // 1 - FFFFFFFF - 0 = 0 00000010
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1001; #20; // FFFFFFFFF - 0 - 1 = FFFFFFFFE
        Src_A = 32'hFFFFFFFF; Src_B = 32'h0; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1001; #20; // 0 - FFFFFFFF - 1 = 1 00000000
        Src_A = 32'hFFFFFFFF; Src_B = 32'h0; C_Flag = 1'b0; shifter_carry_out = 1'b1; ALUControl = 4'b1001; #20; // 0 - FFFFFFFF - 1 = 1 00000000
        
        // EOR / TEQ
        Src_A = 32'hFFFFFFFF; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1010; #20; // FFFFFFFF ^ FFFFFFFF = 0
        Src_A = 32'h1; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1010; #20; // 1 ^ FFFFFFFF  = FFFFFFFE
        Src_A = 32'hFFFFFFFF; Src_B = 32'h1; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1010; #20; // FFFFFFFF ^ 1 = FFFFFFFE
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1010; #20; // 0 ^ FFFFFFFF = FFFFFFFF
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b1; ALUControl = 4'b1010; #20; // 0 ^ FFFFFFFF = FFFFFFFF
        Src_A = 32'hFFFFFFFF; Src_B = 32'h0; C_Flag = 1'b1; shifter_carry_out = 1'b0; ALUControl = 4'b1010; #20; // FFFFFFFF ^ 0 = FFFFFFFF
        
        // MOV
        Src_A = 32'hFFFFFFFF; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1100; #20; // FFFFFFFF
        Src_A = 32'h1; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1100; #20; // FFFFFFFF
        Src_A = 32'hFFFFFFFF; Src_B = 32'h1; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1100; #20; // 1
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1100; #20; // FFFFFFFF
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b1; ALUControl = 4'b1100; #20; // FFFFFFFF
        Src_A = 32'hFFFFFFFF; Src_B = 32'h0; C_Flag = 1'b1; shifter_carry_out = 1'b0; ALUControl = 4'b1100; #20; // 0
        
        // MVN
        Src_A = 32'hFFFFFFFF; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1101; #20; // ~FFFFFFFF = 0
        Src_A = 32'h1; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1101; #20; // ~FFFFFFFF = 0
        Src_A = 32'hFFFFFFFF; Src_B = 32'h1; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1101; #20; // ~1 = FFFFFFFE
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b0; ALUControl = 4'b1101; #20; // ~FFFFFFFFF = 0
        Src_A = 32'h0; Src_B = 32'hFFFFFFFF; C_Flag = 1'b0; shifter_carry_out = 1'b1; ALUControl = 4'b1101; #20; // ~FFFFFFFF = 0
        Src_A = 32'hFFFFFFFF; Src_B = 32'h0; C_Flag = 1'b1; shifter_carry_out = 1'b0; ALUControl = 4'b1101; #20; // ~0 = FFFFFFFF
        
        // End Operation
        Src_A = 0; Src_B = 0; C_Flag = 0; ALUControl = 0;    
    end
    
endmodule
