`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2023 03:13:50 PM
// Design Name: 
// Module Name: instruction_memory_tb
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


module instruction_memory_tb;

parameter WIDTH = 32;

// Address input and instruction output 
reg [WIDTH-1:0] address;
wire [WIDTH-1:0] instructionOut;


// Clock signal
reg clk;
initial 
    begin 
        clk = 0;
        forever #10 clk = !clk;
    end 
    
// Reset signal
reg reset;

instruction_memory ir1(instructionOut, address, clk, reset);

initial 
    begin 
        #10 reset = 1;
        #20 reset = 0;
        #20 address = 32'h00000000;
        #20 address = 32'h00000001;
        #20 address = 32'h00000002;
        #10 $stop;
    end 
endmodule
