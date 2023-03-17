`timescale 1ns / 1ns

module controller_tb;

parameter WIDTH = 32;

// Inputs 
reg [6:0] func7;
reg [2:0] func3;
reg [6:0] opcode;
reg       comparator;
reg       clk;
reg       reset;
reg       go_contr;

// Outputs 
wire        irEn;
wire        pcEn;
wire [1:0]  pc_select;
wire        aluSrc;
wire        regWrite;
wire [1:0]  memToReg;
wire        isByte;
wire        isHalf;
wire        isWord;
wire        memRead;
wire        memWrite;

// Clock Signal
initial 
    begin
        clk = 0;
        forever #10 clk = !clk; 
    end


// Instantiate Model
controller contr(irEn, pcEn, pc_select, aluSrc, regWrite, memToReg, isByte, isHalf, isWord, memRead, memWrite, func7, func3, opcode, comparator, go_contr, clk, reset);


// Main Tests
initial
    begin
        // R-Type
//        reset = 1;
//        #20 reset = 0; go_contr = 0;
//        #20 func7 = 7'b0000000; func3 = 3'b000; opcode = 7'b0110011;
//        #20 go_contr = 1;
//        #1000 $stop;
        
        // I-Type
        reset = 1;
        #20 reset = 0; go_contr = 0;
        #20 func7 = 7'b0000000; func3 = 3'b000; opcode = 7'b0110011;
        #20 go_contr = 1;
        #1000 $stop;

        // // Load Type
        // reset = 1;
        // #20 reset = 0; go_contr = 0;
        // #20 func7 = 7'b0000000; func3 = 3'b000; opcode = 7'b0110011;
        // #20 go_contr = 1;
        // #1000 $stop;

        // // Store Type
        // reset = 1;
        // #20 reset = 0; go_contr = 0;
        // #20 func7 = 7'b0000000; func3 = 3'b000; opcode = 7'b0110011;
        // #20 go_contr = 1;
        // #1000 $stop;


        // // Branching Type
        // reset = 1;
        // #20 reset = 0; go_contr = 0;
        // #20 func7 = 7'b0000000; func3 = 3'b000; opcode = 7'b0110011;
        // #20 go_contr = 1;
        // #1000 $stop;

        // // JAL Type
        // reset = 1;
        // #20 reset = 0; go_contr = 0;
        // #20 func7 = 7'b0000000; func3 = 3'b000; opcode = 7'b0110011;
        // #20 go_contr = 1;
        // #1000 $stop;

        // // JALR Type
        // reset = 1;
        // #20 reset = 0; go_contr = 0;
        // #20 func7 = 7'b0000000; func3 = 3'b000; opcode = 7'b0110011;
        // #20 go_contr = 1;
        // #1000 $stop;
        
    end

endmodule