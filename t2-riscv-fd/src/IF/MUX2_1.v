`timescale 1ns / 1ps

module MUX2_1(
     input [31:0] ina, inb,
     input        sel,
    output [31:0] out
);

reg [31:0] myout;

always @(*) begin
    if (sel == 0) begin
        myout = ina;
    end
    else begin
        myout = inb;
    end
end

assign out = myout;

endmodule
