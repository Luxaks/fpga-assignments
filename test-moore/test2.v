/*
 * Sa se implementeze un automat de stari care detecteaza secventa de biti 1101.
 * La intrare, la fiecare ciclu de ceas se primeste in portul `din`  un bit dintr-o secventa aleatoare "infinita"
 * Cand secventa 1101 este vazuta (practic pentru 4 cicli consecutivi, pe portul `din` sunt observati bitii din secventa), atunci `dout` trebuie sa fie setat pe `1` logic, altfel ramane `0` logic.
 * Exista un bit de reset care reseateaza automatul la starea initiala.
 * Implementarea trebuie facuta in stil MOORE!
 */

module solution(
    input wire clk,
    input wire reset,
    input wire din,
    output wire dout
);
    //TODO

/* sunt 5 cazuri => 3 biti
    0. starea initiala
    1. primit 1
    2. primit 1
    3. primit 0
    4. primit 1 => dout
de la 2 ramane la 2 daca primeste 1 (garantat are secventa 11)
de la 4 se intoarce fie la 0 (primit 0) fie direct la 2 (primeste 1 dupa cel final => are deja 11)
*/
    reg[2:0] state;
    reg      myout;
    
    // outputul este atribuit procedural, deci folosesc un registru auxiliar
    assign dout = myout;
    
    // cand se activeaza reset, revino la starea initiala
    always @(posedge reset)
        state = 0;
    
    // pe front pozitiv, calculeaza starea urmatoare in functie de input
    // outputul depinde de starea curenta, inputul afecteaza doar starea
    always @(posedge clk) begin
        case (state)
            0: begin
                myout = 0;
                if (din == 1)
                    state = 1;
            end
            
            1: begin
                myout = 0;
                if (din == 1)
                    state = 2;
                else
                    state = 0;
            end
            
            2: begin
                myout = 0;
                if (din == 0)
                    state = 3;
            end
            
            3: begin
                myout = 0;
                if (din == 1)
                    state = 4;
                else
                    state = 0;
            end
            
            4: begin
                myout = 1;
                if (din == 1)
                    state = 2;
                else
                    state = 0;
            end
        endcase
    end

endmodule


module tb;

    // 1. Semnale de interfata
    reg clk;
    reg reset;
    reg din;
    wire dout;

    // 2. Instantierea modulului proiectat
    solution uut (
        .clk(clk),
        .reset(reset),
        .din(din),
        .dout(dout)
    );

    // 3. Generarea ceasului (perioada de 10 unitati de timp)
    always begin
        #5 clk = ~clk;
    end

    // Pentru monitorizarea scorului
    integer teste_trecute = 0;
    integer teste_totale = 0;

    task trimite_si_verifica(input bit_trimit, input exp_dout);
        begin
            din = bit_trimit;
            @(posedge clk); // Asteptam frontul pe care automatul citeste `din` si isi schimba starea
            #1; // Mic delay dupa front pentru a lasa logica combinationala de iesire sa se stabilizeze
            
            teste_totale = teste_totale + 1;
            if (dout === exp_dout) begin
                teste_trecute = teste_trecute + 1;
            end else begin
                $display("[EROARE] La momentul %0t: s-a trimis din=%b. Se astepta dout=%b, dar s-a primit dout=%b", 
                         $time, bit_trimit, exp_dout, dout);
            end
        end
    endtask

    // 4. Stimulii de test
    initial begin
        // Setup grafic
        $dumpfile("moore.vcd");
        $dumpvars(0, tb);

        // Initializari
        clk = 0;
        reset = 1;
        din = 0;

        // Reset initial durata de 2 cicli
        @(posedge clk);
        @(posedge clk);
        #1 reset = 0;
        
        $display("--- Incepe testarea automatului Moore pentru secventa 1101 ---");

        // Cazul 1:
        if (dout !== 0) $display("[EROARE] Dupa reset, dout nu este 0!");

        // Cazul 2:
        trimite_si_verifica(1, 0); 
        trimite_si_verifica(1, 0); 
        trimite_si_verifica(0, 0); 
        trimite_si_verifica(1, 0); 
        trimite_si_verifica(0, 1); 

        // Cazul 3:
        trimite_si_verifica(1, 0); 
        trimite_si_verifica(1, 0); 
        trimite_si_verifica(0, 0); 
        trimite_si_verifica(1, 0); 
        trimite_si_verifica(1, 1); 
        trimite_si_verifica(0, 0); 
        trimite_si_verifica(1, 0); 
        trimite_si_verifica(0, 1); 

        // Cazul 4:
        trimite_si_verifica(1, 0); 
        trimite_si_verifica(1, 0); 
        #2 reset = 1;              
        @(posedge clk);
        #1 reset = 0;
        trimite_si_verifica(0, 0); 
        trimite_si_verifica(1, 0); 
        trimite_si_verifica(0, 0); 

        // Cazul 5:
        trimite_si_verifica(1, 0); 
        trimite_si_verifica(1, 0); 
        trimite_si_verifica(1, 0); 
        trimite_si_verifica(1, 0); 
        trimite_si_verifica(0, 0); 
        trimite_si_verifica(1, 0); 
        trimite_si_verifica(0, 1); 

        // Cazul 6:
        trimite_si_verifica(1, 0); 
        trimite_si_verifica(1, 0); 
        trimite_si_verifica(0, 0); 
        trimite_si_verifica(0, 0); 
        trimite_si_verifica(1, 0); 
        trimite_si_verifica(0, 0); 
        
        // Finalizare test
        $display("\n--- Rezultate Testare ---");
        $display("Teste trecute: %0d / %0d", teste_trecute, teste_totale);
        if (teste_trecute == teste_totale) begin
            $display("PASS");
        end else begin
            $display("FAIL");
        end

        $finish;
    end

endmodule

`default_nettype none
