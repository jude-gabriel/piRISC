`timescale 1ns / 1ns

module core_tb;

// Inputs 
reg clk;
reg reset;
reg go_contr;

// Outputs 
wire [31:0] irOut;

always @(irOut)
    begin 
        if(irOut == 32'hFFFFFFFF)
            $stop;
    end

// Clock Signal
initial 
    begin
        clk = 0;
        forever #10 clk = !clk; 
    end

// Instantiate Model
core core(irOut, clk, reset, go_contr);

initial 
    begin
        #20 reset = 1;
        #20 reset = 0;
        #20 go_contr = 1;
        #100000 $stop;
    end 

endmodule