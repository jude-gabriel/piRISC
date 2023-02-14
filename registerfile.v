`timescale 1ns / 1ps
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
  
  always @(posedge clk) begin
    if (RegWrite) begin
      regfile[wr_addr] <= wr_data;
    end
  end
  
  assign rd_data_A = regfile[rd_addrA];
  assign rd_data_B = regfile[rd_addrB];
  
endmodule
