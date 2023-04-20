`timescale 1ns / 1ns

module core(irOut, clk, reset, go_contr);

parameter WIDTH = 32;


// Sys Inputs
input clk;      // Clock signal
input reset;    // Reset signal
input go_contr; // Go signal for core

// Sys outputs 
output wire [WIDTH-1:0] irOut;


// Data Path Outputs
wire                comp;

wire [6:0]          func7;
wire [2:0]          func3;
wire [6:0]          opcode;
assign func7        = irOut[31:25];
assign func3        = irOut[14:12];
assign opcode       = irOut[6:0];


// Controller Outputs
wire        irEn;
wire        pcEn;
wire [1:0]  pc_select;
wire        aluSrc;
wire        regWrite;
wire [1:0]  memToReg;
wire        isByte;
wire        isHalf;
wire        isWord;
wire        memRead;
wire        memWrite;


// Controller 
controller contr(irEn, pcEn, pc_select, aluSrc, regWrite, memToReg, isByte, isHalf, isWord, memRead, memWrite, func7, func3, opcode, comp, go_contr, clk, reset);


// Data Path
Data_path dp(clk, reset, irEn, pcEn, pc_select, regWrite, aluSrc, memRead, memWrite, isByte, isHalf, isWord, memToReg, comp, irOut);


endmodule
