\c "host=localhost port=9414 dbname=wetredsoup user=newrole password=pass"
SELECT * FROM test;

SELECT relname, reltablespace 
FROM pg_class 
WHERE relname = 'test';

SELECT pg_relation_filepath('test');

SELECT datname, spcname 
FROM pg_database db 
JOIN pg_tablespace ts ON db.dattablespace = ts.oid 
WHERE datname IN ('template1', 'wetredsoup');

\c "host=localhost port=9414 dbname=postgres user=aleksandrbabushkin password=44"
\du newrole