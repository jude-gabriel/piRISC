`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Portland
// Engineer: Jude Gabriel
// 
// Create Date: 03/14/2023 01:41:52 PM
// Design Name: 
// Module Name: controller
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

module controller(pcEn, pc_select, aluSrc, regWrite, memToReg, isByte, isHalf, isWord, memRead, memWrite, instruction, comparator, clk, reset);

//------ OUTPUTS FROM CPU ------/
output reg       pcEn;        // Enables the program counter to update
output reg [1:0] pc_select;   // Selects the program counter 
output reg       aluSrc;      // Select line for ALU input b
output reg       regWrite;    // Write enable for the register file
output reg [1:0] memToReg;    // Select line for register file write input 
output reg       isByte;      // Select line for Byte access in memory
output reg       isHalf;      // Select line for Half access in memory
output reg       isWord;      // Select line for Word access in memory
output reg       memRead;     // Enables memory to be read
output reg       memWrite;    // Enables memeory to be written to 



//--------- INPUTS FROM CPU --------//
input [31:0] instruction;
input        comparator;
input        clk;
input        reset;

//-------- Bits from Inputs -------//
wire [6:0] func7;
wire [2:0] func3;
assign func7 = instruction[31:25];
assign func3 = instruction[14:12];


//------ TYPEDEFS FOR STATES -------//
typedef enum {R_S0, R_S1, R_S2} r_state_t;                          // RTYPE States
typedef enum {I_S0, I_S1, I_S2} i_state_t;                          // ITYPE States
typedef enum {L_S0, L_S1, L_S2, L_S3, L_S4, L_S5} l_state_t;        // Load States  
typedef emum {S_S0, S_S1, S_S3, S_S4} s_state_t;                    // Store States
typedef enum {B_S0, B_S1, B_S2, B_S3} b_state_t;                    // Branching States 
typedef enum {JAL_S0, JAL_S1, JAL_S2} jal_state_t;                  // JAL States
typedef emum {JALR_S0, JALR_S1, JALR_S2} jalr_state_t;              // JALR States



//----- FLAGS -------// 
integer go_rtype;           // Tells RTYPE FSM to start
integer rtype_done;         // Tells controller RTYPE FSM is done 

integer go_itype;           // Tells ITYPE FSM to start
integer itype_done;         // Tells the controller the ITYPE FSM is done 

integer go_ltype;           // Tells the Load Type FSM to start
integer ltype_done;         // Tells the controller the Load Type FSM is done

integer go_stype;           // Tells the Store Type FSM to start
integer stype_done;         // Tells the controller the Store Type FSM is done 

integer go_branching;       // Tells the Branching Type FSM to start
integer branching_done;     // Tells the controller the Branching Type FSM is done 

integer go_jal;             // Tells the JAL Type FSM to start
integer jal_done;           // Tells the controller the JAL Type FSM is done

integer go_jalr;            // Tells the JALR Type FSM to start
integer jalr_done;          // Tells the controller the JALR Type FSM is done


//------ RESET -----//
always @(posedge reset)
    begin 
        // Outputs 
        pcEn = 0;
        pc_select = 2'b0;
        aluSrc = 0;
        regWrite = 0;
        memToReg = 2'b0;
        isByte = 0;
        isHalf = 0;
        isWord = 0;
        memRead = 0;
        memWrite = 0;

        // Go Flags 
        go_rtype        = 0;
        go_itype        = 0;
        go_ltype        = 0;
        go_stype        = 0;
        go_branching    = 0;
        go_jal          = 0;
        go_jalr         = 0;



// ------ RTYPE FSM ------//
r_state_t curr_rtype, next_rtype;
always @(posedge clk or posedge reset)
    begin 
        if(reset)
            begin 
                curr_rtype = R_S0;
                next_rtype = R_S0;
            end 
        else 
            curr_rtype = next_rtype;

        if(go_rtype)
            begin 
                case(curr_rtype)

                    // Check if we are good to go 
                    S0: 
                        begin 
                            next_rtype = (go_rtype) ? R_S1 : R_S0;
                            aluSrc = 0;
                            rytpe_done = 0;
                        end 

                    // Set regWrite to 1 so we can write to the register file 
                    S1: 
                        begin 
                                next_rtype = R_S2;
                                regWrite = 1;
                        end 
                    
                    // Disable regWrite and mark this controller as done 
                    S2:
                        begin 
                            next_rtype = R_S0;
                            regWrite = 0;
                            rytpe_done = 1;
                        end 
                    
                    // Default case 
                    default: 
                        begin
                            next_rtype = curr_rtype;
                            rytpe_done = 0;
                        end 
                endcase 
            end 
    end 



//----- ITYPE FSM -----//
i_state_t curr_itype, next_itype;
always @(posedge clk or posedge reset)
    begin 
        if(reset)
            begin 
                curr_itype = I_S0;
                next_itype = I_S0;
            end 
        else 
            curr_itype = next_itype

        if(go_itype)
            begin 
                case(curr_itype)

                    // Check if we are good to go 
                    I_S0:
                        begin 
                            next_itype = (go_itype) ? I_S1 : I_S0;
                            aluSrc = 1;
                            memToReg = 2'b0;
                            itype_done = 0;
                        end 

                    // Write to the register file 
                    I_S1:
                        begin 
                            next_itype = I_S2;
                            regWrite = 1;
                            itype_done = 0;
                        end 

                    // Turn off write signal and mark FSM as done 
                    I_S2:
                        begin 
                            next_itype = I_S0;
                            regWrite = 0;
                            itype_done = 1;
                        end 

                    // Default case 
                    default:
                        begin 
                            next_itype = curr_itype;
                            itype_done = 0;
                        end 

                endcase 
            end 
    end  


//------ LOAD FSM -----//
l_state_t curr_ltype, next_ltype;
always @(posedge clk or posedge reset)
    begin 
        if(reset)
        begin 
            curr_ltype = L_S0;
            next_ltype = L_S0;
        end 
        else
            curr_ltype = next_ltype;

        if(go_ltype)
            begin 
                case(curr_ltype)

                    // Check if we are good to go 
                    L_S0:
                        begin 
                            if(go_ltype)
                                if(func3 == 3'h0x0 || func3 == 3'h0x4)
                                    begin 
                                        next_ltype = L_S1;
                                    end 
                                else if(func3 == 3'h0x1 || func3 == 3'h0x5)
                                    begin 
                                        next_ltype = L_S2;
                                    end 
                                else if(func3 == 3'h0x2)
                                    begin 
                                        next_ltype = L_S3
                                    end 
                            ltype_done = 0;
                            aluSrc = 1;
                            memToReg = 2'b1;
                            memRead = 0;
                            regWrite = 0;
                            isByte = 0;
                            isHalf = 0;
                            isWord = 0;
                        end 
                    L_S1:
                        begin 
                            next_ltype = L_S4;
                            isByte = 1;
                            memRead = 1;
                        end 
                    L_S2:
                        begin 
                            next_ltype = L_S4;
                            isHalf = 1;
                            memRead = 1;
                        end
                    L_S3:
                        begin
                            next_ltype = L_S4;
                            isWord = 1;
                            memRead = 1;
                        end 
                    L_S4:
                        begin 
                            next_ltype = L_S5;
                            isByte = 0;
                            isHalf = 0;
                            isWord = 0;
                            memRead = 0;
                            regWrite = 1;
                        end 
                    L_S5:
                        begin 
                            next_ltype = L_S0;
                            regWrite = 0;
                            aluSrc = 0;
                            memToReg = 2'b0;
                            ltype_done = 1;
                        end 

                    default:
                        begin 
                            next_ltype = curr_ltype;
                            ltype_done = 0;
                        end 
                endcase 
            end 
    end 



//----- Store FSM -----//
s_state_t curr_stype, next_stype;
always @(posedge clk or posedge reset)
    begin 
        if(reset)
            begin 
                curr_stype = S_S0;
                next_stype = S_S0;
            end
        else 
            curr_stype = next_stype;

        if(go_store)
            begin 
                case(curr_stype)
                    S_S0:
                        begin 
                            if(go_store)
                                begin 
                                    if(func3 == 3'h0x0)
                                        begin
                                            next_stype = S_S1;
                                        end 
                                    else if(func3 == 3'h0x1)
                                        begin 
                                            next_stype = S_S2;
                                        end 
                                    else if(func3 == 3'h0x2)
                                        begin 
                                            next_stype = S_S3;
                                        end 
                                end 
                            stype_done = 0;
                            aluSrc = 1;
                            isByte = 0;
                            isHalf = 0;
                            isWord = 0;
                            memWrite = 0;
                        end 
                    S_S1:
                        begin 
                            isByte = 1;
                            memWrite = 1;
                            next_stype = F_S4;
                        end 
                    S_S2:
                        begin 
                            isHalf = 1;
                            memWrite = 1;
                            next_stype = F_S4;
                        end
                    S_S3:
                        begin 
                            isWord = 1;
                            memWrite = 1;
                            next_stype = F_S4;
                        end
                    S_S4:
                        begin 
                            isByte = 0;
                            isHalf = 0;
                            isWord = 0;
                            memWrite = 0;
                            aluSrc = 0;
                            stype_done = 1;
                            next_stype = S_S0;
                        end
                    default:
                        begin 
                            stype_done = 0;
                            next_stype = curr_stype;
                        end 
                endcase 
            end 
    end 

//----- Branching FSM -----//
b_state_t curr_btype, next_btype;
always @(posedge clk or posedge reset)
    begin 
        if(reset)
            begin 
                curr_btype = B_S0;
                next_btype = B_S0;
            end 
        else 
            curr_btype = next_btype;
        
        if(go_branching)
            begin 
                case(curr_btype)
                    B_S0:
                        begin 
                            branching_done = 0;
                            pc_select = 0;
                            pcEn = 0;
                            if(go_branching)
                                begin 
                                    if(comparator)
                                        begin 
                                            next_btype = B_S1;
                                        end 
                                    else    
                                        next_btype = B_S2;
                                end 
                        end 
                    B_S1:
                        begin 
                            pc_select = 2'b01;
                            pcEn = 1;
                            next_btype = B_S3;
                        end
                    B_S2: 
                        begin 
                            next_btype = B_S3;
                        end 
                    B_S3:
                        begin
                            pcEn = 0;
                            pc_select = 2'b0;
                            branching_done = 1;
                        end 
                    default:
                        begin 
                            next_btype = curr_btype;
                            branching_done = 0;
                        end 
                endcase 
            end 
    end 

//------ JAL FSM ------//
jal_state_t curr_jal, next_jal;
always @(posedge clk or posedge reset)
    begin 
        if(reset)
            begin 
                curr_jal = JAL_S0;
                next_jal = JAL_S0
            end 
        else 
            curr_jal = next_jal;

        if(go_jal)
            begin
                case(curr_jal)
                    JAL_S0:
                        begin
                            next_jal = (go_jal) ? JAL_S1 : JAL_S0;
                            memToReg = 2'b2;
                            jal_done = 0
                            regWrite = 0;
                            pc_select = 2'b0;
                            pcEn = 0;
                        end 
                    JAL_S1:
                        begin 
                            regWrite = 1;
                            pc_select = 2'b2;
                            pcEn = 1;
                            next_jal = JAL_S2;
                            jal_done = 0;
                        end 
                    JAL_S2:
                        begin 
                            regWrite = 0;
                            pc_select = 2'b0;
                            memToReg = 2'b0;
                            pcEn = 0;
                            jal_done = 1;
                            next_jal = JAL_S0;
                        end 
                    default:
                        begin 
                            next_jal = curr_jal;
                            jal_done = 0;
                        end 
                endcase 
            end 
    end 

//----- JALR FSM -----// 
jalr_state_t curr_jalr, next_jalr;
always @(posedge clk or posedge reset)
    begin 
        if(reset)
            begin 
                curr_jalr = JALR_S0;
                next_jalr = JALR_S0;
            end 
        else
            curr_jalr = next_jalr;

        if(go_jalr)
            begin 
                case(curr_jalr)
                    JALR_S0:
                        begin 
                            jalr_done = 0;
                            memToReg = 2'b2;
                            pc_select = 2'b0;
                            pcEn = 0;
                            regWrite = 0;
                            next_jalr = (go_jalr) ? JALR_S1 : JALR_S0;
                        end 
                    JALR_S1:
                        begin 
                            pc_select = 2'b3;
                            pcEn = 1;
                            regWrite = 1;
                            jalr_done = 0;
                            next_jalr = JALR_S2;
                        end
                    JALR_S2:
                        begin 
                            pc_select = 2'b0;
                            pcEn = 0;
                            regWrite = 0;
                            memToReg = 2'b0;
                            jalr_done = 1;
                            next_jalr = JALR_S0;
                        end
                    default:
                        begin 
                            jalr_done = 0;
                            next_jalr = curr_jalr;
                        end
                endcase
            end
    end





endmodule
