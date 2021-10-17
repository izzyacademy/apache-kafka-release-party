FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update

RUN apt-get -y install aptitude vim curl wget gnupg python3-pip openjdk-11-jdk

RUN apt-get -y install inetutils-telnet inetutils-ping unzip apache2 git

RUN mkdir -p /usr/local/software

# This is how to build the base Docker image
# docker build . -f Docs.Base.Dockerfile -t izzyacademy/kafka-docs-base:1.0.0

