`timescale 1ns / 1ps

module ID(
     input        clk,
     input [31:0] PC_ID, INSTR_ID,
     input        RegWrite_WB,
     input [31:0] ALUData_WB,
     input  [4:0] RD_WB,
    output [31:0] IMM_ID,
    output [31:0] RegData1_ID, RegData2_ID,
    output  [2:0] FN3_ID,
    output  [6:0] FN7_ID,
    output  [6:0] OPC_ID,
    output  [4:0] RD_ID,
    output  [4:0] RS1_ID, RS2_ID
);

REGS    regbank(clk, RegWrite_WB, RS1_ID, RS2_ID, RD_WB, ALUData_WB, RegData1_ID, RegData2_ID);
IMM_GEN imm(INSTR_ID, IMM_ID);

assign FN3_ID = INSTR_ID[14:12];
assign FN7_ID = INSTR_ID[31:25];
assign OPC_ID = INSTR_ID[ 6: 0];
assign RD_ID  = INSTR_ID[11: 7];
assign RS1_ID = INSTR_ID[19:15];
assign RS2_ID = INSTR_ID[24:20];

endmodule
