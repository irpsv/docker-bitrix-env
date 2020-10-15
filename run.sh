#!/bin/sh
# Note: Entry point to birix container

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
trap "shut_down" HUP INT QUIT KILL TERM

shut_down(){
# stop service and clean up here

service mysqld stop
service nginx stop
service httpd stop
service sshd stop
service crond stop

}

# start service in background here
# memory=${BVAT_MEM:=262144}

/etc/init.d/bvat start

service mysqld start
service crond start
service httpd start
service nginx start
service sshd start

echo "bitrix:bitrix" | chpasswd

echo "[hit ctrl-c to exit] or run 'docker stop <container>'"
while true; do sleep 1; done

shut_down

echo "exited $0"

