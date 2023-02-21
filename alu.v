`timescale 1ns / 1ps
`include "alu_defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Portland
// Engineer: Jude Gabriel
// 
// Create Date: 01/26/2023 10:15:57 PM
// Design Name: piRISC ALU
// Module Name: alu
// Project Name: piRISC
// Target Devices: 
// Tool Versions: 
// Description: ALU 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.02 - Changed operation. ALU should not have to decode
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu(out, opcode, a, b);

// Variable and Opcode Widths
parameter VAR_WIDTH = 32;
parameter OP_WIDTH = 4;

// ALU output (reg type for procedural assignemnt)
output reg [VAR_WIDTH-1:0] out;

// Opcode 
input [OP_WIDTH-1:0] opcode;

// ALU input values
input [VAR_WIDTH-1:0] a;
input [VAR_WIDTH-1:0] b;


// Verilog wire types are default unsigned, a signed verison is needed for slt and slti conversions 
wire signed [VAR_WIDTH-1:0] aSigned = a;
wire signed [VAR_WIDTH-1:0] bSigned = b;

always @(*)
    begin   
        case(opcode)
            `ALUADD:    out <= a + b;
            `ALUSUB:    out <= a - b;
            `ALUXOR:    out <= a ^ b;
            `ALUOR:     out <= a | b;
            `ALUAND:    out <= a & b;
            `ALUSLL:    out <= a << b;
            `ALUSRL:    out <= a >> b;
            `ALUSRA:    out <= a >>> b;
            `ALUSLT:    out <= (aSigned < bSigned) ? 1:0;
            `ALUSLTU:   out <= (a < b) ? 1:0;
            default:    out <= 32'b0;
        endcase
    end 
endmodule
















