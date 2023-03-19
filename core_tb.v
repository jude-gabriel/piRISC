`timescale 1ns / 1ns

module core_tb;

// Inputs 
reg clk;
reg reset;
reg go_contr;

// Outputs 
wire viewAlu;

// Clock Signal
initial 
    begin
        clk = 0;
        forever #10 clk = !clk; 
    end

// Instantiate Model
core core(viewAlu, clk, reset, go_contr);

initial 
    begin
        #20 reset = 1;
        #20 reset = 0;
        #1000 $stop;
    end 

endmodule