
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
`define RADDSUB  3'b0000
`define RXOR     3'b100
`define ROR      3'b110
`define RAND     3'b111
`define RSLL     3'b001
`define RSRLSRA  3'b101
`define RSLT     3'b010
`define RSLTU    3'b011
`define RADD     1'b0
`define RSUB     1'b1
`define RSRL     1'b0
`define RSRA     1'b1

// Operations defined in ITYPE
`define IADD     3'b000
`define IXOR     3'b100
`define IOR      3'b110
`define IAND     3'b111
`define ISLL     3'b001
`define ISRLSRA  3'b101
`define ISLT     3'b010
`define ISLTU    3'b011
`define ISRL     1'b0
`define ISRA     1'b1


