# CERINTA

automat de tip Moore. se identifica secventa 1101 intr-un flux infinit, cu suprapuneri.

accepta 1 bit de intrare (semnalul curent) si are 1 bit de iesire (secventa detectata).

# IMPLEMENTARE

fisierul `test2.v` contine automatul si modulul de testare.

pentru a mentine starea, automatul foloseste un registru simplu care codifica starea numeric (0->4).
fiind un automat de tip moore, pentru fiecare stare da un output apoi tranzitioneaza in functie de input.

detalii se regasesc si in comentariile din fisierul sursa.

# RULARE

```bash
$ iverilog -s tb -o MOORE test2.v && ./MOORE
```

pentru verificarea rezultatelor si a implementarii de tip Moore se poate inspecta fisierul sursa sau graficul `.vcd`.

# SURSE

* mintea si memoria proprii (era gen examen)
