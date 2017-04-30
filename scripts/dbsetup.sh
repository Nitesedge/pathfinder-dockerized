#!/bin/bash
mysql -u root -p"$1" --host mysql -e "create database pathfinder;"
mysql -u root -p"$1" --host mysql -e "create database ccp;"
mysql -u root -p"$1" --host mysql -e "ALTER DATABASE ccp CHARACTER SET utf8 COLLATE utf8_general_ci;"
