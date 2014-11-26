FROM ubuntu-base
#TAG apache-php

RUN sudo apt-get -y install apache2 php5 php5-mysql libapache2-mod-php5

EXPOSE 80/tcp

CMD until nc -w1 mysql 3306; do sleep 0.25; done; \
    service apache2 start; \
    tail -f /var/log/apache2/*



