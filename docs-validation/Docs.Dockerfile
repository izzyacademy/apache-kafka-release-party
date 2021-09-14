FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update

RUN apt-get -y install aptitude vim curl wget gnupg python3-pip openjdk-11-jdk

RUN apt-get -y install inetutils-telnet inetutils-ping unzip apache2 git

RUN mkdir -p /usr/local/software /tmp/kafka-validation

ENV TMPDIR="/tmp/kafka-validation"

WORKDIR /usr/local/software

RUN git clone https://github.com/apache/kafka-site.git site-docs

COPY httpd.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /etc/apache2/mods-enabled

RUN ln -s /etc/apache2/mods-available/include.load include.load 
RUN ln -s /etc/apache2/mods-available/rewrite.load rewrite.load

WORKDIR /usr/local/software

EXPOSE 80 443 

# This is how to build the base Docker image
# docker build . -f Docs.Dockerfile -t izzyacademy/kafka-docs:3.0.0-rc2

