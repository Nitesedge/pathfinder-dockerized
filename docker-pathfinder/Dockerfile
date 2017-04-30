FROM ubuntu:16.10

### Base Pathfinder Support
RUN apt-get update && apt install -y wget libtool pkg-config build-essential autoconf automake uuid-dev composer git nginx php-fpm php-cli php-curl php-gd supervisor php7.0-mysql php-xml

### Pathfinder
RUN git clone https://github.com/exodus4d/pathfinder.git /app
RUN mkdir /app/tmp/cache

RUN chown -R www-data:www-data /app

### PHP-FPM
RUN mkdir /var/run/php

### Nginx Configuration
RUN git clone https://github.com/h5bp/server-configs-nginx.git && \
    mv server-configs-nginx/h5bp /etc/nginx/ && \
    mv server-configs-nginx/mime.types /etc/nginx/mime.types && \
    rm -rf /server-configs-nginx
ADD nginx.conf /etc/nginx/nginx.conf

### Redis Pathfinder support
#RUN apt install -y php-redis
#We have to build php-redis from source since current repo has 2.2.7 and we need 3.0.0
RUN apt install -y unzip php7.0-dev
RUN cd /tmp && \
    git clone https://github.com/phpredis/phpredis.git && \
    cd /tmp/phpredis && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    rm -rf /tmp/phpredis && \
    echo extension=redis.so > /etc/php/7.0/mods-available/redis.ini && \
    ln -s /etc/php/7.0/mods-available/redis.ini /etc/php/7.0/fpm/conf.d/20-redis.ini && \
    ln -s /etc/php/7.0/mods-available/redis.ini /etc/php/7.0/cli/conf.d/20-redis.ini && \
    phpenmod redis && \
    echo php-redis installed

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

##RUN git clone https://github.com/exodus4d/pathfinder_websocket.git && \
#    cd /pathfinder_websocket && \
#    /usr/bin/composer install
#
RUN cd /app && composer install

# House keeping for the docker container
ADD run.sh /
ADD supervisord-pathfinder.conf /etc/supervisor/conf.d/supervisor-pathfinder.conf

# Testing
ADD phpinfo.php /app

RUN echo 'max_input_vars = 3000;' >>  /etc/php/7.0/fpm/php.ini

EXPOSE 80

RUN apt install -y mysql-client
CMD ["/run.sh"]
