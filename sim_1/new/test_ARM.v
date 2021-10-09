`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.09.2021 10:04:19
// Design Name: 
// Module Name: test_CondLogic
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
    reg CLK = 0;
    reg RESET = 0;
    //reg Interrupt;  // for optional future use
    reg [31:0] Instr = 32'b0;
    reg [31:0] ReadData = 32'b0;
    wire MemWrite;
    wire [31:0] PC;
    wire [31:0] ALUResult;
    wire [31:0] WriteData;
    
    
    ARM dut(CLK, RESET, Instr, ReadData, MemWrite, PC, ALUResult, WriteData);
    

    initial 
    begin
        RESET = 1; #50; RESET = 0; //hold reset state for 10 ns.
        // STR Imm
        Instr = 32'b11100101100000100001000000001100; // STR R3, [R2, #c]
        ReadData = 32'b00011010;
        #50;
        // LDR Imm
        Instr = 32'b11100101100100100011000000001000; // LDR R3, [R2, #8]
        ReadData = 32'b00000010;
        #50;
        //Add 
        Instr = 32'b11100010100001000101000000000100; // Add R5, R4, #4
        #50;
        // Subs
        Instr = 32'b11100010010100110010111011111111; // SUBS R2, R3, #0xFF0;
        #50;
        Instr = 32'hE2544001;
        #50;
        Instr = 32'hE2544001;
        #50;
        Instr = 32'hE2544001;
        #50;
        Instr = 32'hE2544001;
        #50;
        Instr = 32'h1AFFFFFD;
        #50;
        Instr = 32'hE59F4200;
        ReadData = 32'h4;
    end
    
    // GENERATE CLOCK       
    always          
    begin
       #25 CLK = ~CLK ; // invert clk every 5 time units 
    end

endmodule


