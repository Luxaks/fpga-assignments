`timescale 1ns / 1ps

module ADDER(
     input     [31:0] ina, inb,
    output reg [31:0] out
);

always @(*) begin
    out = ina + inb;
end

endmodule
