`timescale 1ns / 1ps
`include "instruction_defines.v"
`include "alu_defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Portland
// Engineer: Jude Gabriel
// 
// Create Date: 01/30/2023 08:23:39 PM
// Design Name: ALU Controller
// Module Name: alu_controller
// Project Name: piRISC
// Target Devices: 
// Tool Versions: 
// Description: Controller for ALU operation signal
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - Added R-TYPE ALU operations
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu_controller(instruction, aluop);

// Width of instruction and control signals 
parameter IWIDTH = 32;
parameter AWIDTH = 4;

output reg [AWIDTH-1:0] aluop;
input  [IWIDTH-1:0] instruction;

// R type definitons 
wire [3:0] func3 = instruction[14:12];
wire       func7 = instruction[30];

always @(*)
    begin 
        case(instruction)
            `RTYPE:
                case(func3)
                    `RADDSUB:
                        if(func7 == `RSUB) aluop <= `ALUSUB;
                        else               aluop <= `ALUADD;
                     `RXOR:                aluop <= `ALUXOR;
                     `ROR:                 aluop <= `ALUOR;
                     `RAND:                aluop <= `ALUAND;
                     `RSLL:                aluop <= `ALUSLL;
                     `RSRLSRA:
                        if(func7 == `RSRL) aluop <= `ALUSRL;
                        else               aluop <= `ALUSRA;
                     `RSLT:                aluop <= `ALUSLT;
                     `RSLTU:               aluop <= `ALUSLTU;
                     default:              aluop <= `ALUADD;
                endcase
            `ITYPE:
                case(func3)
                    `IADD:                 aluop <= `ALUADD;
                    `IXOR:                 aluop <= `ALUXOR;
                    `IOR:                  aluop <= `ALUOR;
                    `IAND:                 aluop <= `ALUAND;
                    `ISLL:                 aluop <= `ALUSLL;
                    `ISRLSRA:         
                        if(func7 == `ISRL) aluop <= `ALUSRL;
                        else               aluop <= `ALUSRA;
                    `ISLT:                 aluop <= `ALUSLT;
                    `ISLTU:                aluop <= `ALUSLTU;
                    default:               aluop <= `ALUADD;       
                endcase 
            `LOADTYPE:                     aluop <= `ALUADD;
            `STYPE:                        aluop <= `ALUADD;
             default: aluop <= `ALUADD;
        
        endcase
    end
    

endmodule
