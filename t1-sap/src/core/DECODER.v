`timescale 1ns / 1ps

module DECODER(
    input wire[7:0] instr,
    output reg opc, lda, put,
    output reg[5:0] imm_lda, imm_alu,
    output reg beq, halt
);

reg putchk;



always @(*) begin
    imm_lda =  instr[5:0];
    imm_alu = instr[5:0];
    opc     = instr[6];
    
    // LOAD / "STORE"
    if (instr[7] == 0) begin
        lda     = ~instr[6];
        putchk  =  instr[6];
        // OUT / HALT       
        if (putchk == 1) begin
            case (imm_lda)
                6'b000000: begin
                    put  = 1;
                    beq  = 0;
                    halt = 0;
                end
                6'b111111: begin
                    put  = 0;
                    beq  = 0;
                    halt = 1;
                
                end
                default: begin
                    put  = 0;
                    beq  = 1;   // imm_lda este valoarea de salt, deja setata
                    halt = 0;
                end
            endcase
        end
        else begin
            put  = 0;
            beq  = 0;
            halt = 0;
        end
    end
    // ADD / SUB
    else begin
        lda     = 0;
        put     = 0;
        beq     = 0;
        halt    = 0;
    end
end

endmodule
