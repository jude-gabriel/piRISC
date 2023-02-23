`include "instruction_defines.v"
`timescale 1ns / 1ns


module comparator(out, rs1, rs2, func3);

    parameter VAR_WIDTH = 32;
    input wire [VAR_WIDTH-1:0] rs1, rs2;
    input wire [2:0] func3;
    output reg out;

    always@(*)
    begin
        if((func3 == `BEQ) && (rs1 == rs2)) out <= 1'b1;
        else out <= 1'b0;
        if((func3 == `BNE) && (rs1 != rs2)) out <= 1'b1;
        else out <= 1'b0;
        if((func3 == `BLT) && (rs1 < rs2)) out <= 1'b1;
        else out <= 1'b0;
        if((func3 == `BGE) && (rs1 >= rs2)) out <= 1'b1;
        else out <= 1'b0;
    end
endmodule