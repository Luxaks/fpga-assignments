`timescale 1ns / 1ps

module ALU(
    input wire op, //clk, // debug clock
    input wire [5:0] a, b, 
    output reg [5:0] out
);

always @(*) begin
    if (op == 1) begin
        out = a + b;
    end
    else begin
        out = a - b;
    end
end

endmodule
