# CERINTA

Procesor tip RISC-V, partea IF si ID.

Instructiunile si arhitectura sunt bazate integral pe specificatia originala.

# IMPLEMENTARE

Fisierele sunt organizate ierarhic:
- **src**: sursele in sine
    - `RISCV_ID_ID`: modulul de baza al procesorului
    - `IF_ID_PIPE`: registrul de pipeline intre IF si ID
    - **IF**: etapa Instruction Fetch
        - `PC`: program counter
        - `INSTR_MEM`: memoria de program (instructiunile)
        - `ADDER`: adauga 4 la adresa curenta
        - `MUX2_1`: alege daca PC primeste adresa+4 sau o adresa directa
        - `IF`: leaga toate modulele de IF
    - **ID**: etapa Instruction Decode
        - `REGS`: bancul de registri
        - `IMM_GEN`: stabileste valoarea imediata
        - `ID`: leaga cele 2 submodule si stabileste componentele instructiunii
- **sim**: fisiere de testare
    - `code`: fisierul de program
    - `RISCV_TB`: testbench
    - `RISCV_TB_behav`: fisier configurare grafic

Detalii se regasesc si in comentariile din fisierele sursa.

# RULARE

Se incarca fisierele in Vivado si se stabileste `RISCV_TB` ca baza (Set as Top).

Pentru simulare, `Run Simulation` si se observa graficul.

# SURSE

* fisierele din **docs**
