`timescale 1ns / 1ps

module PC(
     input            clk, rst, write,
     input     [31:0] in,
    output reg [31:0] out
);

always @(posedge clk) begin
    if (rst == 1) begin
        out = 32'b0;
    end
    else if (write == 1) begin
        out = in;
    end
end

endmodule
