
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Portland 
// Engineer: Jude Gabriel
// 
// Create Date: 01/30/2023 07:29:49 PM
// Design Name: 
// Module Name: alu_defines
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Definitions for ALU operation codes
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - Definitions Added
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// Operations for ALU
`define ALUADD  4'b0000
`define ALUSUB  4'b0001
`define ALUXOR  4'b0010
`define ALUOR   4'b0011
`define ALUAND  4'b0100
`define ALUSLL  4'b0101
`define ALUSRL  4'b0110
`define ALUSRA  4'b0111
`define ALUSLT  4'b1000
`define ALUSLTU 4'b1001

// Operations defined in RTYPE
`define RADDSUB  4'b0000
`define RXOR     4'b1000
`define ROR      4'b1010
`define RAND     4'b1011
`define RSLL     4'b0001
`define RSRLSRA  4'b1001
`define RSLT     4'b0010
`define RSLTU    4'b0011
`define RADD     1'b0
`define RSUB     1'b1
`define RSRL     1'b0
`define RSRA     1'b1

