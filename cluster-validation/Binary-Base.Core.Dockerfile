FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update

RUN apt-get -y install aptitude vim curl wget gnupg python3-pip openjdk-11-jdk

RUN apt-get -y install inetutils-telnet inetutils-ping

# https://pypi.org/project/jproperties/
RUN pip install jproperties

RUN mkdir -p /usr/local/software

WORKDIR /usr/local/software

# docker build . -f Binary-Base.Core.Dockerfile -t izzyacademy/kafka-core:1.0.0 izzyacademy/kafka-core:latest