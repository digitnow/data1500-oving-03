-- Oppgave 1: Hent alle studenter som ikke har noen emneregistreringer
SELECT
    s.student_id,
    s.fornavn,
    s.etternavn,
    COUNT(er.registrering_id) AS antall_emner
FROM studenter AS s
LEFT JOIN emneregistreringer AS er ON s.student_id = er.student_id
GROUP BY (s.student_id, s.fornavn, s.etternavn)
HAVING COUNT(er.registrering_id) = 0;

-- Oppgave 2: Hent alle emner som ingen studenter er registrert på
SELECT e.emne_id, e.emne_navn, COUNT(er.registrering_id) AS antall_paameldte FROM emner AS e
LEFT JOIN emneregistreringer AS er on e.emne_id = er.emne_id
GROUP BY (e.emne_id, e.emne_navn)
HAVING COUNT(er.registrering_id) = 0;

-- Oppgave 3: Hent studentene med høyeste karakter per emne
/*
 Det tryggeste er nok å konvertere 'A' til 1 via case matching for hver karakter og bruke tall.
 Men dette fungerer for dette enkle eksempelet pga alfabetisk rekkefølge på karakterene.
*/
SELECT s.fornavn, s.etternavn, er.emne_id, min(er.karakter) FROM emneregistreringer AS er
JOIN studenter AS s ON er.student_id = s.student_id
GROUP BY (s.fornavn, s.etternavn, er.emne_id);

-- Oppgave 4: Lag en rapport som viser hver student, deres program, og antall emner de er registrert på
SELECT fornavn, etternavn, p.program_navn, COUNT(emne_id) AS registreringer FROM (
    SELECT s.fornavn, s.etternavn, emne_id, s.program_id
    FROM studenter AS s
    RIGHT JOIN emneregistreringer AS er ON s.student_id = er.student_id
) AS student_signups
RIGHT JOIN programmer AS p ON student_signups.program_id = p.program_id
GROUP BY (fornavn, etternavn, p.program_navn)
ORDER BY registreringer DESC;

-- Oppgave 5: Hent alle studenter som er registrert på både DATA1500 og DATA1100
SELECT fornavn, etternavn, e.emne_kode FROM (SELECT s.fornavn, s.etternavn, er.emne_id
    FROM studenter AS s
    RIGHT JOIN emneregistreringer AS er ON s.student_id = er.student_id
) AS emneoversikt
LEFT JOIN emner AS e ON emneoversikt.emne_id = e.emne_id
WHERE e.emne_kode = 'DATA1500' OR e.emne_kode = 'DATA1100'