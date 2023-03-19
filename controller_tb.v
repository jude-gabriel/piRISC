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
//         R-Type
        reset = 1;
        #20 reset = 0; go_contr = 0;
        #20 func7 = 7'b0000000; func3 = 3'b000; opcode = 7'b0110011;
        #20 go_contr = 1;
        
//         I-Type
        #500 reset = 1;
        #20 reset = 0; go_contr = 0;
        #20 func7 = 7'b0000000; func3 = 3'b000; opcode = 7'b0010011;
        #20 go_contr = 1;

//          Load Type Byte
         #500 reset = 1;
         #20 reset = 0; go_contr = 0;
         #20 func7 = 7'b0000000; func3 = 3'b000; opcode = 7'b0000011;
         #20 go_contr = 1;

         // Load Type Byte Unsigned
         #500 reset = 1;
         #20 reset = 0; go_contr = 0;
         #20 func7 = 7'b0000000; func3 = 3'b100; opcode = 7'b0000011;
         #20 go_contr = 1;

         // Load Type Half
         #500 reset = 1;
         #20 reset = 0; go_contr = 0;
         #20 func7 = 7'b0000000; func3 = 3'b001; opcode = 7'b0000011;
         #20 go_contr = 1;

         // Load Type Half Unsigned
         #500 reset = 1;
         #20 reset = 0; go_contr = 0;
         #20 func7 = 7'b0000000; func3 = 3'b101; opcode = 7'b0000011;
         #20 go_contr = 1;

//          Load Type Word
         #500 reset = 1;
         #20 reset = 0; go_contr = 0;
         #20 func7 = 7'b0000000; func3 = 3'b010; opcode = 7'b0000011;
         #20 go_contr = 1;
         
//          Store Type Byte
         #500 reset = 1;
         #20 reset = 0; go_contr = 0;
         #20 func7 = 7'b0000000; func3 = 3'b000; opcode = 7'b0100011;
         #20 go_contr = 1;
         
         // Store Type Half
         #500 reset = 1;
         #20 reset = 0; go_contr = 0;
         #20 func7 = 7'b0000000; func3 = 3'b001; opcode = 7'b0100011;
         #20 go_contr = 1;
         
         //          Store Type Word
         #500 reset = 1;
         #20 reset = 0; go_contr = 0;
         #20 func7 = 7'b0000000; func3 = 3'b010; opcode = 7'b0100011;
         #20 go_contr = 1;
         

//          Branching Type
         #500 reset = 1;
         #20 reset = 0; go_contr = 0;
         #20 func7 = 7'b0000000; func3 = 3'b000; opcode = 7'b1100011; comparator = 0;
         #20 go_contr = 1;
                  
//          Branching Type
         #500 reset = 1;
         #20 reset = 0; go_contr = 0;
         #20 func7 = 7'b0000000; func3 = 3'b000; opcode = 7'b1100011; comparator = 1;
         #20 go_contr = 1;
         
//          JAL Type
         #500 reset = 1;
         #20 reset = 0; go_contr = 0;
         #20 func7 = 7'b0000000; func3 = 3'b000; opcode = 7'b1101111;
         #20 go_contr = 1;
         
//          JALR Type
         #500 reset = 1;
         #20 reset = 0; go_contr = 0;
         #20 func7 = 7'b0000000; func3 = 3'b000; opcode = 7'b1100111;
         #20 go_contr = 1;
         #1000 $stop;
        
    end

endmodule