# from father of image ubuntu: 16.04
FROM ubuntu:16.04
# author

MAINTAINER DucNguyen<ducnp2020@gmail.com>

DEBIAN_FRONTEND=noninteractive

# update ubuntu
RUN apt-get update

#install nginx

RUN apt-get install -y nginx

#install mysql

RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections \ 
&& echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections \
&& apt-get install -y mysql-server

DIRWORK /venv

COPY start.sh /venv

RUN chmod a+x /venv/*

ENTRYPOINT ["/venv/start.sh"]

EXPOSE 80
