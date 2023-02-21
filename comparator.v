`include "instruction_defines.v"
`timescale 1ns / 1ps


module comparator(rs1, rs2, func3, branch, comparator);

    parameter VAR_WIDTH = 32;
    input wire [VAR_WIDTH-1:0] rs1, rs2;
    input wire [2:0] func3;
    input wire branch;
    output reg comparator;
    wire output

    always@(*)
    begin
        if(branch)
        begin
            if(BEQ && (rs1 == rs2)) output <= 1'b1;
            else output <= 1'b0;
            if(BNE && (rs1 != rs2)) output <= 1'b1;
            else output <= 1'b0;
            if(BLT) && (rs1 < rs2) output <= 1'b1;
             else output <= 1'b0;
            if(BGE) && (rs1 >= rs2) output <= 1'b1;
            else output <= 1'b0;
        end
        else output <= 1'b0;
    end
    assign comparator = output;
endmodule