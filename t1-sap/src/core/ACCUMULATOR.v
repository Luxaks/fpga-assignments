`timescale 1ns / 1ps

module ACCUMULATOR(
    input wire clk, reset, read,
    input wire[5:0] ival,
    output reg do_beq,
    output reg[5:0] oval
);

always @(posedge clk) begin
    if (reset) begin
        oval = 0;
    end
    else begin
        if (read == 1) begin
            oval = ival;
        end
     
        if (oval == 0) begin
            do_beq = 1;
        end
        else begin
            do_beq = 0;
        end
    end
end

endmodule
