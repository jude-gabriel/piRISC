`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Portland
// Engineer: Nick Markels
// 
// Create Date: 01/27/2023 12:42:47 PM
// Design Name: 
// Module Name: aluTB
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

//OP Codes
//R Type
//ADD: 00001
//SUB: 10001
//XOR: 01001
//OR: 01101
//AND 01111
//SLL 00011


module ALU_tb1;

parameter VAR_WIDTH = 32;
parameter OP_WIDTH = 4;

reg [VAR_WIDTH-1:0] a, b;
reg [OP_WIDTH-1:0] opcode;
wire [VAR_WIDTH-1:0] out;

// Verilog wire types are default unsigned, a signed verison is needed for slt and slti conversions 
reg signed [VAR_WIDTH-1:0] aSigned, bSigned;



alu alu1(out, opcode, a, b);

initial
   begin
    
    //Test Add
    for(integer i = 0; i < 10; i = i + 1)
    begin
        #10 opcode = `ALUADD; a = $urandom; b = $urandom;
        #1
        if(out ==  (a + b))
            begin
              $display("Sum is correct");
              $displayh(out);
            end
        else
            begin
              $display("Sum is Wrong");
              $displayh(out);
              $stop;
            end
        end
        
   //Test Subtract
    for(integer i = 0; i < 10; i = i + 1)
    begin
        #10 opcode = `ALUSUB; a = $urandom; b = $urandom;
        #1
        if(out ==  (a - b))
            begin
              $display("Differnce is correct");
              $displayh(out);
            end
        else
            begin
              $display("Differnce is Wrong");
              $displayh(out);
              $stop;
            end
        end
        
    //Test XOR
    for(integer i = 0; i < 10; i = i + 1)
    begin
        #10 opcode = `ALUXOR; a = $urandom; b = $urandom;
        #1
        if(out ==  (a ^ b))
            begin
              $display("XOR is correct");
              $displayh(out);
            end
        else
            begin
              $display("XOR is Wrong");
              $displayh(out);
              $stop;
            end
        end
        
    //Test OR
    for(integer i = 0; i < 10; i = i + 1)
    begin
        #10 opcode = `ALUOR; a = $urandom; b = $urandom;
        #1
        if(out == (a | b))
            begin
              $display("OR is correct");
              $displayh(out);
            end
        else
            begin
              $display("OR is Wrong");
              $displayh(out);
              $stop;
            end
        end
        
    //Test And
    for(integer i = 0; i < 10; i = i + 1)
    begin
        #10 opcode = `ALUAND; a = $urandom; b = $urandom;
        #1
        if(out == (a & b))
            begin
              $display("AND is correct");
              $displayh(out);
            end
        else
            begin
              $display("AND is Wrong");
              $displayh(out);
              $displayh(a & b);
              $stop;
            end
        end
        
   //Test SLL
    for(integer i = 0; i < 10; i = i + 1)
    begin
        #10 opcode = `ALUSLL; a = $urandom; b = $urandom%32;
        #1
        if(out ==  (a << b))
            begin
              $display("SLL is correct");
              $displayh(out);
            end
        else
            begin
              $display("SLL is Wrong");
              $displayh(out);
              $stop;
            end
        end
        
    //Test SRL
    for(integer i = 0; i < 10; i = i + 1)
    begin
        #10 opcode = `ALUSRL; a = $urandom; b = $urandom%32;
        #1
        if(out ==  (a >> b))
            begin
              $display("SRL is correct");
              $displayh(out);
            end
        else
            begin
              $display("SRL is Wrong");
              $displayh(out);
              $displayh(a >> b);
              $stop;
            end
        end
        
    //Test SRA
    for(integer i = 0; i < 10; i = i + 1)
    begin
        #10 opcode = `ALUSRA; a = $urandom; b = $urandom%32;
        #1
        if(out ==  (a >>> b))
            begin
              $display("SRA is correct");
              $displayh(out);
            end
        else
            begin
              $display("SRA is Wrong");
              $displayh(out);
              $stop;
              $displayh(a >>> b);
            end
        end
        
   //Test SLT
    for(integer i = 0; i < 10; i = i + 1)
    begin
        #10 opcode = `ALUSLT; a = $random; b = $random%32;
        aSigned = a;
        bSigned = b;
        #1
        if(out ==  (aSigned < bSigned) ? 1:0)
            begin
              $display("SLT is correct");
              $displayh(out);
            end
        else
            begin
              $display("SLT is Wrong");
              $displayh(out);
              $displayh((aSigned < bSigned) ? 1:0);
              $stop;
            end
        end
            
    //Test SLTU
    for(integer i = 0; i < 10; i = i + 1)
    begin
        #10 opcode = `ALUSLTU; a = $urandom; b = $urandom%32;
        #1
        if(out ==  (a < b) ? 1:0)
            begin
              $display("SLTU is correct");
              $displayh(out);
            end
        else
            begin
              $display("SLTU is Wrong");
              $displayh(out);
              $displayh((a < b) ? 1:0);
              $stop;
            end
        end
   
    $display("Testbench Ran Successfully");        
    #10 $stop;
   end
    
initial
   begin
    $display("      time opcode a  b  out "); 
    $monitor($stime,, opcode,,, a,,, b,,, out,,,,,, ); 
   end

endmodule  

    
    

