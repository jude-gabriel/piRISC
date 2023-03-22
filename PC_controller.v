`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nick Markels
// Engineer: Jude Gabriel 
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


module PC_controller(clk, reset, pc_in, pc_en, immgen_in, alu_in, pc_select, pc_value, comparator);
    
    // Operations for PC
    `define NORMALOP 2'b00
    `define BRANCHING 2'b01
    `define JAL    2'b10
    `define JALR   2'b11
    
    // Signal Width 
    parameter DWIDTH = 32;
     
    input wire clk;
    input wire reset;
    input wire pc_en;
    input wire [DWIDTH-1:0] pc_in, immgen_in, alu_in;
    input wire [1:0] pc_select;
    input wire comparator;
    output reg [DWIDTH-1:0] pc_value;
    wire signed [DWIDTH-1:0] immSigned = immgen_in;
    wire signed [DWIDTH-1:0] aluSigned = alu_in;
    
    always @(posedge clk or posedge reset)
    begin
        if(reset)
            pc_value <= 4'h0;
        else if(pc_en)
            begin
                if(pc_select == `NORMALOP)
                begin
                    pc_value <= pc_in + 4'h4;
                end
                else if(pc_select == `BRANCHING)
                begin
                    if(comparator)
                        begin
                             pc_value <= pc_in + immSigned;
                        end
                end              
                else if(pc_select == `JAL)
                    begin 
                        pc_value <= pc_in + immSigned;
                    end               
                else if(pc_select == `JALR)
                begin
                    pc_value <= pc_in + aluSigned;
                end  
                else pc_value <= pc_in + 4'h4;
            end
    end
endmodule
