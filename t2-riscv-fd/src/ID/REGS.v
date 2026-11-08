`timescale 1ns / 1ps

module REGS(
     input        clk, write,
     input  [4:0] rs1, rs2, rd,
     input [31:0] data,
    output [31:0] ds1, ds2
);

reg [31:0] bank [0:31];

integer i;
initial for (i = 0; i < 32; i = i+1) begin
    bank[i] = i;
end

always @(posedge clk) begin
    if (write == 1) begin
        bank[rd] = data;
    end
end

assign ds1 = bank[rs1];
assign ds2 = bank[rs2];

endmodule
