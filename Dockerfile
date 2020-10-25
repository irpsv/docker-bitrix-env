FROM centos:6

WORKDIR /home/root/

ENV UID=1000
ENV GID=1000

RUN yum update -y && yum install -y wget
RUN wget http://repos.1c-bitrix.ru/yum/bitrix-env.sh && \
    chmod +x bitrix-env.sh && \
    ./bitrix-env.sh -p -H -F server1

# внутри bitrix-vm работает от пользователя bitrix
# поэтому ему нужно присвоить UID/GID внешего пользователя (по-умолчанию 1000)
RUN usermod -u $UID bitrix && \
    groupmod -g $GID bitrix

# т.к. сменили uid то надо менять права на папки
RUN chown -R bitrix:bitrix /tmp/php_sessions && \
    chown -R bitrix:bitrix /tmp/php_upload

COPY run.sh /home/root/
CMD ["/bin/bash", "/home/root/run.sh"]