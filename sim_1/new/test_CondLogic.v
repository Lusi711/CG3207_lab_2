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
    
    // DECLARE INPUT SIGNALS
    reg CLK, PCS, RegW, NoWrite, MemW;
    reg [2:0] FlagW;
    reg [3:0] Cond;
    reg [3:0] ALUFlags;
    
    // DECLARE OUTPUT SIGNALS
    wire PCSrc, RegWrite, MemWrite, C_Flag;
    
    // Instantiate UUT
    CondLogic dut(CLK, PCS, RegW, NoWrite, MemW, FlagW, Cond, ALUFlags, PCSrc, RegWrite, MemWrite, C_Flag);
    
    // STIMULI
    initial begin
        CLK = 0;
        // ADD/ADC/SUB/SBC/AND/BIC/ORR/RSB/RSC/MUL/MLA(DIV)
        MemW = 0; RegW = 1; FlagW = 3'b000; NoWrite = 0; PCS = 0; Cond = 4'b1110; ALUFlags = 4'b1010; #20;
        // CMP/CMN
        MemW = 0; RegW = 1; FlagW = 3'b111; NoWrite = 1; PCS = 0; Cond = 4'b1110; ALUFlags = 4'b1010; #20;
        // TST/TEQ
        MemW = 0; RegW = 1; FlagW = 3'b111; NoWrite = 1; PCS = 0; Cond = 4'b1110; ALUFlags = 4'b0000; #20;
        
        // ADDS/ADCS/SUBS/SBCS/RSBS/RSCS
        MemW = 0; RegW = 1; FlagW = 3'b111; NoWrite = 0; PCS = 0; Cond = 4'b1110; ALUFlags = 4'b0101; #20;
        // ANDS/BICS/ORRS/EORS
        MemW = 0; RegW = 1; FlagW = 3'b110; NoWrite = 0; PCS = 0; Cond = 4'b1110; ALUFlags = 4'b1010; #20;
        // MULS
        MemW = 0; RegW = 1; FlagW = 3'b100; NoWrite = 0; PCS = 0; Cond = 4'b1110; ALUFlags = 4'b0000; #20;
        
        //LDR
        MemW = 0; RegW = 1; FlagW = 3'b000; NoWrite = 0; PCS = 0; Cond = 4'b1110; ALUFlags = 4'b0000; #20;
        //STR
        MemW = 1; RegW = 0; FlagW = 3'b000; NoWrite = 0; PCS = 0; Cond = 4'b1110; ALUFlags = 4'b0000; #20;
        
        // B
        MemW = 0; RegW = 0; FlagW = 3'b000; NoWrite = 0; PCS = 1; Cond = 4'b1110; ALUFlags = 4'b0000; #20;
        
        // [OP]EQ
        MemW = 1'bx; RegW = 1'bx; FlagW = 3'b000; NoWrite = 0; PCS = 1'bx; Cond = 4'b0000; ALUFlags = 4'b0000; #20;
        // [OP]NE
        MemW = 1'bx; RegW = 1'bx; FlagW = 3'b000; NoWrite = 0; PCS = 1'bx; Cond = 4'b0001; ALUFlags = 4'b0000; #20;
        // [OP]CS/HS
        MemW = 1'bx; RegW = 1'bx; FlagW = 3'b000; NoWrite = 0; PCS = 1'bx; Cond = 4'b0010; ALUFlags = 4'b0000; #20;
        // [OP]CC/LO
        MemW = 1'bx; RegW = 1'bx; FlagW = 3'b000; NoWrite = 0; PCS = 1'bx; Cond = 4'b0011; ALUFlags = 4'b0000; #20;
        // [OP]MI
        MemW = 1'bx; RegW = 1'bx; FlagW = 3'b000; NoWrite = 0; PCS = 1'bx; Cond = 4'b0100; ALUFlags = 4'b0000; #20;
        // [OP]PL
        MemW = 1'bx; RegW = 1'bx; FlagW = 3'b000; NoWrite = 0; PCS = 1'bx; Cond = 4'b0101; ALUFlags = 4'b0000; #20;
        // [OP]VS
        MemW = 1'bx; RegW = 1'bx; FlagW = 3'b000; NoWrite = 0; PCS = 1'bx; Cond = 4'b0110; ALUFlags = 4'b0000; #20;
        // [OP]VC
        MemW = 1'bx; RegW = 1'bx; FlagW = 3'b000; NoWrite = 0; PCS = 1'bx; Cond = 4'b0111; ALUFlags = 4'b0000; #20;
        // [OP]HI
        MemW = 1'bx; RegW = 1'bx; FlagW = 3'b000; NoWrite = 0; PCS = 1'bx; Cond = 4'b1000; ALUFlags = 4'b0000; #20;
        // [OP]LS
        MemW = 1'bx; RegW = 1'bx; FlagW = 3'b000; NoWrite = 0; PCS = 1'bx; Cond = 4'b1001; ALUFlags = 4'b0000; #20;
        // [OP]GE
        MemW = 1'bx; RegW = 1'bx; FlagW = 3'b000; NoWrite = 0; PCS = 1'bx; Cond = 4'b1010; ALUFlags = 4'b0000; #20;
        // [OP]LT
        MemW = 1'bx; RegW = 1'bx; FlagW = 3'b000; NoWrite = 0; PCS = 1'bx; Cond = 4'b1011; ALUFlags = 4'b0000; #20;
        // [OP]GT
        MemW = 1'bx; RegW = 1'bx; FlagW = 3'b000; NoWrite = 0; PCS = 1'bx; Cond = 4'b1100; ALUFlags = 4'b0000; #20;
        // [OP]LE
        MemW = 1'bx; RegW = 1'bx; FlagW = 3'b000; NoWrite = 0; PCS = 1'bx; Cond = 4'b1101; ALUFlags = 4'b0000; #20;
        
        // End of operation
        MemW = 0; RegW = 0; FlagW = 3'b000; NoWrite = 0; PCS = 0; Cond = 4'b0000; ALUFlags = 4'b0000;
    end
    
    // GENERATE CLOCK       
    always          
    begin
       #5 CLK = ~CLK ; // invert clk every 5 time units 
    end
    
endmodule