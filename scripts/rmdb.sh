#!/bin/bash
cd $PGDATA && pg_ctl stop -D .
rm -rf $DBMS_ROOT/node/rvh63
rm -rf $DBMS_ROOT/node/cln78
echo "Очистка кластера завершена"