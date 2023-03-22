`timescale 1ns / 1ns
`include "instruction_defines.v"
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

module controller(irEn, pcEn, pc_select, aluSrc, regWrite, memToReg, isByte, isHalf, isWord, memRead, memWrite, func7, func3, opcode, comparator, go_contr, clk, reset);

//------ OUTPUTS FROM CPU ------/
output reg       irEn;        // Enables the instruction register to fetch
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
input [6:0] func7;
input [2:0] func3;
input [6:0] opcode;
input       comparator;
input       clk;
input       reset;



//------ TYPEDEFS FOR STATES -------//
typedef enum {C_S0, C_S1, C_S2, C_S3, C_S4, C_S5, C_S6, C_S7} contr_state_t;                    // Main controller states
typedef enum {F_S0, F_S1, F_S2} fetch_state_t;                          // Instruction Fetch States
typedef enum {P_S0, P_S1, P_S2} pc_state_t;                             // Program counter update states
typedef enum {D_S0, D_S1, D_S2, D_S3, D_S4, D_S5, D_S6, D_S7, D_S8, D_S9, D_S10, D_S11, D_S12, D_S13, D_S14, D_S15} decode_state_t;  // Decode States
typedef enum {R_S0, R_S1, R_S2} r_state_t;                              // RTYPE States
typedef enum {I_S0, I_S1, I_S2} i_state_t;                              // ITYPE States
typedef enum {L_S0, L_S1, L_S2, L_S3, L_S4, L_S5} l_state_t;            // Load States  
typedef enum {S_S0, S_S1, S_S2, S_S3, S_S4} s_state_t;                  // Store States
typedef enum {B_S0, B_S1, B_S2, B_S3} b_state_t;                        // Branching States 
typedef enum {JAL_S0, JAL_S1, JAL_S2} jal_state_t;                      // JAL States
typedef enum {JALR_S0, JALR_S1, JALR_S2} jalr_state_t;                  // JALR States



//----- FLAGS -------// 
input   go_contr;           // Tells the controller to start
integer contr_done;          // Instruction finished

integer go_fetch;           // Tells the Fetch FSM to start
integer fetch_done;         // Tells the controller the Fetch FSM is done

integer go_pc;              // Tells the PC Update FSM to start
integer pc_done;            // Tells the controller the PC Update FSM is done

integer go_decode;          // Tells the decode FSM to start
integer decode_done;        // Tells the controller the Decode FSM is done

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


//---- Controller States ----// 
contr_state_t   curr_contr, next_contr;
fetch_state_t   curr_fetch, next_fetch;
pc_state_t      curr_pc, next_pc;
decode_state_t  curr_decode, next_decode;
r_state_t       curr_rtype, next_rtype;
i_state_t       curr_itype, next_itype;
l_state_t       curr_ltype, next_ltype;
s_state_t       curr_stype, next_stype;
b_state_t       curr_btype, next_btype;
jal_state_t     curr_jal, next_jal;
jalr_state_t    curr_jalr, next_jalr;


