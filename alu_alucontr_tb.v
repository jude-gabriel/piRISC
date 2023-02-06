`timescale 1ns / 1ps
`include "instruction_defines.v"
`include "alu_defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Portland
// Engineer: Jude Gabriel
// 
// Create Date: 02/05/2023 11:08:30 PM
// Design Name: ALU - ALU Controller Integration Test
// Module Name: alu_alucontr_tb
// Project Name: piRISC
// Target Devices: 
// Tool Versions: 
// Description: Tests the integration between ALU and ALU Controller
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - TB works as expected
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu_alucontr_tb;

// ALU Controller Input
parameter IWIDTH = 11;
reg [IWIDTH-1: 0] instruction;

// ALU inputs/outputs
parameter VWIDTH = 32;
parameter AWIDTH = 4;
reg  [VWIDTH-1:0] a;
reg  [VWIDTH-1:0] b;
wire [AWIDTH-1:0] aluop;
wire [VWIDTH-1:0] aluout;

// Test signed functions
reg signed [VWIDTH-1:0] aSigned, bSigned;

// Connect ALU to controller
alu_controller alu_c1(instruction, aluop);
alu alu1(aluout, aluop, a, b);

integer i;
initial 
    begin 

        /***** RTYPE *****/

        // Test RADD
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[10] = `RADD; instruction[9:7] = `RADDSUB; instruction[6:0] = `RTYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a + b))
                    begin 
                        $display("RTYPE: ADD Correct");
                    end 
                else    
                    begin 
                        $display("RTYPE: ADD Incorrect");
                        $stop;
                    end 
            end 
        
        // Test RSUB
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[10] = `RSUB; instruction[9:7] = `RADDSUB; instruction[6:0] = `RTYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a - b))
                    begin 
                        $display("RTYPE: SUB Correct");
                    end 
                else    
                    begin 
                        $display("RTYPE: SUB Incorrect");
                        $stop;
                    end 
            end 

        // Test RXOR
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[9:7] = `RXOR; instruction[6:0] = `RTYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a ^ b))
                    begin 
                        $display("RTYPE: XOR Correct");
                    end 
                else    
                    begin 
                        $display("RTYPE: XOR Incorrect");
                        $stop;
                    end 
            end 

        // Test ROR
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[9:7] = `ROR; instruction[6:0] = `RTYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a | b))
                    begin 
                        $display("RTYPE: OR Correct");
                    end 
                else    
                    begin 
                        $display("RTYPE: OR Incorrect");
                        $stop;
                    end 
            end 
        
        // Test RAND
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[9:7] = `RAND; instruction[6:0] = `RTYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a & b))
                    begin 
                        $display("RTYPE: AND Correct");
                    end 
                else    
                    begin 
                        $display("RTYPE: AND Incorrect");
                        $stop;
                    end 
            end 

        // Test RSLL
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[9:7] = `RSLL; instruction[6:0] = `RTYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a << b))
                    begin 
                        $display("RTYPE: SLL Correct");
                    end 
                else    
                    begin 
                        $display("RTYPE: SLL Incorrect");
                        $stop;
                    end 
            end 

        // Test RSRL
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[10] = `RSRL; instruction[9:7] = `RSRLSRA; instruction[6:0] = `RTYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a >> b))
                    begin 
                        $display("RTYPE: SRL Correct");
                    end 
                else    
                    begin 
                        $display("RTYPE: SRL Incorrect");
                        $stop;
                    end 
            end 

        // Test RSRA
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[10] = `RSRA; instruction[9:7] = `RSRLSRA; instruction[6:0] = `RTYPE;
                a = $urandom; b = $urandom;
                aSigned = a; bSigned = b;
                #10
                if(aluout == (aSigned >>> bSigned))
                    begin 
                        $display("RTYPE: SRA Correct");
                    end 
                else    
                    begin 
                        $display("RTYPE: SRA Incorrect");
                        $stop;
                    end 
            end 

        // Test SLT
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[9:7] = `RSLT; instruction[6:0] = `RTYPE;
                a = $urandom; b = $urandom;
                aSigned = a; bSigned = b;
                #10
                if(aluout == ((aSigned < bSigned) ? 1 : 0))
                    begin 
                        $display("RTYPE: SLT Correct");
                    end 
                else    
                    begin 
                        $display("RTYPE: SLT Incorrect");
                        $stop;
                    end 
            end 

        // Test SLTU
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[9:7] = `RSLTU; instruction[6:0] = `RTYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == ((a < b) ? 1:0))
                    begin 
                        $display("RTYPE: SLTU Correct");
                    end 
                else    
                    begin 
                        $display("RTYPE: SLTU Incorrect");
                        $stop;
                    end 
            end 
        

        /***** ITYPE *****/ 

        // Test ADD
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[9:7] = `IADD; instruction[6:0] = `ITYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a + b))
                    begin 
                        $display("ITYPE: ADD Correct");
                    end 
                else    
                    begin 
                        $display("RTYPE: ADD Incorrect");
                        $stop;
                    end 
            end 

        // Test XOR
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[9:7] = `IXOR; instruction[6:0] = `ITYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a ^ b))
                    begin 
                        $display("ITYPE: XOR Correct");
                    end 
                else    
                    begin 
                        $display("RTYPE: XOR Incorrect");
                        $stop;
                    end 
            end 

        // Test OR
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[9:7] = `IOR; instruction[6:0] = `ITYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a | b))
                    begin 
                        $display("ITYPE: OR Correct");
                    end 
                else    
                    begin 
                        $display("RTYPE: OR Incorrect");
                        $stop;
                    end 
            end 

        // Test AND
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[9:7] = `IAND; instruction[6:0] = `ITYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a & b))
                    begin 
                        $display("ITYPE: AND Correct");
                    end 
                else    
                    begin 
                        $display("RTYPE: AND Incorrect");
                        $stop;
                    end 
            end 

        // Test SLL
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[9:7] = `ISLL; instruction[6:0] = `ITYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a << b))
                    begin 
                        $display("ITYPE: SLL Correct");
                    end 
                else    
                    begin 
                        $display("RTYPE: SLL Incorrect");
                        $stop;
                    end 
            end 

        // Test SRL
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[10] = `ISRL; instruction[9:7] = `ISRLSRA; instruction[6:0] = `ITYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a >> b))
                    begin 
                        $display("ITYPE: SRL Correct");
                    end 
                else    
                    begin 
                        $display("RTYPE: SRL Incorrect");
                        $stop;
                    end 
            end 

        // Test SRA
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[10] = `ISRA; instruction[9:7] = `ISRLSRA; instruction[6:0] = `ITYPE;
                a = $urandom; b = $urandom;
                aSigned = a; bSigned = b;
                #10
                if(aluout == (aSigned >>> bSigned))
                    begin 
                        $display("ITYPE: SRA Correct");
                    end 
                else    
                    begin 
                        $display("RTYPE: SRA Incorrect");
                        $stop;
                    end 
            end 

        // Test SLT
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[9:7] = `ISLT; instruction[6:0] = `ITYPE;
                a = $urandom; b = $urandom;
                aSigned = a; bSigned = b;
                #10
                if(aluout == ((aSigned < bSigned) ? 1:0))
                    begin 
                        $display("ITYPE: SLT Correct");
                    end 
                else    
                    begin 
                        $display("RTYPE: SLT Incorrect");
                        $stop;
                    end 
            end 
        
        // Test SLTU
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[9:7] = `ISLTU; instruction[6:0] = `ITYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == ((a < b) ? 1:0))
                    begin 
                        $display("ITYPE: SLTU Correct");
                    end 
                else    
                    begin 
                        $display("RTYPE: SLTU Incorrect");
                        $stop;
                    end 
            end 


        /***** OTHER INSTRUCTION TYPES. SHOULD JUST ADD *****/

        // Test LOADTYPE
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[6:0] = `LOADTYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a + b))
                    begin 
                        $display("LOADTYPE: ADD Correct");
                    end 
                else    
                    begin 
                        $display("LOADTYPE: ADD Incorrect");
                        $stop;
                    end 
            end 

        // Test STYPE
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[6:0] = `STYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a + b))
                    begin 
                        $display("STYPE: ADD Correct");
                    end 
                else    
                    begin 
                        $display("STYPE: ADD Incorrect");
                        $stop;
                    end 
            end 

        // Test BTYPE
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[6:0] = `BTYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a + b))
                    begin 
                        $display("BTYPE: ADD Correct");
                    end 
                else    
                    begin 
                        $display("BTYPE: ADD Incorrect");
                        $stop;
                    end 
            end 

        // Test JTYPE
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[6:0] = `JTYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a + b))
                    begin 
                        $display("JTYPE: ADD Correct");
                    end 
                else    
                    begin 
                        $display("JTYPE: ADD Incorrect");
                        $stop;
                    end 
            end 

        // Test JALRTYPE
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[6:0] = `JALRTYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a + b))
                    begin 
                        $display("JALRTYPE: ADD Correct");
                    end 
                else    
                    begin 
                        $display("JALRTYPE: ADD Incorrect");
                        $stop;
                    end 
            end 

        // Test LUITYPE
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[6:0] = `LUITYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a + b))
                    begin 
                        $display("LUITYPE: ADD Correct");
                    end 
                else    
                    begin 
                        $display("LUITYPE: ADD Incorrect");
                        $stop;
                    end 
            end 

        // Test AUIPCTYPE
        for(i = 0; i < 10; i = i + 1)
            begin 
                #10 instruction[6:0] = `AUIPCTYPE;
                a = $urandom; b = $urandom;
                #10
                if(aluout == (a + b))
                    begin 
                        $display("AUIPCTYPE: ADD Correct");
                    end 
                else    
                    begin 
                        $display("AUIPCTYPE: ADD Incorrect");
                        $stop;
                    end 
            end 
        
    end 
endmodule
