FROM ubuntu-base
#TAG mysql-test

RUN apt-get update; \
    echo "mysql-server mysql-server/root_password password toor" | debconf-set-selections; \
    echo "mysql-server mysql-server/root_password_again password toor" | debconf-set-selections; \
    apt-get -y install mysql-server mysql-client libaio-dev libaio1; \
    sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/my.cnf

EXPOSE 3306/tcp

CMD mysql_install_db; \
    chown -R mysql:mysql /var/lib/mysql; \
    service mysql start; \
    until nc -w1 localhost 3306; do sleep 0.25; done; \
    echo "create user 'test'@'%' identified by 'test'" | mysql; \
    echo "grant all privileges on test.* to 'test'@'%' with grant option;" | mysql; \
    echo "create database if not exists test;" | mysql; \
    echo "use test; create table if not exists my_table ( description varchar(255), value varchar(255) );" | mysql; \
    echo "use test; insert into my_table values ('container_start',now());" | mysql; \
    tail -f /var/log/mysql/*
