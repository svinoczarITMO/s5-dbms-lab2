-- ... <-- update password --

create tablespace ipl2 location '/var/db/postgres1/ipl2';

create database coolyellowsoup with template template1 owner postgres1;

alter database coolyellowsoup set default_tablespace = 'ipl2';


create role newrole with login password 'superpassword';

grant all on schema public to newrole;
grant all on tablespace ipl2 to newrole;
grant all on database coolyellowsoup to newrole;

\pset pager off
\c coolyellowsoup newrole

create table a (id serial primary key, 
    name varchar(64), 
    surname varchar(64),
    age int,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp);

insert into a (name, surname, age)
    values 
        ('Ivan', 'Smirnov', 18),
        ('Andrew', 'Popov', 44),
        ('Donald', 'Trump', 78);



select tablespace, tablename from pg_tables;
