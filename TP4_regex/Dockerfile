FROM debian:11

RUN apt-get update && apt-get upgrade -y 

RUN apt-get -y install build-essential pkg-config python-dev python3-pip default-libmysqlclient-dev python3-dev pkg-config

RUN pip3 install flask-mysqldb 

RUN pip3 install mysql-connector-python 

RUN pip3 install mysqlclient

RUN mkdir /srv/templates

#COPY index.html /srv/templates

#COPY app_1.py /srv/

CMD ["flask","--app","/srv/app_1","run","--host=0.0.0.0"]