//-------- Controller ------// 
always @(posedge clk or posedge reset)
    begin
        if(reset)
            begin 
                // Outputs 
                irEn            = 0;
                pcEn            = 0;
                pc_select       = 2'b0;
                aluSrc          = 0;
                regWrite        = 0;
                memToReg        = 2'b0;
                isByte          = 0;
                isHalf          = 0;
                isWord          = 0;
                memRead         = 0;
                memWrite        = 0;

                // Flags 
                go_fetch        = 0;
                fetch_done      = 0;
                go_pc           = 0;
                pc_done         = 0;
                go_decode       = 0;
                decode_done     = 0;
                go_rtype        = 0;
                rtype_done      = 0;
                go_itype        = 0;
                itype_done      = 0;
                go_ltype        = 0;
                ltype_done      = 0;
                go_stype        = 0;
                stype_done      = 0;
                go_branching    = 0;
                branching_done  = 0;
                go_jal          = 0;
                jal_done        = 0;
                go_jalr         = 0;
                jalr_done       = 0;

                // Controller States
                curr_contr = C_S0;
                next_contr = C_S0;
                curr_fetch = F_S0;
                next_fetch = F_S0;
                curr_pc = P_S0;
                next_pc = P_S0;
                curr_decode = D_S0;
                next_decode = D_S0;
                curr_rtype = R_S0;
                next_rtype = R_S0;
                curr_itype = I_S0;
                next_itype = I_S0;
                curr_ltype = L_S0;
                next_ltype = L_S0;
                curr_stype = S_S0;
                next_stype = S_S0;
                curr_btype = B_S0;
                next_btype = B_S0;
                curr_jal = JAL_S0;
                next_jal = JAL_S0;
                curr_jalr = JALR_S0;
                next_jalr = JALR_S0;
            end
        else
            begin 

                //---- MAIN CONTROLLER -----//
                curr_contr = next_contr;
                if(go_contr)
                    begin 
                        case(curr_contr)
                            
                            // Check if we are good to go 
                            C_S0:
                                begin 
                                    next_contr = (go_contr) ? C_S1 : C_S0;
                                    contr_done = 0;
                                end
        
                            // Fetch the first operation 
                            C_S1:
                                begin 
                                    go_fetch = 1;
                                    next_contr = C_S2;
                                    contr_done = 0;
                                end 
                            
                            // Check if fetch is completed
                            C_S2:
                                begin 
                                    next_contr = (fetch_done) ? C_S3 : C_S2;
                                    contr_done = 0;
                                end 
                            
                            // Update the PC 
                            C_S3:
                                begin
                                    go_fetch = 0;
                                    go_pc = 1;
                                    next_contr = C_S4;
                                    contr_done = 0;
                                end
        
                            // Check if PC is done updating
                            C_S4:
                                begin 
                                    next_contr = (pc_done) ? C_S5 : C_S4;
                                    contr_done = 0;
                                end 
        
                            // Decode operations
                            C_S5:
                                begin 
                                    go_pc = 0;
                                    go_decode = 1;
                                    next_contr = C_S6;
                                    contr_done = 0;
                                end
        
                            // Check if decode is done
                            C_S6:
                                begin 
                                    next_contr = (decode_done) ? C_S7 : C_S6;
                                    contr_done = 0;
                                end 
        
                            // Mark the FSM as complete and restart
                            C_S7:
                                begin 
                                    go_fetch        = 0;
                                    go_pc           = 0;
                                    go_decode       = 0;
                                    go_rtype        = 0;
                                    go_itype        = 0;
                                    go_ltype        = 0;
                                    go_stype        = 0;
                                    go_jal          = 0;
                                    go_jalr         = 0;
                                    pc_done         = 0;
                                    rtype_done      = 0;
                                    itype_done      = 0;
                                    ltype_done      = 0;
                                    stype_done      = 0;
                                    jal_done        = 0;
                                    jalr_done       = 0;
                                    contr_done      = 1;
                                    next_contr      = C_S0;
                                end
        
                            // Default case
                            default:
                                begin 
                                    next_contr = curr_contr;
                                    contr_done = 0;
                                end
                        endcase
                    end 


                //------- FETCH CONTROLLER ------//
                curr_fetch = next_fetch;
                if(go_fetch)
                    begin
                        case(curr_fetch)
                            F_S0:
                                begin 
                                    next_fetch = (go_fetch) ? F_S1 : F_S0;
                                    irEn = 0;
                                    fetch_done = 0;
                                end
                            F_S1:
                                begin
                                    irEn = 1;
                                    fetch_done = 0;
                                    next_fetch = F_S2;
                                end
                            F_S2:
                                begin 
                                    irEn = 0;
                                    fetch_done = 1;
                                    go_fetch = 0;
                                    next_fetch = F_S0;
                                end
                            default:
                                begin 
                                    next_fetch = curr_fetch;
                                    fetch_done = 0;
                                end
                        endcase
                    end

                //----- PC CONTROLLER ------//
                curr_pc = next_pc;
                if(go_pc)
                    begin 
                        case(curr_pc)
                            P_S0:
                                begin 
                                    next_pc = (go_pc) ? P_S1 : P_S0;
                                    pcEn = 0;
                                    pc_select = 2'b0;
                                    pc_done = 0;
                                end
                            P_S1:
                                begin 
                                    pc_select = 2'b0;
                                    pcEn = 1;
                                    pc_done = 0;
                                    next_pc = P_S2;
                                end 
                            P_S2:
                                begin 
                                    pcEn = 0;
                                    pc_select = 2'b0;
                                    pc_done = 1;
                                    go_pc = 0;
                                    next_pc = P_S0;
                                end
                            default:
                                begin 
                                    next_pc = curr_pc;
                                    pc_done = 0;
                                end 
                        endcase
                    end

                //------- DECODE CONTROLLER ------// 
                curr_decode = next_decode;
                if(go_decode)
                    begin 
                        case(curr_decode)
                            D_S0:
                                begin
                                    if(go_decode)
                                        begin 
                                            case(opcode)
                                                `RTYPE:
                                                    next_decode = D_S1;
                                                `ITYPE:
                                                    next_decode = D_S3;
                                                `LOADTYPE:
                                                    next_decode = D_S5;
                                                `STYPE:
                                                    next_decode = D_S7;
                                                `BTYPE:
                                                    next_decode = D_S9;
                                                `JTYPE:
                                                    next_decode = D_S11;
                                                `JALRTYPE:
                                                    next_decode = D_S13;
                                                `LUITYPE:
                                                    next_decode = D_S3;
                                                `AUIPCTYPE:
                                                    next_decode = D_S3;
                                                
                                            endcase
                                            decode_done = 0;
                                        end
                                end
                            
                            // Trigger RTYPE FSM and check if it is finished
                            D_S1:
                                begin 
                                    go_rtype = 1;
                                    next_decode = D_S2;
                                    decode_done = 0;
                                end
                            D_S2:
                                begin 
                                    next_decode = (rtype_done) ? D_S15 : D_S2;
                                    decode_done = 0;
                                end

                            // Trigger ITYPE FSM and check if it is finished
                            D_S3:
                                begin 
                                    go_itype = 1;
                                    next_decode = D_S4;
                                    decode_done = 0;
                                end 
                            D_S4:
                                begin
                                    next_decode = (itype_done) ? D_S15 : D_S4;
                                    decode_done = 0;
                                end

                            // Trigger LOADTYPE FSM and check if it is finished
                            D_S5:
                                begin
                                    go_ltype = 1;
                                    next_decode = D_S6;
                                    decode_done = 0;
                                end
                            D_S6:
                                begin 
                                    next_decode = (ltype_done) ? D_S15 : D_S6;
                                    decode_done = 0;
                                end 

                            // Trigger STORETYPE FSM and check if it is finished
                            D_S7:
                                begin 
                                    go_stype = 1;
                                    next_decode = D_S8;
                                    decode_done = 0;
                                end 
                            D_S8:
                                begin 
                                    next_decode = (stype_done) ? D_S15 : D_S8;
                                    decode_done = 0;
                                end

                            // Trigger BRANCHING FSM and check if it is finished
                            D_S9:
                                begin 
                                    go_branching = 1;
                                    next_decode = D_S10;
                                    decode_done = 0;
                                end 
                            D_S10:
                                begin 
                                    next_decode = (branching_done) ? D_S15 : D_S10;
                                    decode_done = 0;
                                end

                            // Trigger JAL FSM and check if it is finished
                            D_S11:
                                begin 
                                    go_jal = 1;
                                    next_decode = D_S12;
                                    decode_done = 0;
                                end 
                            D_S12:
                                begin 
                                    next_decode = (jal_done) ? D_S15 : D_S12;
                                    decode_done = 0;
                                end

                            // Trigger JALR FSM and check if it is finished
                            D_S13:
                                begin 
                                    go_jalr = 1;
                                    next_decode = D_S14;
                                    decode_done = 0;
                                end
                            D_S14:
                                begin 
                                    next_decode = (jalr_done) ? D_S15 : D_S14;
                                    decode_done = 0;
                                end

                            // Mark Decode as done
                            D_S15:
                                begin 
                                    next_decode = D_S0;
                                    go_rtype        = 0;
                                    go_itype        = 0;
                                    go_ltype        = 0;
                                    go_stype        = 0;
                                    go_branching    = 0;
                                    go_jal          = 0;
                                    go_jalr         = 0;
                                    go_decode       = 0;
                                    decode_done     = 1;
                                end 

                            // Default Case
                            default:
                                begin 
                                    next_decode = curr_decode;
                                    decode_done = 0;
                                end
                        endcase
                    end

                //----- RTYPE CONTROLLER -----//
                curr_rtype = next_rtype;
                if(go_rtype)
                    begin 
                        case(curr_rtype)

                            // Check if we are good to go 
                            R_S0: 
                                begin 
                                    next_rtype = (go_rtype) ? R_S1 : R_S0;
                                    aluSrc = 0;
                                    memToReg = 2'b0;
                                    rtype_done = 0;
                                end 

                            // Set regWrite to 1 so we can write to the register file 
                            R_S1: 
                                begin 
                                        next_rtype = R_S2;
                                        regWrite = 1;
                                end 
                            
                            // Disable regWrite and mark this controller as done 
                            R_S2:
                                begin 
                                    next_rtype = R_S0;
                                    regWrite = 0;
                                    rtype_done = 1;
                                    go_rtype = 0;
                                end 
                            
                            // Default case 
                            default: 
                                begin
                                    next_rtype = curr_rtype;
                                    rtype_done = 0;
                                end 
                        endcase 
                    end

                //------ ITYPE CONTROLLER -----//
                curr_itype = next_itype;
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
                                    aluSrc = 1;
                                    regWrite = 0;
                                    itype_done = 1;
                                    go_itype = 0;
                                end 

                            // Default case 
                            default:
                                begin 
                                    next_itype = curr_itype;
                                    itype_done = 0;
                                end 

                        endcase 
                    end

                //----- LOAD TYPE CONTROLLER -----//
                curr_ltype = next_ltype;
                if(go_ltype)
                    begin 
                        case(curr_ltype)

                            // Check if we are good to go 
                            L_S0:
                                begin 
                                    if(go_ltype)
                                        if(func3 == 3'b000 || func3 == 3'b100)
                                            begin 
                                                next_ltype = L_S1;
                                            end 
                                        else if(func3 == 3'b001 || func3 == 3'b101)
                                            begin 
                                                next_ltype = L_S2;
                                            end 
                                        else if(func3 == 3'b010)
                                            begin 
                                                next_ltype = L_S3;
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
                                    go_ltype = 0;
                                end 

                            default:
                                begin 
                                    next_ltype = curr_ltype;
                                    ltype_done = 0;
                                end 
                        endcase 
                    end

                //---- STORE TYPE CONTROLLER -----//
                curr_stype = next_stype;
                if(go_stype)
                    begin 
                        case(curr_stype)
                            S_S0:
                                begin 
                                    if(go_stype)
                                        begin 
                                            if(func3 == 3'b000)
                                                begin
                                                    next_stype = S_S1;
                                                end 
                                            else if(func3 == 3'b001)
                                                begin 
                                                    next_stype = S_S2;
                                                end 
                                            else if(func3 == 3'b010)
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
                                    next_stype = S_S4;
                                end 
                            S_S2:
                                begin 
                                    isHalf = 1;
                                    memWrite = 1;
                                    next_stype = S_S4;
                                end
                            S_S3:
                                begin 
                                    isWord = 1;
                                    memWrite = 1;
                                    next_stype = S_S4;
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
                                    go_stype = 0;
                                end
                            default:
                                begin 
                                    stype_done = 0;
                                    next_stype = curr_stype;
                                end 
                        endcase 
                    end

                //------ BRANCHING TYPE CONTROLLER ----//
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
                                    next_btype = B_S0;
                                end 
                            default:
                                begin 
                                    next_btype = curr_btype;
                                    branching_done = 0;
                                end 
                        endcase 
                    end

                //----- JAL TYPE CONTROLLER ----//
                curr_jal = next_jal;
                if(go_jal)
                    begin
                        case(curr_jal)
                            JAL_S0:
                                begin
                                    next_jal = (go_jal) ? JAL_S1 : JAL_S0;
                                    memToReg = 2'b10;
                                    jal_done = 0;
                                    regWrite = 0;
                                    pc_select = 2'b0;
                                    pcEn = 0;
                                end 
                            JAL_S1:
                                begin 
                                    regWrite = 1;
                                    pc_select = 2'b10;
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
                                    go_jal = 0;
                                end 
                            default:
                                begin 
                                    next_jal = curr_jal;
                                    jal_done = 0;
                                end 
                        endcase 
                    end


                //------- JALR CONTROLLER -----//
                curr_jalr = next_jalr;
                if(go_jalr)
                    begin 
                        case(curr_jalr)
                            JALR_S0:
                                begin 
                                    jalr_done = 0;
                                    memToReg = 2'b10;
                                    pc_select = 2'b0;
                                    pcEn = 0;
                                    regWrite = 0;
                                    aluSrc = 1;
                                    next_jalr = (go_jalr) ? JALR_S1 : JALR_S0;
                                end 
                            JALR_S1:
                                begin 
                                    pc_select = 2'b11;
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
                                    aluSrc = 0;
                                    jalr_done = 1;
                                    next_jalr = JALR_S0;
                                    go_jalr = 0;
                                end
                            default:
                                begin 
                                    jalr_done = 0;
                                    next_jalr = curr_jalr;
                                end
                        endcase
                    end
            end 
    end 
endmodule
