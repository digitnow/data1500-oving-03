# Besvarelse av refleksjonsspørsmål - DATA1500 Oppgavesett 1.3

Skriv dine svar på refleksjonsspørsmålene fra hver oppgave her.

---

## Oppgave 1: Docker-oppsett og PostgreSQL-tilkobling

### Spørsmål 1: Hva er fordelen med å bruke Docker i stedet for å installere PostgreSQL direkte på maskinen?

**Ditt svar:**

Ved å bruke en konteinerisert applikasjon så brukes en fastlåst tilstand med alle avhengigheter uavhengig av underliggende
operativsystem. Dette gjør følgende:
- Det skaper reproduserbarhet og kan kjøres av alle som har installert Docker (evt. containerd eller lignende).
- Det skaper mulighet for å rive ned samt spinne opp samme applikasjon igjen for å nullstille en tilstand.
- Det skaper mulighet for å dele et Docker images via Docker registries (eks. Azure Container Registry, docker.io) som
andre kan konsumere og reprodusere det eksakt samme oppsettet.

---

### Spørsmål 2: Hva betyr "persistent volum" i docker-compose.yml? Hvorfor er det viktig?

**Ditt svar:**

Docker images er per definisjon stateless. Dette betyr at dersom filer opprettes i konteineren
og konteineren restartes av en vilkårlig årsak, så er filsystemet tilbake til opprinnelig tilstand. Det vil
si at filene du har opprettet er borte.

For å løse dette er det mulig med persistent lagring via volumer. Det er flere typer volumer og avhenger av
eksempelvis om enkelte plugins er installert. Det enkleste formatet for volum, og som er innebygget i Docker Compose,
er mounting av lokale filstier inn i konteineren. Dersom man har en disk på maskinen som er mountet
opp på /data/postgres med 100G data og mounter denne inn på /var/lib/postgresql/data i konteineren, så vil dette være
tilgjengelig for Postgres. 

Andre alternativer for volumer er eksempelvis NFS eller S3.

---

### Spørsmål 3: Hva skjer når du kjører `docker-compose down`? Mister du dataene?

**Ditt svar:**

Kommandoen river ned konteinerne. Dersom det ikke er lagret på et volum, så ja, da mister man dataen sin.

---

### Spørsmål 4: Forklar hva som skjer når du kjører `docker-compose up -d` første gang vs. andre gang.

**Ditt svar:**

Første gang spinnes opp konteinerne i bakgrunnen (ref -d for detached mode). Dette gjør at man slipper å se
standard ut logger og kan navigere fritt videre i terminalen i stedet for å åpne et nytt vindu.

Dersom imaget ikke er pullet / finnes i den lokale registryet, så vil imaget hentes med docker pull.

Andre gang man kjører finnes imaget og det pulles ikke. Konteineren vil ikke gjøre noe som helst / lage konteineren på nytt,
dersom ingen instillinger har endret seg.

---

### Spørsmål 5: Hvordan ville du delt docker-compose.yml-filen med en annen student? Hvilke sikkerhetshensyn må du ta?

**Ditt svar:**

Brukernavn og passord er i klartekst. Det enkleste er å lage en `.env.example` fil med

```text
POSTGRES_USER='...'
POSTGRES_PASSWORD='...'
POSTGRES_DB: data1500_db
PGDATA: /var/lib/postgresql/data/pgdata
```

og heller benyttet `docker compose --env-file .env up -d` og sendt med docker compose filen samt .env.example.

---

## Oppgave 2: SQL-spørringer og databaseskjema

### Spørsmål 1: Hva er forskjellen mellom INNER JOIN og LEFT JOIN? Når bruker du hver av dem?

**Ditt svar:**

[Skriv ditt svar her]

---

### Spørsmål 2: Hvorfor bruker vi fremmednøkler? Hva skjer hvis du prøver å slette et program som har studenter?

**Ditt svar:**

[Skriv ditt svar her]

---

### Spørsmål 3: Forklar hva `GROUP BY` gjør og hvorfor det er nødvendig når du bruker aggregatfunksjoner.

**Ditt svar:**

[Skriv ditt svar her]

---

### Spørsmål 4: Hva er en indeks og hvorfor er den viktig for ytelse?

**Ditt svar:**

[Skriv ditt svar her]

---

### Spørsmål 5: Hvordan ville du optimalisert en spørring som er veldig treg?

**Ditt svar:**

[Skriv ditt svar her]

---

## Oppgave 3: Brukeradministrasjon og GRANT

### Spørsmål 1: Hva er prinsippet om minste rettighet? Hvorfor er det viktig?

**Ditt svar:**

[Skriv ditt svar her]

---

### Spørsmål 2: Hva er forskjellen mellom en bruker og en rolle i PostgreSQL?

**Ditt svar:**

[Skriv ditt svar her]

---

### Spørsmål 3: Hvorfor er det bedre å bruke roller enn å gi rettigheter direkte til brukere?

**Ditt svar:**

[Skriv ditt svar her]

---

### Spørsmål 4: Hva skjer hvis du gir en bruker `DROP` rettighet? Hvilke sikkerhetsproblemer kan det skape?

**Ditt svar:**

[Skriv ditt svar her]

---

### Spørsmål 5: Hvordan ville du implementert at en student bare kan se sine egne karakterer, ikke andres?

**Ditt svar:**

[Skriv ditt svar her]

---

## Notater og observasjoner

Bruk denne delen til å dokumentere interessante funn, problemer du møtte, eller andre observasjoner:

[Skriv dine notater her]


## Oppgave 4: Brukeradministrasjon og GRANT

1. **Hva er Row-Level Security og hvorfor er det viktig?**
   - Svar her...

2. **Hva er forskjellen mellom RLS og kolonnebegrenset tilgang?**
   - Svar her...

3. **Hvordan ville du implementert at en student bare kan se karakterer for sitt eget program?**
   - Svar her...

4. **Hva er sikkerhetsproblemene ved å bruke views i stedet for RLS?**
   - Svar her...

5. **Hvordan ville du testet at RLS-policyer fungerer korrekt?**
   - Svar her...

---

## Referanser

- PostgreSQL dokumentasjon: https://www.postgresql.org/docs/
- Docker dokumentasjon: https://docs.docker.com/

