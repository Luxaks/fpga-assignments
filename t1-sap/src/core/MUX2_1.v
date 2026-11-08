`timescale 1ns / 1ps

module MUX2_1(
    input wire load,
    input wire[5:0] alu_res, imm,
    output reg[5:0] acc_val
);

always @(*) begin
    if (load == 1) begin
        acc_val = imm;
    end
    else begin
        acc_val = alu_res;
    end
end

endmodule
