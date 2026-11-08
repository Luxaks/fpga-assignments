`timescale 1ns / 1ps

module DIVCLK(
    input  clk_in, reset,
    output clk_out_led, clk_out_seg 
);

reg [27:0] ctr=0;

always @(posedge clk_in) begin
    if (reset) begin
        ctr <= 0;
    end
    else begin
        ctr <= ctr + 1;
    end
end

assign clk_out_led = ctr[26];
assign clk_out_seg = ctr[17];

endmodule
