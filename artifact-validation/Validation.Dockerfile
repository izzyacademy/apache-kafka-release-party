FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update

RUN apt-get -y install aptitude vim curl wget gnupg python3-pip openjdk-11-jdk

RUN apt-get -y install inetutils-telnet inetutils-ping unzip

RUN mkdir -p /usr/local/software /tmp/kafka-validation

WORKDIR /usr/local/software

# Scala 2.13 is needed in the image
RUN wget https://downloads.lightbend.com/scala/2.13.6/scala-2.13.6.tgz

# Scala 2.12 is needed in the image
RUN wget https://downloads.lightbend.com/scala/2.12.14/scala-2.12.14.tgz

# Gradle 5.4 or later is needed in the image
RUN wget https://services.gradle.org/distributions/gradle-7.2-bin.zip

RUN tar -zxf scala-2.13.6.tgz && mv scala-2.13.6 scala-2.13

RUN tar -zxf scala-2.12.14.tgz && mv scala-2.12.14 scala-2.12

RUN unzip  gradle-7.2-bin.zip && mv gradle-7.2 gradle

ENV TMPDIR="/tmp/kafka-validation"

# This is the Kafka version
ENV PROJECT_KAFKA_VERSION="3.0.0"

# This is the Scala version
ENV PROJECT_SCALA_VERSION="2.13"

# This is the download URL for release artifacts
ENV PROJECT_DOWNLOAD_URL="https://home.apache.org/~kkarantasis/kafka-3.0.0-rc2/"

COPY scripts/verify-artifacts.sh /usr/local/software/verify-artifacts.sh

RUN chmod 0755 /usr/local/software/verify-artifacts.sh

# This is how to build the base Docker image
# docker build . -f Validation.Dockerfile -t izzyacademy/kafka-artifact-base:3.0.0-rc2

