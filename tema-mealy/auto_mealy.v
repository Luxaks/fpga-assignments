module automat_mealy(
    input [2:0] bani,
    input srq, rrq, clk,
    output reg soda, err, rest_50, rest_100
);

/*
 * bani = input 50 bani, 1 leu, 2 lei
 * srq = soda request
 * rrq = rest request
 * clk = semnalul de ceas
 *
 * soda = bautura!
 * rest_50  = 50 bani rest
 * rest_100 = 1 leu rest
 * err = eroare (plata peste 10 lei, rest la 0 lei, bautura sub 4 lei)
 *
 * iesirile sunt declarate reg deoarece (din cat am incercat)
 * icarus nu suporta assign wire (interpreteaza ca procedural)
 */

reg[4:0] suma;  //folosit si ca contor, si ca registru de stare
                //(din moment ce fiecare suma reprezinta o stare unica)

reg rest_ok;    //daca se da rest acum

initial begin
    //$dumpfile("mealy.vcd");
    //$dumpvars(0, automat_mealy);

    suma = 0;
    rest_ok = 0;
end

always @(posedge clk) begin
    err = 0;
    soda = 0;
    rest_50 = 0;
    rest_100 = 0;

    // automatul functioneaza daca nu da deja rest
    if (!rest_ok) begin

    // introducerea banilor are prioritate
    // se comporta ca un program imperativ obisnuit
    if      (bani[0]) suma = suma + 1;
    else if (bani[1]) suma = suma + 2;
    else if (bani[2]) suma = suma + 4;
    if (suma > 20) begin
        suma = 20;
        err = 1;
    end

    // daca nu se introduc bani, verifica celelalte 2 semnale
    // NOTA: in xilinx probabil se poate scrie doar (bani == 0), dar icarus nu suporta sintaxa
    if (bani[0] == 0 && bani[1] == 0 && bani[2] == 0) begin
        if (srq) begin
            if (suma >= 8) begin
                suma = suma - 8;
                soda = 1;
            end
            else err = 1;
        end
        else if (rrq) begin
            if (suma > 0) rest_ok = 1;
            else err = 1;
        end
    end

    end

    // daca trebuie sa dam rest
    if (rest_ok) begin
    
    if (suma > 1) begin
        suma = suma - 2;
        rest_100 = 1;
    end
    else if (suma > 0) begin
        suma = suma - 1;
        rest_50 = 1;
    end
    if (!suma) rest_ok = 0;

    end
end

endmodule
