FROM ubuntu:16.10

### Base Pathfinder Support
RUN apt-get update && apt install -y wget libtool pkg-config build-essential autoconf automake uuid-dev composer git nginx php-fpm php-cli php-curl php-gd supervisor php7.0-mysql php-xml

### PHP-FPM
RUN mkdir /var/run/php

#ZMQ#### ZMQ Websockets
RUN apt install -y libzmq5
#RUN cd /tmp && \
#    git clone https://github.com/zeromq/libzmq.git && \
#    cd libzmq && \
#    ./autogen.sh && \
#    ./configure && \
#    make && \
#    make install && \
#    rm -rf /tmp/libzmq && \
#    cd /

RUN apt install -y php-zmq

RUN git clone https://github.com/exodus4d/pathfinder_websocket.git && \
    cd /pathfinder_websocket && \
    /usr/bin/composer install

# House keeping for the docker container
ADD run.sh /
ADD supervisor-websocket.conf /etc/supervisor/conf.d/

EXPOSE 8020 


CMD ["/run.sh"]
