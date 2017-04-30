# pathfinder-dockerized

A docker-ized build of discrete services for Pathfinder:
- Pathfinder (https://github.com/exodus4d/pathfinder)
- Pathfinder Websocket Server (https://github.com/exodus4d/pathfinder_websocket) 
- nGinx Reverse Proxy (https://github.com/jwilder/nginx-proxy)
- Letsencrypt (https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion)
- Mysql (https://github.com/mysql/mysql-docker)
- Redis (https://hub.docker.com/_/redis/)

The goal is to provide an easy to install and manage method of deploying Pathfinder using docker-compose.

# Install Steps
```
- Install docker-ce (or individual docker 1.10+ and docker-compose)
- git clone https://github.com/Nitesedge/pathfinder-dockerized.git
- cd pathfinder-dockerized
- edit docker-compose.yml and replace <SETME> with the proper info
- edit config/config.ini and replace <SETME> with the proper info
- edit config/environment.ini and replace <SETME> with the proper info
- edit config/pathfinder.conf and replace <SETME> with the proper info
- docker-compose up -d
- wait a few minutes for db to initialize
- Run the first DB script to create databases
   docker run --rm -ti --network pathfinderdockerized_default --link mysql -v /PATH/TO/pathfinder-dockerized/scripts:/scripts pathfinderdockerized_pathfinder /bin/bash /scripts/dbsetup.sh DBPASSWORD
- access the /setup webpage http://hostname/setup
- Create Tables
- Run the Second DB script to populate database info
    docker run --rm -ti --network pathfinderdockerized_default --link mysql -v /PATH/TO/pathfinder-dockerized/scripts:/scripts pathfinderdockerized_pathfinder /bin/bash /scripts/dbsetup2.sh DBPASSWORD
- access the /setup webpage http://hostname/setup
    - Fix Keys
- Everything Should be Green w/ Sockets Connected
- edit config/routes.ini
   comment out /setup with (;)
- docker-compose restart pathfinder
```

# TODO
- Complete letsencrypt setup
- Add Cron job
- add instructions for db import/export
