`timescale 1ns / 1ps

module IF_ID_PIPE(
     input            clk, rst, write,
     input     [31:0] PC_IF, INSTR_IF,
    output reg [31:0] PC_ID, INSTR_ID
);

always @(posedge clk) begin
    if (rst == 1) begin
        PC_ID    = 32'b0;
        INSTR_ID = 32'b0;
    end
    else if (write == 1) begin
        PC_ID    = PC_IF;
        INSTR_ID = INSTR_IF;
    end
end

endmodule
