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


module test_CondLogic(

    );
    
    reg CLK, PCS, RegW, NoWrite, MemW;
    reg [1:0] FlagW;
    reg [3:0] Cond;
    reg [3:0] ALUFlags;
    wire PCSrc, RegWrite, MemWrite, C_Flag;
    
    // Instantiate UUT
    CondLogic dut(CLK, PCS, RegW, NoWrite, MemW, FlagW, Cond, ALUFlags, PCSrc, RegWrite, MemWrite, C_Flag);
    
    // STIMULI
    initial
    begin
        CLK = 0;
        //LDR with immediate offset:
        MemW = 0; RegW = 1; FlagW = 2'b00; NoWrite = 0; PCS = 0; 
        Cond = 4'b1110; ALUFlags = 4'bxxxx;
        #20;
        //LDR with immediate offset, PC written
        MemW = 0; RegW = 1; FlagW = 2'b00; NoWrite = 0; PCS = 1; 
        Cond = 4'b1110; ALUFlags = 4'bxxxx;
        #20;
        //STR with immediate offset
        MemW = 1; RegW = 0; FlagW = 2'b00; NoWrite = 0; PCS = 0; 
        Cond = 4'b1110; ALUFlags = 4'bxxxx;
        #20;
        //AND,OR,ADD,SUB with Src2 is register, PC not written
        MemW = 0; RegW = 1; FlagW = 2'b00; NoWrite = 0; PCS = 0; 
        Cond = 4'b1110; ALUFlags = 4'bxxxx;
        #20;
        //AND,OR,ADD,SUB with Src2 is register, PC Written
        MemW = 0; RegW = 1; FlagW = 2'b00; NoWrite = 0; PCS = 1; 
        Cond = 4'b1110; ALUFlags = 4'bxxxx;
        #20;
        //AND,OR,ADD,SUB with Src2 is immediate, PC not written
        MemW = 0; RegW = 1; FlagW = 2'b00; NoWrite = 0; PCS = 0; 
        Cond = 4'b1110; ALUFlags = 4'bxxxx;
        #20;
        //AND,OR,ADD,SUB with Src2 is immediate, PC not written
        MemW = 0; RegW = 1; FlagW = 2'b00; NoWrite = 0; PCS = 1; 
        Cond = 4'b1110; ALUFlags = 4'bxxxx;
        #20;
        //B
        MemW = 0; RegW = 0; FlagW = 2'b00; NoWrite = 0; PCS = 1;
        Cond = 4'b1110; ALUFlags = 4'bxxxx;
        #20;
        // CMP, CMN
        MemW = 0; RegW = 1; FlagW = 2'b11; NoWrite = 1; PCS = 0;
        Cond = 4'b1110; ALUFlags = 4'b0001;
        #20;
        MemW = 0; RegW = 1; FlagW = 2'b11; NoWrite = 1; PCS = 0;
        Cond = 4'b1110; ALUFlags = 4'b0010;
        #20;
        MemW = 0; RegW = 1; FlagW = 2'b11; NoWrite = 1; PCS = 0;
        Cond = 4'b1110; ALUFlags = 4'b0100;
        #20;
        MemW = 0; RegW = 1; FlagW = 2'b11; NoWrite = 1; PCS = 0;
        Cond = 4'b1110; ALUFlags = 4'b1000;
        #20;
        
        
    end
    
    // GENERATE CLOCK       
    always          
    begin
       #5 CLK = ~CLK ; // invert clk every 5 time units 
    end
    
endmodule