FROM izzyacademy/kafka-binary-base:3.1.0-rc1

# in Zookeeper, Brokers and Connect Docker images:
# Copy over the python scripts and generate the configs for Kafka Nodes
# Start up Docker containers with Config settings using ENVIRONMENT VARIABLES

COPY scripts/broker.entrypoint.sh /usr/local/software/kafka/bin/broker.entrypoint.sh

RUN chmod 0775 /usr/local/software/kafka/bin/broker.entrypoint.sh

# Client Port
EXPOSE 9092

ENTRYPOINT ["/usr/local/software/kafka/bin/broker.entrypoint.sh"]

# docker build . -f Broker.Dockerfile -t izzyacademy/kafka-broker:3.1.0-rc1

# docker build . -f Broker.Dockerfile -t izzyacademy/kafka-broker:3.1.0