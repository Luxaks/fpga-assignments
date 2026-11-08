module test_mealy();

reg clk;
reg [2:0] bani;
reg srq, rrq;
wire soda, err, rest_50, rest_100;

automat_mealy AM (bani, srq, rrq, clk, soda, err, rest_50, rest_100);

initial begin
    $dumpfile("mealy.vcd");
    $dumpvars(0, test_mealy);

    clk = 0;
    srq = 0;
    rrq = 0;
    bani = 0;
 
    $display("0. Stare initiala");
    clk = 1;
 #1 $display("Suc %d. Eroare %d. Rest %d,%0d0.\n", soda, err, rest_100, 5 * rest_50);

    $display("1. Rest fara bani");
    clk = 0;
    rrq = 1;
    clk = 1;
 #1 $display("Suc %d. Eroare %d. Rest %d,%0d0.\n", soda, err, rest_100, 5 * rest_50); 

    $display("2. Introducere 50 bani");
    clk = 0;
    rrq = 0;
    bani[0] = 1;
    clk = 1;
 #1 $display("Suc %d. Eroare %d. Rest %d,%0d0.\n", soda, err, rest_100, 5 * rest_50);

    $display("3. Se mai introduc 3 lei. Suc cu fonduri insuficiente (3,50)");
    clk = 0;
    bani[0] = 0;
    bani[1] = 1;
 #1 clk = 1;
 #1 clk = 0;
    bani[1] = 0;
    bani[2] = 1;
 #1 clk = 1;
 #1 clk = 0;
    bani = 0;
    srq = 1;
    clk = 1;
 #1 $display("Suc %d. Eroare %d. Rest %d,%0d0.\n", soda, err, rest_100, 5 * rest_50);


    $display("4. Se ajunge la 5,50 si se obtine suc. La al doilea suc eroare");
    clk = 0;
    srq = 0;
    bani[2] = 1;
 #1 clk = 1;
 #1 clk = 0;
    bani = 0;
    srq = 1;
    clk = 1;
 #1 $display("Suc %d. Eroare %d. Rest %d,%0d0.", soda, err, rest_100, 5 * rest_50);
    clk = 0;
    clk = 1;
 #1 $display("Suc %d. Eroare %d. Rest %d,%0d0.\n", soda, err, rest_100, 5 * rest_50);

    $display("5. Rest 1,50. Intoarcerea restului continua fara semnal");
    clk = 0;
    srq = 0;
    rrq = 1;
    clk = 1;
 #1 $display("Suc %d. Eroare %d. Rest %d,%0d0.", soda, err, rest_100, 5 * rest_50);
    clk = 0;
    rrq = 0;
    clk = 1;
 #1 $display("Suc %d. Eroare %d. Rest %d,%0d0.", soda, err, rest_100, 5 * rest_50);
    clk = 0;
    clk = 1;
 #1 $display("Suc %d. Eroare %d. Rest %d,%0d0.\n", soda, err, rest_100, 5 * rest_50);

    $display("6. Se mai introduc 2,50, returnati. Inca un rest produce eroare");
    clk = 0;
    bani[2] = 1;
 #1 clk = 1;
 #1 clk = 0;
    bani[0] = 1;
 #1 clk = 1;
 #1 clk = 0;
    bani = 0;
    rrq = 1;
    clk = 1;
 #1 $display("Suc %d. Eroare %d. Rest %d,%0d0.", soda, err, rest_100, 5 * rest_50);
    clk = 0;
    clk = 1;
 #1 $display("Suc %d. Eroare %d. Rest %d,%0d0.", soda, err, rest_100, 5 * rest_50);
    clk = 0;
    clk = 1;
 #1 $display("Suc %d. Eroare %d. Rest %d,%0d0.", soda, err, rest_100, 5 * rest_50);
    clk = 0;
    clk = 1;
 #1 $display("Suc %d. Eroare %d. Rest %d,%0d0.\n", soda, err, rest_100, 5 * rest_50);

    $display("7. Max 10 lei");
    clk = 0;
    bani[2] = 1;
 #1 clk = 1;
 #1 clk = 0;
 #1 clk = 1;
 #1 clk = 0;
 #1 clk = 1;
 #1 clk = 0;
 #1 clk = 1;
 #1 clk = 0;
    clk = 1;
 #1 $display("Ajungem la 10 lei, eroare: %d.", err);
    clk = 0;
    clk = 1;
 #1 $display("Incercam 12 lei, eroare: %d.\n", err);
end

endmodule
