`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2023 03:05:47 PM
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory(instructionOut, addressIn, clk, reset);

// Word depth and memeory depth 
parameter DWIDTH = 32;
parameter MEMDEPTH = 1024;
parameter AWIDTH = $clog2(MEMDEPTH);

// Instruction output
output reg [DWIDTH-1:0] instructionOut;

// Next address of the instruction 
input [DWIDTH-1:0] addressIn;

// Clock signal 
input clk; 
input reset;

// Memory block 
reg [DWIDTH-1:0] mem[0:MEMDEPTH-1];

//Initialize the instruction memeory 
always@(posedge reset)
    begin 
        $readmemb("instructions.mem", mem, 0, 1023);
    end 

always@(posedge clk)
    begin 
        instructionOut <= mem[addressIn[7:2]];
    end
endmodule
