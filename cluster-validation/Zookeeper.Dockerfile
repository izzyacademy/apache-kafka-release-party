FROM izzyacademy/kafka-binary-base:3.1.0-rc1

# in Zookeeper, Brokers and Connect Docker images:
# Copy over the python scripts and generate the configs for Zookeeper
# Start up Docker containers with Config settings using ENVIRONMENT VARIABLES

COPY scripts/zookeeper-entrypoint.sh /usr/local/software/kafka/bin/zookeeper-entrypoint.sh

RUN chmod 0775 /usr/local/software/kafka/bin/zookeeper-entrypoint.sh

# Client Port
EXPOSE 2181

# Admin Port
EXPOSE 8080

# Leader Election Port and Cluster Communications
EXPOSE 2888
EXPOSE 3888

ENTRYPOINT ["/usr/local/software/kafka/bin/zookeeper-entrypoint.sh"]

# docker build . -f Zookeeper.Dockerfile -t izzyacademy/zookeeper:3.1.0-rc1

# docker build . -f Zookeeper.Dockerfile -t izzyacademy/zookeeper:3.1.0