`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Portland 
// Engineer: Nick Markels
// 
// Create Date: 01/31/2023 03:06:33 PM
// Design Name: 
// Module Name: RAM
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


`timescale 1ns/1ns

module RAM(wr_data, rd_data, rdEn, wrEn, addr, clk);

    //Parameters
    parameter DWIDTH = 32;
    parameter MEMDEPTH = 1024;
    parameter AWIDTH = $clog2(MEMDEPTH);
    
    //IO 
    input wire [DWIDTH-1:0] wr_data, addr;
    input wire rdEn, wrEn, clk;
    output reg [DWIDTH-1:0] rd_data;
    
    reg [DWIDTH-1:0] mem[0:MEMDEPTH-1];
    
    always @(posedge clk)
    begin
        if(wrEn) mem[addr[7:2]] <= wr_data;
        if(rdEn) rd_data <= mem[addr[7:2]];
    end
    
endmodule


