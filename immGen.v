`timescale 1ns / 1ps
`include "instruction_defines.v"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2023 02:50:24 PM
// Design Name: 
// Module Name: immGen
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


module immGen(instruction, immGenOUT);
parameter WIDTH = 32;

input wire  [WIDTH-1:0] instruction;
output reg [WIDTH-1:0] immGenOUT;

wire [6:0] opcode;
wire[2:0] funct3;

//opcode and func3 comes from instruction
assign opcode = instruction[6:0];
assign funct3 = instruction[14:12];

always@(*)
    begin
        case(opcode)
            //I Type
            `ITYPE: immGenOUT <= {{20{instruction[31]}}, instruction[30:20]};
            `LOADTYPE: immGenOUT <= {{20{instruction[31]}}, instruction[30:20]};
            
            //S type
            `STYPE: immGenOUT <= {{21{instruction[31]}}, instruction[30:25], instruction[11:8], instruction[7]};
            
            
        endcase
    end


endmodule
