`timescale 1ns / 1ps

module IF(
     input        clk, rst,
     input        PCSrc, PC_write,
     input [31:0] PC_branch,
    output [31:0] PC_IF, INSTR_IF
);

wire [31:0] PC_if4, PC_mux;

MUX2_1    mux(PC_if4, PC_branch, PCSrc, PC_mux);
PC        pcnt(clk, rst, PC_write, PC_mux, PC_IF);
ADDER     sigma(PC_IF, 4, PC_if4);
INSTR_MEM imem(PC_IF[11:2], INSTR_IF);

endmodule
