FROM izzyacademy/kafka-core:1.0.0

# Defining variables for project artifacts - location, project version and scala versions
ENV PROJECT_DOWNLOAD_URL="https://home.apache.org/~dajac/kafka-3.1.0-rc0"
ENV PROJECT_KAFKA_VERSION="3.1.0"
ENV PROJECT_SCALA_VERSION="2.13"

RUN wget "${PROJECT_DOWNLOAD_URL}/kafka_${PROJECT_SCALA_VERSION}-${PROJECT_KAFKA_VERSION}.tgz"

RUN tar -zxf "kafka_${PROJECT_SCALA_VERSION}-${PROJECT_KAFKA_VERSION}.tgz" && mv "kafka_${PROJECT_SCALA_VERSION}-${PROJECT_KAFKA_VERSION}" kafka

WORKDIR /usr/local/software/kafka

RUN mkdir -p /usr/local/software/kafka/scripts

COPY scripts/generate-configs.py /usr/local/software/kafka/scripts
COPY scripts/zookeeper.default.properties /usr/local/software/kafka/scripts
COPY scripts/broker.default.properties /usr/local/software/kafka/scripts
COPY scripts/connect.default.properties /usr/local/software/kafka/scripts

RUN chmod 0775 /usr/local/software/kafka/scripts/generate-configs.py

WORKDIR /usr/local/software/kafka/scripts

# This Docker image ends here
# in Zookeeper, Brokers and Connect Docker images:
# Copy over the python scripts and generate the configs for Zookeeper
# Start up Docker containers with Config settings using ENVIRONMENT VARIABLES

# docker build . -f Binary-Base.Dockerfile -t izzyacademy/kafka-binary-base:3.1.0-rc0