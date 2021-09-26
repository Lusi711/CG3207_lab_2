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
    wire PCS, RegW, MemW, MemtoReg, ALUSrc;
    wire [1:0] ImmSrc;
    wire [1:0] RegSrc;
    wire NoWrite;
    wire [1:0] ALUControl;
    wire [1:0] FlagW;
    
    Decoder dut (Rd, Op, Funct, PCS, RegW, MemW, MemtoReg, ALUSrc, ImmSrc, RegSrc, NoWrite, ALUControl, FlagW);
    
    initial begin
        // LDR with +ve immediate offset
        Rd = 4'b0000; Op = 2'b01; Funct = 6'b0x10x1; #20;
        // STR with +ve immediate offset
        Rd = 4'b0001; Op = 2'b01; Funct = 6'b0x10x0; #20;
        // Add Imm 
        Rd = 4'b0010; Op = 2'b00; Funct = 6'b101000; #20;
        // Sub Reg
        Rd = 4'b0011; Op = 2'b00; Funct = 6'b000100; #50;
        // B
        Rd = 4'b0100; Op = 2'b10; Funct = 6'b10xxxx; #50;
        // CMP
        Rd = 4'b0101; Op = 2'b00; Funct = 6'b110101; #50;
        // CMN
        Rd = 4'b0110; Op = 2'b00; Funct = 6'b110111; #50;
    end
        
endmodule