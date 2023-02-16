`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: Univerity of Portland 
// Engineer: Jude Gabriel 
// 
// Create Date: 02/09/2023 03:05:21 PM
// Design Name: RAM Testbench 
// Module Name: ram_tb
// Project Name: piRISC
// Target Devices: 
// Tool Versions: 
// Description: Testbench for the RAM block
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ram_tb;

    // Input-Output size
    parameter WIDTH = 32;

    // Inputs
    reg [WIDTH-1:0] wr_data;
    reg [WIDTH-1:0] addr;

    // Outputs 
    wire [WIDTH-1:0] rd_data;

    // Control Signals 
    reg isByte;
    reg isHalf;
    reg isWord;
    reg rdEn;
    reg wrEn;

    // Clock signal
    reg clk;
    initial 
        begin 
            clk = 0;
            forever #10 clk = !clk;
        end 
        
    // Instantiate model 
    RAM ram1(wr_data, rd_data, rdEn, wrEn, addr, isByte, isHalf, isWord, clk);
    
    // Main Tests 
    initial 
        begin 

            // Write different sizes to first three address locations
            wrEn = 0;
            #20 wrEn = 1; rdEn = 0; wr_data = 32'hFFFFFFFF; addr = 32'h00000000; isByte = 1; isHalf = 0; isWord = 0;
            #20 wrEn = 0;
            #20 wrEn = 1; rdEn = 0; wr_data = 32'hFFFFFFFF; addr = 32'h00000004; isByte = 0; isHalf = 1; isWord = 0;
            #20 wrEn = 0; 
            #20 wrEn = 1; rdEn = 0; wr_data = 32'hFFFFFFFF; addr = 32'h00000008; isByte = 0; isHalf = 0; isWord = 1;
            #20 wrEn = 0;

            // Read all locations at different sizes
            #20 wrEn = 0; rdEn = 1; addr = 32'h00000008; isByte = 1; isHalf = 0; isWord = 0;
            #20 rdEn = 0;
            #20 wrEn = 0; rdEn = 1; addr = 32'h00000008; isByte = 0; isHalf = 1; isWord = 0;
            #20 rdEn = 0;
            #20 wrEn = 0; rdEn = 1; addr = 32'h00000000; isByte = 0; isHalf = 0; isWord = 1;
            #20 rdEn = 0;
            #20 wrEn = 0; rdEn = 1; addr = 32'h00000004; isByte = 0; isHalf = 0; isWord = 1;
            #20 rdEn = 0;
            #20 wrEn = 0; rdEn = 1; addr = 32'h00000008; isByte = 0; isHalf = 0; isWord = 1;
            #20 rdEn = 0;
            $stop;
        end 
endmodule
