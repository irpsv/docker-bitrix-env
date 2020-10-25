#!/bin/sh

trap "shut_down" HUP INT QUIT KILL TERM

shut_down(){
    service mysqld stop
    service nginx stop
    service httpd stop
    service crond stop
}

/etc/init.d/bvat start

service mysqld start
service crond start
service httpd start
service nginx start

echo "bitrix:bitrix" | chpasswd

echo "mysql root password: " && head /root/.my.cnf | grep password
echo "[hit ctrl-c to exit] or run 'docker stop <container>'"
while true; do sleep 1; done

shut_down

echo "exited $0"
