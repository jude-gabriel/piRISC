`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Portland 
// Engineer: Nick Markels
// Engineer: Jude Gabriel
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

module RAM(wr_data, rd_data, rdEn, wrEn, addr, isByte, isHalf, isWord, func3, clk);

    //Parameters
    parameter DWIDTH = 32;
    parameter MEMDEPTH = 1024;
    parameter AWIDTH = $clog2(MEMDEPTH);
    
    // Inputs 
    input wire [DWIDTH-1:0] wr_data, addr;
    
    // Outputs
    output reg [DWIDTH-1:0] rd_data;
    
    // Control Signals 
    input wire       isByte;
    input wire       isHalf;
    input wire       isWord;
    input wire       rdEn;
    input wire       wrEn;
    input wire [2:0] func3;
    
    // Clock Signals 
    input clk;
    
    reg [DWIDTH-1:0] mem[0:MEMDEPTH-1];
    
    always @(posedge clk)
    begin
        if(wrEn) 
            begin 
                if(isByte)
                    begin 
                        mem[addr[7:2]] = {24'b0, wr_data[7:0]};
                    end
                else if(isHalf)
                    begin
                        mem[addr[7:2]] = {16'b0, wr_data[15:0]};
                    end 
                else if(isWord)
                    begin 
                        mem[addr[7:2]] = wr_data;
                    end 
                else 
                    begin 
                        mem[addr[7:2]] = wr_data;
                    end 
            end 
            
        if(rdEn) 
            begin 
                if(isByte)
                    begin 
                        if(func3 == 3'h0)
                            rd_data <= {{24{mem[addr[7:2]][7]}}, mem[addr[7:2]][7:0]};
                        if(func3 == 3'h4)
                            rd_data <= {24'b0, mem[addr[7:2]][7:0]};
                    end 
                else if(isHalf)
                    begin
                        if(func3 == 3'h1)
                            rd_data <= {{16{mem[addr[7:2]][15]}}, mem[addr[7:2]][15:0]};
                        if(func3 == 3'h5)
                            rd_data <= {16'b0, mem[addr[7:2]][15:0]};
                    end 
                else if(isWord)
                    begin
                        rd_data <= mem[addr[7:2]];
                    end 
                else 
                    begin 
                        rd_data <= mem[addr[7:2]];
                    end 
            end 
    end  
endmodule


