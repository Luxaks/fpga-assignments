`timescale 1ns / 1ps

module INSTR_MEM(
     input      [9:0] address,
    output reg [31:0] instr
);

reg [31:0] codemem [0:1023];
integer i;

initial $readmemh("code.mem", codemem);

always @(address) begin
    instr = codemem[address];
end

endmodule
