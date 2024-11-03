#!/bin/bash

export PGDATA="$HOME/ado23"
export PGCHARSET="ISO_8859_5"
export PGLOCALE="ru_RU.ISO8859-5"
export CONF="$HOME/conf"

mkdir -p $PGDATA
mkdir $HOME/ipl2

initdb -D $PGDATA --encoding=$PGCHARSET --locale=$PGLOCALE --auth-host=md5 --auth-local=peer
 


cp $CONF/*.conf $PGDATA
cd $PGDATA && pg_ctl start -D .

psql -U postgres1 -p 9468 -d postgres -f $CONF/script.sql