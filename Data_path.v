`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Portland 
// Engineer: Nick Markels
// Engineer: Jude Gabriel 
// 
// Create Date: 02/09/2023 03:46:21 PM
// Design Name: 
// Module Name: Data_path
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


module Data_path(clk, reset, pcEn, pcSelect, regWrite, aluSrc, ramRdEn, ramWrEn, isByte, isHalf, isWord, memToReg, viewAlu, comparatorOut, irOut);


//Parameters
parameter DWIDTH = 32;

/******* Data Path Inputs ******/

// Clock Signal 
input wire clk;

// Reset Signal 
input wire reset;

// Controller Inputs 
input wire pcEn;                  // Enable for the Program Counter
input wire [1:0] pcSelect;        // Select signal for PC operation
input wire regWrite;              // Write Signal for the Register File 
input wire aluSrc;                // Selects the second input for the ALU 
input wire ramRdEn;               // Read Enable for the Ram
input wire ramWrEn;               // Write Enable for the Ram 
input wire isByte;                // Read Byte from Ram
input wire isHalf;                // Read Half from Ram
input wire isWord;                // Read Word from Ram 
input wire [1:0] memToReg;              // Select Signal for ALU or Data Mem 
output wire [DWIDTH-1:0] viewAlu;  //output to view alu

/******* Internal Wires ******/ 

// Program Counter Output 
wire [DWIDTH-1:0] pcOut;

// Instruction Register Output 
output wire [DWIDTH-1:0] irOut;

// Register File Outputs 
wire [DWIDTH-1:0] regFileOut1;
wire [DWIDTH-1:0] regFileOut2;

// Immediate Generator Output
wire [DWIDTH-1:0] immGenOut;

// Comparator Output
output wire comparatorOut;

// ALU Controller to ALU 
wire [3:0] aluOp; 

// ALU Input 
wire [DWIDTH-1:0] aluInput2;

// ALU Output 
wire [DWIDTH-1:0] aluOut;

// Data Memory Output 
wire [DWIDTH-1:0] dataMemOut;


// Data Memory/ALU Mux output
wire [DWIDTH-1:0] dataMemALUOut;



/****** Data Path ******/ 

// Program Counter 
PC_controller pc(clk, reset, pcOut, pcEn, immGenOut, aluOut, pcSelect, pcOut, comparatorOut);
 
// Instruction Memory 
instruction_memory ir(irOut, pcOut, clk, reset);

// Register File 
//assign dataMemALUOut = memToReg ? dataMemOut : aluOut;
assign dataMemALUOut = memToReg[1] ? (memToReg[0]? immGenOut : pcOut) : (memToReg[0] ? dataMemOut : aluOut);

registerfile    rf1(clk, reset, irOut[19:15], irOut[24:20], irOut[11:7], dataMemALUOut, regWrite, regFileOut1, regFileOut2);

// Comparator 
comparator c1(comparatorOut, irOut[19:15], irOut[24:20], irOut[6:0]);

// ALU and ALU Controller 
alu_controller  ac1({irOut[30], irOut[14:12], irOut[6:0]}, aluOp);
immGen          ig1(irOut, immGenOut);
assign aluInput2 = aluSrc ? immGenOut : regFileOut2;
alu             alu1(aluOut, aluOp, regFileOut1, aluInput2);

// Data Memory 
RAM r1(regFileOut2, dataMemOut, ramRdEn, ramWrEn, aluOut, isByte, isHalf, isWord, clk);

assign viewAlu = aluOut;


endmodule
