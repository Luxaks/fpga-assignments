# CERINTA

automat de tip Mealy. se poate elibera la cerere produsul sau tot restul ramas.

accepta 3 tipuri de bani (50 bani, 1 leu, 2 lei) si elibereaza rest doar in primele 2 tipuri.
poate da un singur tip de rest pe perioada de ceas incepand cu cel mai mare si va da tot restul.

automatul poate doar acumula bani, elibera un produs sau da rest pe o perioada de ceas.
bautura cumparata costa 4 lei.

se pot introduce bani doar pana la maxim 10 lei dupa care trebuie sa cereti produs sau rest.
oricand după cererea unui produs se mai pot introduce bani sau se poate cere inca un produs.

# IMPLEMENTARE

am creat automatul in fisierul `auto_mealy.v` si un modul de testare in `test.v`.
automatul primeste semnale corespunzatoare cu:
* ceasul
* banii mentionati
* cerere de bautura sau rest

si produce semnale ce semnifica:
* returnare bautura
* returnare rest (50 bani sau 1 leu)
* eroare.

pentru a mentine starea, automatul foloseste un registru care memoreaza suma curenta introdusa.
aceasta este folosita si pentru codificarea starilor (aduna bani pana la 10 lei,
cu diferite raspunsuri (sau nimic) in functie de cereri la suma curenta).

din cauza modului de implementare a banilor, valoarea sumei este in realitate dublata
(merge pana la 20 si creste cu 1,2,4 in loc de .5,1,2; bautura costa 8).

detalii se regasesc si in comentariile din fisierele sursa.

# RULARE

```bash
$ iverilog -g2005-sv -s test_mealy -o MEALY test.v auto_mealy.v && ./MEALY
```

pentru verificarea rezultatelor se poate inspecta fisierul de test sau graficul `.vcd`
(operatiile efectuate corespund cu descrierile din terminal).

# SURSE

* [documentatia icarus](https://steveicarus.github.io/iverilog/)
* [tutorial verilog](https://www.chipverify.com/verilog/)
