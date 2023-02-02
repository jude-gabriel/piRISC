//-------------------------------------------------------
//	Module: Testbench for 32-bit RAM 
//	Author: Jude Gabriel
//------------------------------------------------------

`timescale 1ns/1ns


module RAM_tb;

parameter WIDTH = 32;

reg [WIDTH-1:0] wr_data, addr;
reg rdEn, wrEn, clk;
wire [WIDTH-1:0] rd_data;
reg [WIDTH-1:0] test_data;

RAM ram1(wr_data, rd_data, rdEn, wrEn, addr, clk);

initial 
    begin 
  clk = 0;
  forever #10 clk = !clk;
    end

initial
    begin 
        for(integer i = 0; i < 1024; i = i + 4)
            begin
            test_data = $urandom;
            #10 wrEn = 1; rdEn = 0; wr_data = test_data; addr = i;
            #10 rdEn = 1; wrEn =0;
            #20
            if(rd_data == test_data) $display("Correct value at address %h is %h", addr, rd_data);
            else $display("Incorrect Value");
         end
         
          for(integer i = 0; i < 1024; i = i + 4)
            begin
            test_data = $urandom;
            #10 wrEn = 1; rdEn = 0; wr_data = test_data; addr = i;
            #10 rdEn = 1; wrEn =0;
            #20
            if(rd_data == test_data) $display("Correct value at address %h is %h", addr, rd_data);
            else $display("Incorrect Value");
         end
        $stop;
        $stop;
    end

endmodule 
