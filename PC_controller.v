`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nick Markels
// 
// Create Date: 02/09/2023 02:45:58 PM
// Design Name: 
// Module Name: PC_controller
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


module PC_controller(clk, pc_in, pc_en, immgen_in, alu_in, pc_select, pc_value, comparator);

    // Operations for PC
    `define PCADD4 2'b00
    `define IMMGEN 2'b01
    `define ALU    2'b10
    parameter DWIDTH = 32;
     
    input wire clk;
    input wire pc_en;
    input wire [DWIDTH-1:0] pc_in, immgen_in, alu_in;
    input wire [1:0] pc_select;
    input wire comparator
    output reg [DWIDTH-1:0] pc_value;

    
    always @(posedge clk)
    begin
        if(pc_en)
            begin
                if(pc_select == `PCADD4)
                begin
                    pc_value <= pc_in + 4'h4;
                end
                
                else if(pc_select == `IMMGEN || comparator)
                begin
                    pc_value <= pc_in + immgen_in;
                end
                
                else if(pc_select == `ALU)
                begin
                    pc_value <= pc_in + alu_in;
                end  
                else pc_value <= pc_in + 4'h4;
            end
    end
endmodule
