CREATE TABLESPACE cln78 LOCATION '/Users/aleksandrbabushkin/ITMO/s7-dbms-lab2/node/cln78';

ALTER DATABASE template1 SET TABLESPACE cln78;

CREATE DATABASE wetredsoup WITH TEMPLATE template0 OWNER aleksandrbabushkin TABLESPACE cln78;

CREATE ROLE newrole WITH LOGIN PASSWORD 'pass';

ALTER USER aleksandrbabushkin WITH PASSWORD '44';

\c "host=localhost port=9414 dbname=wetredsoup user=aleksandrbabushkin password=44"
GRANT USAGE ON SCHEMA public TO newrole;
GRANT CREATE ON SCHEMA public TO newrole;
GRANT ALL ON TABLESPACE cln78 TO newrole;

\c "host=localhost port=9414 dbname=wetredsoup user=newrole password=pass"

CREATE TABLE test (
    id SERIAL PRIMARY KEY,
    data_value TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) TABLESPACE cln78;

INSERT INTO test (data_value) VALUES
('Тестовые данные 1'),
('Тестовые данные 2'),
('Тестовые данные 3');

-- Проверка табличных пространств
\c "host=localhost port=9414 dbname=postgres user=aleksandrbabushkin password=44"
\pset pager off
WITH db_tablespaces AS (
    SELECT t.spcname, d.datname
    FROM pg_tablespace t
    JOIN pg_database d ON d.dattablespace = t.oid
)
SELECT
    t.spcname,
    COALESCE(string_agg(DISTINCT c.relname, E'\n'), 'No objects') AS objects,
    string_agg(DISTINCT db.datname, ', ') AS databases_in
FROM pg_tablespace t
LEFT JOIN pg_class c ON c.reltablespace = t.oid OR (c.reltablespace = 0 AND t.spcname = 'pg_default')
LEFT JOIN db_tablespaces db ON t.spcname = db.spcname
GROUP BY t.spcname
ORDER BY t.spcname;