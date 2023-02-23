`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Portland
// Engineer: Nick Markels
// 
// Create Date: 01/31/2023 10:01:23 AM
// Design Name: 
// Module Name: registerfile
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


module registerfile (
  input wire clk,
  input wire reset,
  input wire [4:0] rd_addrA,
  input wire [4:0] rd_addrB,
  input wire [4:0] wr_addr,
  input wire [31:0] wr_data,
  input wire RegWrite,
  output wire [31:0] rd_data_A,
  output wire [31:0] rd_data_B
);
  
  //Defines 32 32-bit registers b
  reg [31:0] regfile [31:0];
  
  integer i;
  always @(posedge reset)
    begin 
        for(i = 0; i < 32; i = i + 1)
            begin 
                regfile[i] = 32'b0;
             end
    end 
  
  always @(posedge clk) begin
    if (RegWrite) begin
        if(wr_addr == 32'b0)
            begin 
                regfile[wr_addr] = 32'b0;
            end 
        else
            begin 
                regfile[wr_addr] <= wr_data;
            end
    end
  end
  
  assign rd_data_A = regfile[rd_addrA];
  assign rd_data_B = regfile[rd_addrB];
  
endmodule
