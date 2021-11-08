`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2021 10:20:40
// Design Name: 
// Module Name: test_Shifter
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


module test_Shifter(

    );
    
    // DECLARE INPUT SIGNALS
    reg [1:0] ShOp;
    reg [1:0] Sh;
    reg [4:0] Shamt5;
    reg [31:0] ShIn;
    
    // DECLARE OUTPUT SIGNALS
    wire [31:0] ShOut;
    wire shifter_carry_out;
    
    // INSTANTIATE DEVICE/UNIT UNDER TEST (DUT/UUT)
    Shifter dut(ShOp, Sh, Shamt5, ShIn, ShOut, shifter_carry_out);
    
    // STIMULI
    initial begin
        // DP Rd, Rn, #0FF0
        ShOp = 2'b00; Sh = 2'b11; Shamt5 = 5'b11100; ShIn = 32'hFF; #20;
        // DP Rd, Rn, Rm, LSL #2
        ShOp = 2'b01; Sh = 2'b00; Shamt5 = 5'b00010; ShIn = 32'hFFFFFFFF; #20;
        ShOp = 2'b01; Sh = 2'b00; Shamt5 = 5'b00010; ShIn = 32'h0; #20;
        ShOp = 2'b01; Sh = 2'b00; Shamt5 = 5'b00010; ShIn = 32'h1; #20;
        // DP Rd, Rn, Rm, LSR #2
        ShOp = 2'b01; Sh = 2'b01; Shamt5 = 5'b00010; ShIn = 32'hFFFFFFFF; #20;
        ShOp = 2'b01; Sh = 2'b01; Shamt5 = 5'b00010; ShIn = 32'h0; #20;
        ShOp = 2'b01; Sh = 2'b01; Shamt5 = 5'b00010; ShIn = 32'h1; #20;
        // DP Rd, Rn, Rm, ASR #2
        ShOp = 2'b01; Sh = 2'b10; Shamt5 = 5'b00010; ShIn = 32'hFFFFFFFF; #20;
        ShOp = 2'b01; Sh = 2'b10; Shamt5 = 5'b00010; ShIn = 32'h0; #20;
        ShOp = 2'b01; Sh = 2'b10; Shamt5 = 5'b00010; ShIn = 32'h1; #20;
        // DP Rd, Rn, Rm, ROR #2
        ShOp = 2'b01; Sh = 2'b11; Shamt5 = 5'b00010; ShIn = 32'hFFFFFFFF; #20;
        ShOp = 2'b01; Sh = 2'b11; Shamt5 = 5'b00010; ShIn = 32'h0; #20;
        ShOp = 2'b01; Sh = 2'b11; Shamt5 = 5'b00010; ShIn = 32'h1; #20;
        
        // MUL/MLA(DIV) Rd, Rm, Rs
        ShOp = 2'b1X; Sh = 2'b00; Shamt5 = 5'b0; ShIn = 32'hFFFFFFFF; #20;
        ShOp = 2'b1X; Sh = 2'b00; Shamt5 = 5'b0; ShIn = 32'h0; #20;
        ShOp = 2'b1X; Sh = 2'b00; Shamt5 = 5'b0; ShIn = 32'h1; #20;
        
        // LDR/STR Rd, [Rn, #Imm12]
        ShOp = 2'b10; Sh = 2'b00; Shamt5 = 5'b0; ShIn = 32'h1A; #20;
        
        // B #-6
        ShOp = 2'b1X; Sh = 2'b11; Shamt5 = 5'b0; ShIn = 32'hFFFFFFE8; #20;
        
        //End of operation
        ShOp = 2'b00; Sh = 2'b00; Shamt5 = 5'b00000; ShIn = 32'h0;
     end
endmodule
