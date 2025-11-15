#!/bin/bash

# Этап 1: Инициализация кластера БД
export DBMS_ROOT="/Users/aleksandrbabushkin/ITMO/s7-dbms-lab2"
export PGDATA="$DBMS_ROOT/node/rvh63"
export PGENCODING="KOI8-R"
export PGLOCALE="ru_RU.KOI8-R"

# Создаем директории
mkdir -p $PGDATA
mkdir -p $DBMS_ROOT/node/cln78

# Инициализируем кластер
initdb -D $PGDATA --encoding=$PGENCODING --locale=$PGLOCALE --auth-host=scram-sha-256 --auth-local=peer

echo "Кластер БД инициализирован в $PGDATA"

# Копируем подготовленные конфиги (предполагается, что они лежат в текущей директории)
cp $DBMS_ROOT/configuration/postgresql.conf $PGDATA/
cp $DBMS_ROOT/configuration/pg_hba.conf $PGDATA/

# Запускаем сервер
cd $PGDATA && pg_ctl start -D .

echo "Сервер БД запущен на порту 9414."