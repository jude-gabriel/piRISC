`timescale 1ns / 1ps
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
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu(out, opcode, a, b);

parameter VAR_WIDTH = 32;
parameter OP_WIDTH = 5;

// ALU output (reg type for procedural assignemnt)
output reg [VAR_WIDTH-1:0] out;

// Opcode 
input [OP_WIDTH-1:0] opcode;

// ALU input values
input [VAR_WIDTH-1:0] a;
input [VAR_WIDTH-1:0] b;

// The base opcode is stored in bits 3-1
wire baseOp = opcode[3:1];

// Shift right and subtraction are determined by bit 30 in the ISA (See schematic)
wire isFunc7Extension = opcode[4];

// ISA determines that there is no subtraction immediate, must default back to addition for I-type(See schematic)
wire isRType = opcode[0];

// Verilog wire types are default unsigned, a signed verison is needed for slt and slti conversions 
wire signed [VAR_WIDTH-1:0] aSigned = a;
wire signed [VAR_WIDTH-1:0] bSigned = b;

always @(*)
    begin   
        case(baseOp)
            
            // Addition/Subtraction:
            // If it is I-type it has to be addition via ISA
            // If R-type if it is not func7 extended, it is addition
            // If R-type and func7 extended, it is subtraction
            'b000:
                if(!isRType)
                    begin
                        out <= a + b;
                    end 
                else
                    begin
                        if(isFunc7Extension)
                            begin
                                out <= a - b;
                            end 
                        else
                            begin
                                out <= a + b;
                            end 
                    end 
                 
                // Shift Left logical  
                'b001: out <= a << b;
                
                // Set Less Than (Uses signed types)
                'b010: out <= (aSigned < bSigned) ? 1:0;
                
                // Set Less Than Unsigned
                'b011: out <= (a < b) ? 1:0;
                
                // XOR
                'b100: out <= a ^ b;
                
                // Shift Right:
                // Standard logical shift
                // If func7 extended, then it is arithmetic per the ISA
                'b101:
                    if(isFunc7Extension)
                        begin 
                            out <= a >>> b; 
                        end 
                    else 
                        begin 
                            out <= a >> b; 
                        end 
                
                // OR 
                'b110: out <= a | b; 
                
                // AND  
                'b111: out <= a | b;
                
                // Default: should never be reached
                default: out <= a + b;
        endcase
    end 
endmodule










