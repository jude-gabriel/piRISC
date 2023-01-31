`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2023 03:06:17 PM
// Design Name: 
// Module Name: alu_controller_tb
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


module alu_controller_tb;

// Widths for instruction and alu operation
parameter IWIDTH = 32;
parameter AWIDTH = 4;

// Instruction is the input, alu operation is the output
reg [IWIDTH-1:0]  instruction;
wire [AWIDTH-1:0] aluop;

alu_controller alu_c(instruction, aluop);

integer i;
initial 
    begin 
        
        
        /******** RTYPE TESTS ************/
        
        // Test RADD
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[30] = 0; instruction[11:7] = `RADD;
        #1
        if(aluop == `ALUADD)
            begin
                $display("RTYPE: ALU ADD Correct.");
            end 
        else 
            begin
                $display("RTYPE: ALU ADD Incorrect.");
            end 
           
        
    end 
endmodule
