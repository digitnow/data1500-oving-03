-- Oppgave 1: Opprett en rolle program_ansvarlig som kan lese og oppdatere programmer-tabellen, men ikke slette
/*
Her antar jeg at denne rollen _ikke_ skal ha tilgang til å legge til nye programmer
da dette ikke er spesifisert.
*/
CREATE ROLE programmer_ansvarlig LOGIN PASSWORD 'programmer_pass';
GRANT SELECT, UPDATE ON programmer TO programmer_ansvarlig;

-- Oppgave 2: Opprett en rolle student_self_view som bare kan se egen studentdata
/*
Denne var veldig uklar. Hvilke data eier rollen student_self_view?
Hvilken person i datasettet skal denne rollen representere?
*/
CREATE ROLE student_self_view LOGIN PASSWORD 'student_pass';

/*
CREATE VIEW student_self_view_table AS
SELECT * FROM studenter
WHERE .... = current_user;

GRANT SELECT ON student_self_view_table TO student_self_view;
*/

-- Oppgave 3: Gi foreleser_role tilgang til å lese fra student_view
GRANT SELECT ON student_view TO foreleser_role;

-- Oppgave 4: Opprett en rolle backup_bruker som bare har SELECT-rettigheter på alle tabeller
CREATE ROLE backup_bruker LOGIN PASSWORD 'backup_pass';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO backup_bruker;

-- Oppgave 5: Lag en oversikt over alle roller og deres rettigheter
SELECT grantee, privilege_type, table_name FROM information_schema.role_table_grants