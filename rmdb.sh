#!/bin/bash

cd $PGDATA && pg_ctl stop -D .
rm -rf $HOME/ado23
rm -rf $HOME/ipl2
clear