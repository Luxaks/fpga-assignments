`timescale 1ns / 1ps

module BIN2BCD(
    input [5:0] val_bin,
    output [3:0] BCD0, BCD1
);

integer i;
reg[7:0] bcd;

always @(val_bin) begin
    bcd = 0;
    for (i = 0; i < 6; i = i + 1) begin
        bcd = {bcd[6:0], val_bin[5-i]};
        if (i < 5 && bcd[3:0] > 4) begin
            bcd[3:0] = bcd[3:0] + 3;
        end
        if (i < 5 && bcd[7:4] > 4) begin
            bcd[7:4] = bcd[7:4] + 3;
        end
    end
end

endmodule
