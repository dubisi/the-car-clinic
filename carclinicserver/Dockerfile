FROM ubuntu:latest

LABEL maintainer="za.co.thecarclinic"

RUN apt-get update
RUN apt-get install -y openjdk-11-jdk
RUN apt-get install -y maven
RUN apt-get install -y make
RUN apt-get install -y curl

WORKDIR /srv

COPY target/*-webserver.jar /srv/

EXPOSE 5000
CMD ["java", "-jar", "carclinicserver-1.0-SNAPSHOT-webserver.jar"]
