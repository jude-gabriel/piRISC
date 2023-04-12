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


module instruction_memory(instructionOut, enable, addressIn, clk, reset);

// Word depth and memeory depth 
parameter DWIDTH = 32;
parameter MEMDEPTH = 1024;
parameter AWIDTH = $clog2(MEMDEPTH);

// Instruction output
output reg [DWIDTH-1:0] instructionOut;

// Next address of the instruction 
input [DWIDTH-1:0] addressIn;

// Enable signal
input enable;

// Clock signal 
input clk; 
input reset;

// Memory block 
reg [DWIDTH-1:0] mem[0:MEMDEPTH-1];

//Initialize the instruction memeory 
initial
    begin 
        //$readmemb("instructions.mem", mem, 0, 1023);
      mem[0] <= 32'b00000000111000000000000010010011;
      mem[1] <= 32'b00000000000100000000000100010011;
      mem[2] <= 32'b00000000000100000000000110010011;
      mem[3] <= 32'b00000000000100000000001100010011;
      mem[4] <= 32'b00000010000100000000010001100011;
      mem[5] <= 32'b00000000001100010000001000110011;
      mem[6] <= 32'b00000000001100000000000100110011;
      mem[7] <= 32'b00000000010000000000000110110011;
      mem[8] <= 32'b01000000011000001000000010110011;
      mem[9] <= 32'b00000001000000000000001011100111;
      mem[10] <= 32'b00000000001100000010000000100011;
    end 

always@(posedge clk)
    begin 
        if(enable)
            instructionOut <= mem[addressIn[31:2]];
    end
endmodule
