create tablespace ipl2 location '/var/db/postgres1/ipl2';

CREATE DATABASE template2 WITH TEMPLATE template1 OWNER postgres1 TABLESPACE ipl2;

create database coolyellowsoup with template template2 owner postgres1;

alter database coolyellowsoup set default_tablespace = 'ipl2';


create role newrole with login password 'superpassword';

grant all on schema public to newrole;
grant all on tablespace ipl2 to newrole;
grant all on database coolyellowsoup to newrole;

\pset pager off
\c coolyellowsoup newrole

create table b (id serial primary key, 
    name varchar(64), 
    surname varchar(64),
    age int,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp) tablespace ipl2;

insert into b (name, surname, age)
    values 
        ('Ivan', 'Smirnov', 18),
        ('Andrew', 'Popov', 44),
        ('Donald', 'Trump', 78);




WITH db_tablespaces AS (
    SELECT t.spcname, d.datname
    FROM pg_tablespace t
    JOIN pg_database d ON d.dattablespace = t.oid
)
SELECT t.spcname, 
       COALESCE(string_agg(DISTINCT c.relname, E'\n'), 'No objects') AS objects,
       string_agg(DISTINCT db.datname, ', ') AS databases_in
FROM pg_tablespace t
LEFT JOIN pg_class c ON c.reltablespace = t.oid OR (c.reltablespace = 0 AND t.spcname = 'pg_default')
LEFT JOIN db_tablespaces db ON t.spcname = db.spcname
GROUP BY t.spcname
ORDER BY t.spcname;