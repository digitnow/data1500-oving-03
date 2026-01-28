# Rettelser #1 2026-01-28 (feilen oppdaget av student)

## 3.2 Hent gjennomsnittlig karakter per emne

```sql
SELECT 
    e.emne_navn,
    AVG(CAST(SUBSTRING(er.karakter, 1, 1) AS INT)) as gjennomsnitt
FROM emneregistreringer er
JOIN emner e ON er.emne_id = e.emne_id
WHERE er.karakter IS NOT NULL
GROUP BY e.emne_id, e.emne_navn;
```
Gir følgende output:

```
ERROR:  invalid input syntax for type integer: "B"
```

Grunnen er at `CAST`-funksjonen kan ikke endre typen til karakter `B`, som er en tekststreng, til tall av type `int`. Det hjelper heller ikke å konvertere `B` til ASCII-kode, da vi ønsker å regne ut gjennomsnittskarakter. 

En løsning er å bruke CASE-strukturen, som gir mulighet å gjøre mappingen direkte i spørringen (bruker også ROUND-funksjon for å avrunde til 2 desimaler):
```sql
SELECT 
    e.emne_navn,
    ROUND(AVG(
        CASE SUBSTRING(er.karakter, 1, 1)
            WHEN 'A' THEN 5
            WHEN 'B' THEN 4
            WHEN 'C' THEN 3
            WHEN 'D' THEN 2
            WHEN 'E' THEN 1
            WHEN 'F' THEN 0
            ELSE NULL -- Ignorerer evt. andre verdier
        END
    ), 2) as gjennomsnitt
FROM emneregistreringer er
JOIN emner e ON er.emne_id = e.emne_id
WHERE er.karakter IS NOT NULL
GROUP BY e.emne_id, e.emne_navn;
```

En annen løsning er å bruke en ekstra tabell `tallkarakterer`.

```sql
create table tallkarakterer (
    tallkarakter int unique, 
    bokstavkarakter VARCHAR(1) unique);

insert into tallkarakterer values 
    (0,'F'), (1,'E'), (2, 'D'), 
    (3, 'C'), (4, 'B'), (5, 'A');

select e.emne_navn, avg(tk.tallkarakter) 
from emneregistreringer er 
    join emner e on er.emne_id = e.emne_id 
    join tallkarakterer tk on tk.bokstavkarakter=er.karakter 
where er.karakter is not null 
group by e.emne_id, e.emne_navn;
```

*Gjør selv en øvelse, hvor du konverterer tilbake til bokstavkarakteren, dvs. den gjennomsnittlige karakteren for hvert emne presenteres med bokstav (A-F).*
