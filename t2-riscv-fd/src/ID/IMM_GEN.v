`timescale 1ns / 1ps

/* lw       0000011
 * sw       0100011

 * addi     0010011
 * andi     0010011
 * ori      0010011
 * xori     0010011

 * slti     0010011
 * sltiu    0010011
 * srli     0010011
 * srai     0010011
 * slli     0010011

 * beq      1100011
 * bne      1100011
 * blt      1100011
 * bge      1100011
 * bltu     1100011
 * bgeu     1100011
 */

module IMM_GEN(
     input     [31:0] in,
    output reg [31:0] out
);

always @(in) begin
    case (in[6:0])
    7'b0000011: begin    // lw (type I)
        out[10:0]  = in[30:20];
        out[31:11] = {21{in[31]}};
    end
    7'b0100011: begin   // sw (type S)
        out[4:0]   = in[11:7];
        out[10:5]  = in[30:25];
        out[31:11] = {21{in[31]}};
    end
    7'b0010011: begin   // ALU (type I)
        out[10:0]  = in[30:20];
        out[31:11] = {21{in[31]}};
    end
    7'b1100011: begin   // branch (type B)
        out[0]     = 0;
        out[4:1]   = in[11:8];
        out[10:5]  = in[30:25];
        out[11]    = in[7];
        out[31:12] = {20{in[31]}};
    end
    default: begin
        out        = 32'b0;
    end
    endcase
end

endmodule
