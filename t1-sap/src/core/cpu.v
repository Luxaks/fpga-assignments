module CPU(
    input clk,
    input reset,
//    output wire[5:0] acc,
//    output [7:0] current_address,
    output [7:0] An,
    output [6:0] Seg,
    output DP
);

    wire divclk, divclk_out;
    DIVCLK divizor(clk, reset, divclk, divclk_out);
    
    // citeste noua adresa a instructiunii ce urmeaza a fi executata
    wire [7:0] current_address;
    wire IS_BEQ, DO_BEQ;
    wire [5:0] A;
    wire HALT;
    PC program_counter(divclk, reset, IS_BEQ, DO_BEQ, ~HALT, A, current_address);

    //citeste instructiunea ce urmeaza a fi executata
    wire [7:0] current_instr;
    MEMORY instruction_memory(current_address, current_instr);

    //decodifica semalele de control si datele instructiunii curente 
    wire OP;
    wire LOAD_ACC;
    wire OUT_ACC;
    wire [5:0] B;
    DECODER instruction_decoder(current_instr, OP, LOAD_ACC, OUT_ACC, A, B, IS_BEQ, HALT);

    //incarca sau citeste date in/din registrul accumularor
    wire [5:0] ACC_IN, ACC_OUT;
    wire [5:0] ALU_OUT;
    MUX2_1 acc_selector(LOAD_ACC, ALU_OUT, A, ACC_IN);
    ACCUMULATOR acc_reg(divclk, reset, ~OUT_ACC, ACC_IN, DO_BEQ, ACC_OUT);

    //calculeaza noua valoare si trimite-o la registrul accumulator
    ALU compute_unit(OP, ACC_OUT, B, ALU_OUT);

    // scoate la output valoarea curenta a accumulatorului pentru debugging
//    assign acc = ACC_OUT;
    
    wire[3:0] bcd0, bcd1;
    BIN2BCD conv(ACC_OUT, bcd0, bcd1);
    A7SEG afisaj(divclk_out, reset, bcd0, bcd1, 4'b0000, 4'b0000, An, Seg, DP);
endmodule
