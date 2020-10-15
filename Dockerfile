FROM centos:7

WORKDIR /home/root/

ENV MYSQL_PASSWORD="password"

RUN yum update -y && yum install -y wget
RUN wget http://repos.1c-bitrix.ru/yum/bitrix-env.sh && \
    chmod +x bitrix-env.sh && \
    ./bitrix-env.sh -p -F -M '$MYSQL_PASSWORD'

COPY run.sh /home/root/
CMD ["/bin/bash", "/home/root/run.sh"]
