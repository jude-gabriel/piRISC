`timescale 1ns / 1ns
`include "alu_defines.v"
`include "instruction_defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2023 03:06:17 PM
// Design Name: 
// Module Name: alu_controller_tb
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


module alu_controller_tb;

// Widths for instruction and alu operation
parameter IWIDTH = 11;
parameter AWIDTH = 4;

// Instruction is the input, alu operation is the output
reg [IWIDTH-1:0]  instruction;
wire [AWIDTH-1:0] aluop;

alu_controller alu_c(instruction, aluop);

integer i;
initial 
    begin 
        
        
        /******** RTYPE TESTS ************/
        
        // Test RADD
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[10] = `RADD; instruction[9:7] = `RADDSUB; instruction[6:0] = `RTYPE;
        #1
        if(aluop == `ALUADD)
            begin
                $display("RTYPE: ALU ADD Correct.");
            end 
        else 
            begin
                $display("RTYPE: ALU ADD Incorrect.");
                $stop;
            end 
            
        // Test RSUB
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[10] = `RSUB; instruction[9:7] = `RADDSUB; instruction[6:0] = `RTYPE;
        #1
        if(aluop == `ALUSUB)
            begin
                $display("RTYPE: ALU SUB Correct.");
            end 
        else 
            begin
                $display("RTYPE: ALU SUB Incorrect.");
                $stop;
            end 
            
        // Test RXOR
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[9:7] = `RXOR; instruction[6:0] = `RTYPE;
        #1
        if(aluop == `ALUXOR)
            begin
                $display("RTYPE: ALU XOR Correct.");
            end 
        else 
            begin
                $display("RTYPE: ALU XOR Incorrect.");
                $stop;
            end 
            
        // Test ROR
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[9:7] = `ROR; instruction[6:0] = `RTYPE;
        #1
        if(aluop == `ALUOR)
            begin
                $display("RTYPE: ALU OR Correct.");
            end 
        else 
            begin
                $display("RTYPE: ALU OR Incorrect.");
                $stop;
            end 
            
        // Test RAND
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[9:7] = `RAND; instruction[6:0] = `RTYPE;
        #1
        if(aluop == `ALUAND)
            begin
                $display("RTYPE: ALU AND Correct.");
            end 
        else 
            begin
                $display("RTYPE: ALU AND Incorrect.");
                $stop;
            end 
            
       // Test SLL
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[9:7] = `RSLL; instruction[6:0] = `RTYPE;
        #1
        if(aluop == `ALUSLL)
            begin
                $display("RTYPE: ALU SLL Correct.");
            end 
        else 
            begin
                $display("RTYPE: ALU SLL Incorrect.");
                $stop;
            end 
            
        // Test RSRL
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[10] = `RSRL; instruction[9:7] = `RSRLSRA; instruction[6:0] = `RTYPE;
        #1
        if(aluop == `ALUSRL)
            begin
                $display("RTYPE: ALU SRL Correct.");
            end 
        else 
            begin
                $display("RTYPE: ALU SRL Incorrect.");
                $stop;
            end 
         
        // Test RSRA
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[10] = `RSRA; instruction[9:7] = `RSRLSRA; instruction[6:0] = `RTYPE;
        #1
        if(aluop == `ALUSRA)
            begin
                $display("RTYPE: ALU SRA Correct.");
            end 
        else 
            begin
                $display("RTYPE: ALU SRA Incorrect.");
                $stop;
            end 
            
       // Test SLT
        for(i = 0; i < 10; i = i + 1)
       // #10 instruction = $urandom;
        #10 instruction[9:7] = `RSLT; instruction[6:0] = `RTYPE;
        #1
        if(aluop == `ALUSLT)
            begin
                $display("RTYPE: ALU SLT Correct.");
            end 
        else 
            begin
                $display("RTYPE: ALU SLT Incorrect.");
                $stop;
            end 
       
       // Test SLTU
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[9:7] = `RSLTU; instruction[6:0] = `RTYPE;
        #1
        if(aluop == `ALUSLTU)
            begin
                $display("RTYPE: ALU SLTU Correct.");
            end 
        else 
            begin
                $display("RTYPE: ALU SLTU Incorrect.");
                $stop;
            end 
            
            
       /****** ITYPE INSTRUCTIONS ******/
       // Test ADD
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[9:7] = `IADD; instruction[6:0] = `ITYPE;
        #1
        if(aluop == `ALUADD)
            begin
                $display("ITYPE: ALU ADD Correct.");
            end 
        else 
            begin
                $display("ITYPE: ALU ADD Incorrect.");
                $stop;
            end 
            
        // Test XOR
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[9:7] = `IXOR; instruction[6:0] = `ITYPE;
        #1
        if(aluop == `ALUXOR)
            begin
                $display("ITYPE: ALU XOR Correct.");
            end 
        else 
            begin
                $display("ITYPE: ALU XOR Incorrect.");
                $stop;
            end 
            
         // Test OR
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[9:7] = `IOR; instruction[6:0] = `ITYPE;
        #1
        if(aluop == `ALUOR)
            begin
                $display("ITYPE: ALU OR Correct.");
            end 
        else 
            begin
                $display("ITYPE: ALU OR Incorrect.");
                $stop;
            end 
            
        // Test AND
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[9:7] = `IAND; instruction[6:0] = `ITYPE;
        #1
        if(aluop == `ALUAND)
            begin
                $display("ITYPE: ALU AND Correct.");
            end 
        else 
            begin
                $display("ITYPE: ALU AND Incorrect.");
                $stop;
            end 
        
        // Test SLLI
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[9:7] = `ISLL; instruction[6:0] = `ITYPE;
        #1
        if(aluop == `ALUSLL)
            begin
                $display("ITYPE: ALU SLL Correct.");
            end 
        else 
            begin
                $display("ITYPE: ALU SLL Incorrect.");
                $stop;
            end 
            
        // Test SRL
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[10] = `ISRL; instruction[9:7] = `ISRLSRA; instruction[6:0] = `ITYPE;
        #1
        if(aluop == `ALUSRL)
            begin
                $display("ITYPE: ALU SRL Correct.");
            end 
        else 
            begin
                $display("ITYPE: ALU SRL Incorrect.");
                $stop;
            end 
            
        // Test SRA
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[10] = `ISRA; instruction[9:7] = `ISRLSRA; instruction[6:0] = `ITYPE;
        #1
        if(aluop == `ALUSRA)
            begin
                $display("ITYPE: ALU SRA Correct.");
            end 
        else 
            begin
                $display("ITYPE: ALU SRA Incorrect.");
                $stop;
            end 
            
        // Test SLT
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[9:7] = `ISLT; instruction[6:0] = `ITYPE;
        #1
        if(aluop == `ALUSLT)
            begin
                $display("ITYPE: ALU SLT Correct.");
            end 
        else 
            begin
                $display("ITYPE: ALU SLT Incorrect.");
                $stop;
            end 
            
        // Test SLTU
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[9:7] = `ISLTU; instruction[6:0] = `ITYPE;
        #1
        if(aluop == `ALUSLTU)
            begin
                $display("ITYPE: ALU SLTU Correct.");
            end 
        else 
            begin
                $display("ITYPE: ALU SLTU Incorrect.");
                $stop;
            end 
            
        /***** TEST ALL OTHER INSTRUCTION TYPES. SHOULD JUST ADD *****/
        // Test LOADTYPE
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[6:0] = `LOADTYPE;
        #1
        if(aluop == `ALUADD)
            begin
                $display("LOADTYPE: ALU ADD Correct.");
            end 
        else 
            begin
                $display("LOADTYPE: ALU ADD Incorrect.");
                $stop;
            end 
            
        // Test STYPE
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[6:0] = `STYPE;
        #1
        if(aluop == `ALUADD)
            begin
                $display("STYPE: ALU ADD Correct.");
            end 
        else 
            begin
                $display("STYPE: ALU ADD Incorrect.");
                $stop;
            end 
            
        // Test BTYPE
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[6:0] = `BTYPE;
        #1
        if(aluop == `ALUADD)
            begin
                $display("BTYPE: ALU ADD Correct.");
            end 
        else 
            begin
                $display("BTYPE: ALU ADD Incorrect.");
                $stop;
            end 
            
        // Test JTYPE
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[6:0] = `JTYPE;
        #1
        if(aluop == `ALUADD)
            begin
                $display("JTYPE: ALU ADD Correct.");
            end 
        else 
            begin
                $display("JTYPE: ALU ADD Incorrect.");
                $stop;
            end 
            
        // Test JALRTYPE
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[6:0] = `JALRTYPE;
        #1
        if(aluop == `ALUADD)
            begin
                $display("JALRTYPE: ALU ADD Correct.");
            end 
        else 
            begin
                $display("JALRTYPE: ALU ADD Incorrect.");
                $stop;
            end 
            
        // Test LUITYPE
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[6:0] = `LUITYPE;
        #1
        if(aluop == `ALUADD)
            begin
                $display("LUITYPE: ALU ADD Correct.");
            end 
        else 
            begin
                $display("LUITYPE: ALU ADD Incorrect.");
                $stop;
            end 
            
        // Test AUIPCTYPE
        for(i = 0; i < 10; i = i + 1)
        #10 instruction = $urandom;
        #10 instruction[6:0] = `AUIPCTYPE;
        #1
        if(aluop == `ALUADD)
            begin
                $display("AUIPCTYPE: ALU ADD Correct.");
            end 
        else 
            begin
                $display("AUIPCTYPE: ALU ADD Incorrect.");
                $stop;
            end 
           
       #10 $stop;
    end 

initial 
    begin 
        $monitor($stime,, instruction);
    end 
endmodule