#!/bin/bash
wget https://www.fuzzwork.co.uk/dump/mysql-latest.tar.bz2
mysql -u root -p"$1" --host mysql pathfinder < /app/export/sql/pathfinder.sql
sleep 1
mysql -u root -p"$1" --host mysql ccp < `tar jxvf mysql-latest.tar.bz2` 


