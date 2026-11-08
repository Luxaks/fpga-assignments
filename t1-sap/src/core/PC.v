`timescale 1ns / 1ps

module PC(
    input wire clk, reset, is_beq, do_beq, no_halt,
    input wire[5:0] offt,
    output reg[7:0] addr
);

always @(posedge clk) begin
    if (reset) begin
        addr = 0;
    end
    else begin
        if (no_halt == 1) begin
            if (is_beq && do_beq) begin
                addr = addr + offt;
            end
            else begin
                addr  = addr + 1;
            end
        end
    end
end

endmodule
