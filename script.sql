create tablespace ipl2 location '/var/db/postgres1/ipl2';

alter database template1 set default_tablespace = 'ipl2';

create database coolyellowsoup with template template1 owner postgres1;

create role newrole with login password 'superpassword';
grant all privileges on schema public to newrole;
grant connect on database coolyellowsoup to newrole;

\c coolyellowsoup newrole

create table test (id serial primary key, 
    name varchar(64), 
    surname varchar(64),
    age int,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp);

insert into test (name, surname, age)
    values 
        ('Ivan', 'Smirnov', 18),
        ('Andrew', 'Popov', 44),
        ('Donald', 'Trump', 78);



select
    nspname as "Schema",
    relname as "Object Name",
    case relkind
        when 'r' then 'table'
        when 'v' then 'view'
        when 'm' then 'materialized view'
        when 'i' then 'index'
        when 'S' then 'sequence'
        when 'f' then 'foreign table'
        ELSE 'other'
    end as "Object Type",
    pg_tablespace.spcname as "Tablespace"
from
    pg_class
join
    pg_namespace on pg_namespace.oid = pg_class.relnamespace
join
    pg_tablespace on pg_tablespace.oid = pg_class.reltablespace
WHERE
    pg_namespace.nspname not in ('pg_catalog', 'information_schema')
order by
    "Schema", "Object Name";
