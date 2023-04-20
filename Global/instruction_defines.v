`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Portland
// Engineer: Jude Gabriel 
// 
// Create Date: 01/30/2023 08:13:15 PM
// Design Name: 
// Module Name: instruction_defines
// Project Name: piRISC
// Target Devices: 
// Tool Versions: 
// Description: Definition of instruction types
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - Added Definitions 
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


//Opcodes
`define RTYPE      7'b0110011
`define ITYPE      7'b0010011
`define LOADTYPE   7'b0000011
`define STYPE      7'b0100011
`define BTYPE      7'b1100011
`define JTYPE      7'b1101111
`define JALRTYPE   7'b1100111
`define LUITYPE    7'b0110111
`define AUIPCTYPE  7'b0010111


//func3
`define BEQ        3'h0
`define BNE        3'h1
`define BLT        3'h4
`define BGE        3'h5
`define BLTU       3'h6
`define BGEU       3'h7