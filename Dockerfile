FROM ubuntu:14.04
MAINTAINER Shang-Min Yang <demonboy2266@gmail.com>

ENV DEBIAN_FRONTEND noninteractive


RUN ["/bin/bash","-c","apt-get -y update"]

RUN ["/bin/bash","-c","apt-get -y install git"]
RUN ["/bin/bash","-c","git clone https://github.com/bruce3557/NTHUOJ_web.git"]
RUN ["/bin/bash","-c","apt-get -y install mysql-server python-mysqldb"]
RUN ["/bin/bash","-c","apt-get -y install python-pip"]
RUN ["/bin/bash","-c","apt-get -y install python-dev"]
RUN ["/bin/bash","-c","apt-get -y install libjpeg-dev"]
RUN ["/bin/bash","-c","apt-get -y install dos2unix"]
RUN ["/bin/bash","-c","apt-get -y install npm nodejs"]
RUN ["/bin/bash","-c","npm install -g bower"]
RUN ["/bin/bash","-c","ln -s /usr/bin/nodejs /usr/bin/node"]
RUN ["/bin/bash","-c","cd NTHUOJ_web","pip install -r requirements.txt"]
RUN ["/bin/bash","-c","apt-get -y update"]

RUN ["/bin/bash","-c","apt-get install -y curl"]
RUN ["/bin/bash","-c","curl -sL https://deb.nodesource.com/setup | sudo bash -"]
RUN ["/bin/bash","-c","apt-get install -y nodejs"]
RUN ["/bin/bash","-c","npm install -g bower"]

RUN ["/bin/bash","-c","service mysql start \
&& mysql -u root -e \"create database nthuoj character set utf8;\""]
RUN ["/bin/bash","-c","service mysql start \
&& mysql -u root -e \"CREATE USER 'nthu'@'localhost' IDENTIFIED BY 'nthu';\""]
RUN ["/bin/bash","-c","service mysql start \
&& mysql -u root -e \"GRANT ALL PRIVILEGES ON * . * TO 'nthu'@'localhost';\""]
RUN ["/bin/bash","-c","service mysql start \
&& mysql -u root -e \"show databases;\""]
RUN ["/bin/bash","-c","service mysql start \
&& mysql -u root -e \"SELECT User,Host FROM mysql.user;\""]
RUN ["/bin/bash","-c","pip install django==1.7"]
RUN ["/bin/bash","-c","pip install django-bower"]
RUN ["/bin/bash","-c","pip install django-axes"]
RUN ["/bin/bash","-c","pip install django-autocomplete-light"]
RUN ["/bin/bash","-c","pip install django-datetime-widget"]
RUN ["/bin/bash","-c","pip install django-bootstrap"]
RUN ["/bin/bash","-c","pip install django-bootstrap-form"]
RUN ["/bin/bash","-c","pip install django-ckeditor"]
RUN ["/bin/bash","-c","pip install requests"]
RUN ["/bin/bash","-c","pip install pillow"]
RUN ["/bin/bash","-c","pip install MySQL-python"]
RUN ["/bin/bash","-c","pip install gunicorn"]
RUN ["/bin/bash","-c","apt-get install wget"]

COPY install.py /NTHUOJ_web/
COPY nthuoj.cfg /NTHUOJ_web/nthuoj/config/

EXPOSE 8000

#開啟container後需要執行步驟
#1.service mysql start
#2.cd NTHUOJ_web
#3.python install.py(在bower那邊回答 Y  --allow-root)
#4.python manage.py runserver
#大功告成囉XD

#RUN ["/bin/bash","-c","cd NTHUOJ_web","ptyhon install.py"]
#RUN ["/bin/bash","-c","cd NTHUOJ_web","python manage.py runserver &"]
#RUN ["/bin/bash","-c","netstat -ls"]
#RUN ["/bin/bash","-c","wget http://127.0.0.1:8000"]

