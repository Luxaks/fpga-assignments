`timescale 1ns / 1ps

module RISCV_IF_ID(
     input        clk, rst,
     
     input        IF_ID_write,              // scrie in reg pipeline
     input        PCSrc, PC_write,          // scrie in PC
     input [31:0] PC_branch,                // sari in PC
     
     input        RegWrite_WB,              // scrie in registru
     input [31:0] ALUData_WB,               // rezultat ALU
     input  [4:0] RD_WB,                    // registrul destinatie
     
    output [31:0] PC_ID, INSTR_ID,          // adresa curenta si instructiunea
    output [31:0] IMM_ID,                   // valoare imediata
    output [31:0] RegData1_ID, RegData2_ID, // valorile registrilor cititi
    
    output  [2:0] FN3_ID,                   // cimpul funct3 al instr.
    output  [6:0] FN7_ID,                   // cimpul funct7 al instr.
    output  [6:0] OPC_ID,                   // opcode curent
    output  [4:0] RD_ID,                    // registru destinatie
    output  [4:0] RS1_ID, RS2_ID            // registri sursa
);

wire [31:0] PC_IF, INSTR_IF;

IF_ID_PIPE pipe(clk, rst, IF_ID_write, PC_IF, INSTR_IF, PC_ID, INSTR_ID);

IF  fetch(clk, rst, PCSrc, PC_write, PC_branch, PC_IF, INSTR_IF);
ID  decode(clk, PC_ID, INSTR_ID, RegWrite_WB, ALUData_WB, RD_WB,
      IMM_ID, RegData1_ID, RegData2_ID, FN3_ID, FN7_ID, OPC_ID, RD_ID, RS1_ID, RS2_ID);

endmodule
