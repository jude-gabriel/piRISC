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


module ALU_tb;

parameter WIDTH = 32;
parameter OP_WIDTH = 5;

reg [WIDTH-1:0] a, b;
reg [OP_WIDTH-1:0] opcode;
wire [WIDTH-1:0] out;

alu alu1(out, opcode, a, b);

initial
   begin
    
    //Test Adder
    #10 opcode = 'b00001; a = 32'haa554422; b = 32'h00993300;
    #1
    if(out ==  32'haaee7722)
        begin
          $display("Sum is correct");
        end
    else
        begin
          $display("Sum is Wrong");
          $displayh(out);
          $stop;
        end
        
    #10 opcode = 'b00001; a = 32'h00ffdd88; b = 32'hff009865;
    #1
    if(out ==  32'h1000075ED)
        begin
          $display("Sum is correct");
        end
    else
        begin
          $display("Sum is Wrong");
          $displayh(out);
          $stop;
        end
        
    #10 opcode = 'b00001; a = 32'haadd9987; b = 32'h0087ff78;
    #1
    if(out ==  32'hAB6598FF)
        begin
          $display("Sum is correct");
        end
    else
        begin
          $display("Sum is Wrong");
          $displayh(out);
          $stop;
        end
        
        
        
    //Test subtraction 
    #10 opcode = 'b10001; a = 32'hff009867; b = 32'h984487dd;
    #1
    if(out ==  32'h66BC108A)
        begin
          $display("Differnce is correct");
          $displayh(out);
        end
    else
        begin
          $display("Difference is Wrong");
          $displayh(out);
          $stop;
        end
          
    #10 opcode = 'b10001; a = 32'h00000009; b = 32'h00000002;
    #1
    if(out ==  32'h00000007)
        begin
          $display("Differnce is correct");
          $displayh(out);
        end
    else
        begin
          $display("Difference is Wrong");
          $displayh(out);
          $stop;
        end
        
    #10 opcode = 'b10001; a = 32'hb877ff99; b = 32'h987b554c;
    #1
    if(out ==  32'h1FFCAA4D)
        begin
          $display("Differnce is correct");
          $displayh(out);
        end
    else
        begin
          $display("Difference is Wrong");
          $displayh(out);
          $stop;
        end
        
    //XOR: 01001
     #10 opcode = 'b01001; a = 32'haa554422; b = 32'h00993300;
    #1
    if(out ==  a ^ b)
        begin
          $display("XOR is correct");
        end
    else
        begin
          $display("XOR is Wrong");
          $displayh(out);
          $displayh(a ^ b);
          //$stop;
        end
        
    #10 opcode = 'b01001; a = 32'h00ffdd88; b = 32'hff009865;
    #1
    if(out ==  a ^ b)
        begin
          $display("XOR is correct");
        end
    else
        begin
          $display("XOR is Wrong");
          $displayh(out);
          $displayh(a ^ b);
          //$stop;
        end
        
    #10 opcode = 'b01001; a = 32'haadd9987; b = 32'h0087ff78;
    #1
    if(out ==  a ^ b)
        begin
          $display("XOR is correct");
        end
    else
        begin
          $display("XOR is Wrong");
          $displayh(out);
          $displayh(a ^ b);
          //$stop;
        end
        
    //OR: 01101
     #10 opcode = 'b01101; a = 32'haa554422; b = 32'haa554422;
    #1
    if(out ==   a | b)
        begin
          $display("OR is correct");
        end
    else
        begin
          $display("OR is Wrong");
          $displayh(out);
          $displayh(a | b);
          //$stop;
        end
        
    #10 opcode = 'b01101; a = 32'h00ffdd88; b = 32'hff009865;
    #1
    if(out ==   a | b)
        begin
          $display("OR is correct");
        end
    else
        begin
          $display("OR is Wrong");
          $displayh(out);
          $displayh(a | b);
          //$stop;
        end
        
    #10 opcode = 'b01101; a = 32'haadd9987; b = 32'h0087ff78;
    #1
    if(out ==   a | b)
        begin
          $display("OR is correct");
        end
    else
        begin
          $display("OR is Wrong");
          $displayh(out);
          $displayh(a | b);
          //$stop;
        end
        
    
        
            
    #10 $stop;
   end
    
initial
   begin
    $display("      time opcode a  b  out "); 
    $monitor($stime,, opcode,,, a,,, b,,, out,,,,,, ); 
   end

endmodule  

    
    

