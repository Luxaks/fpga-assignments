# CERINTA

Procesor tip SAP-1 8-bit pe un ciclu de ceas.

Recunoaste dupa primii 2 biti operatiile `LDA` (00), `ADD` (11), `SUB` (10), `OUT` si `HALT` (01). 
Pentru primele 3 se foloseste ca parametru valoarea imediata codificata in ceilalti 6 biti. Pentru celelalte 2 valoarea imediata are semnificatie speciala (toti 0 pentru `OUT`, toti 1 pentru `HALT`).

Bonus: implementarea instructiunii `BEQ` (01 + offset), nu pare sa functioneze.

# IMPLEMENTARE

Fisierele sunt organizate ierarhic:
- **src**: sursele in sine
    - **core**: procesorul de baza (poate fi simulat)
        - `ACCUMULATOR`: registrul
        - `ALU`: unitatea aritmetico-logica (executa `+` sau `-`)
        - `DECODER`: decodifica instructiunea (trimite valoarea imediata si semnale de control)
        - `MUX2_1`: trece in registru valoarea imediata, sau cea de la ALU
        - `PC`: program counter, incrementeaza cu 1 la fiecare ciclu (pentru `BEQ` trebuie si rescris)
        - `cpu`: modulul de baza al procesorului
        - `memory`: incarca fisierul de program in memorie pentru a fi executat
    - **external**: legatura cu lumea exterioara (pentru FPGA)
        - `afisare_7seg`: afiseaza numarul pe un 7 segment display
        - `bin2bcd`: converteste numarul in format binary-coded decimal
        - `divizor_ceas`: divizeaza perioada ceasului pentru a fi perceputa de om
- **sim**: fisiere de testare
    - `code` si `code2`: fisierele de program
    - `cpu_tb`: testbench
    - `Nexys7`: fisier constringeri Nexys4 pentru FPGA Artix7 de la laborator

Detalii se regasesc si in comentariile din fisierele sursa.

# RULARE

Se incarca fisierele in Vivado si se stabileste `cpu_tb` ca baza (Set as Top).

Pentru simulare, `Run Simulation` si se observa graficul.

Pentru FPGA, se sintetizeaza (cel mai probabil nu va functiona).

# SURSE

* repozitoriul pentru cerinta
