`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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

parameter WIDTH = 32;
parameter OP_WIDTH = 5;

reg [WIDTH-1:0] a, b;
reg [OP_WIDTH-1:0] opcode;
wire [WIDTH-1:0] out;

// Verilog wire types are default unsigned, a signed verison is needed for slt and slti conversions 
reg signed [WIDTH-1:0] aSigned, bSigned;


alu alu1(out, opcode, a, b);

initial
   begin
    
    //Test Adder
    for(integer i = 0; i < 10; i = i + 1)
    begin
        #10 opcode = 5'b00001; a = $urandom; b = $urandom;
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
            
    //Test Subtractor
    for(integer i = 0; i < 10; i = i + 1)
    begin
        #10 opcode = 5'b10001; a = $urandom; b = $urandom;
        #1
        if(out ==  (a - b))
            begin
              $display("Difference is correct");
              $displayh(out);
            end
        else
            begin
              $display("Differnce is Wrong");
              $displayh(out);
              $stop;
            end
    end
 
    //Test XOR: 01001
    for(integer i = 0; i < 10; i = i + 1)
    begin
        #10 opcode = 5'b01001; a = $urandom; b = $urandom;
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
    
    //Test OR: 01101
    for(integer i = 0; i < 10; i = i + 1)
    begin
        #10 opcode = 5'b01101; a = $urandom; b = $urandom;
        #1
        if(out ==  (a | b))
            begin
              $display("OR is correct");
              $displayh(out);
            end
        else
            begin
              $display("OR is Wrong");
              $displayh(out);
              $displayh(a | b);
              $stop;
            end
    end
    
    //Test AND: 01111
    for(integer i = 0; i < 10; i = i + 1)
    begin
        #10 opcode = 5'b01111; a = $urandom; b = $urandom;
        #10
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
            
    //Test SLL: 00011
    for(integer i = 0; i < 10; i = i + 1)
    begin
        #10 opcode = 5'b00011; a = $urandom; b = $urandom;
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
              $displayh(a << b);
              $stop;
            end
    end
    
    
    //SLT: 00101 (signed)
     for(integer i = 0; i < 10; i = i + 1)
    begin
        #10 opcode = 5'b00101; a = $random; b = $random;
            aSigned = a; 
            bSigned = b; 
        #1
        if(out ==  ((aSigned < bSigned) ? 1:0))
            begin
              $display("SLT is correct");
              $displayh(out);
            end
        else
            begin
              $display("SLT is Wrong");
              $displayh(out);
              $displayh(((aSigned < bSigned) ? 1:0));
              $stop;
            end
    end    
            
    #10 $stop;
   end
    
initial
   begin
    $display("      time opcode a  b  out "); 
    $monitor($stime,, opcode,,, a,,, b,,, out,,,,,, ); 
   end

endmodule  

    
    

