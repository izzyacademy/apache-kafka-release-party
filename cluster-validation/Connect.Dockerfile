FROM izzyacademy/kafka-binary-base:3.1.0-rc1

# in Zookeeper, Brokers and Connect Docker images:
# Copy over the python scripts and generate the configs for Connect Nodes
# Start up Docker containers with Config settings using ENVIRONMENT VARIABLES

COPY scripts/connect-entrypoint.sh /usr/local/software/kafka/bin/connect.entrypoint.sh

RUN chmod 0775 /usr/local/software/kafka/bin/connect.entrypoint.sh

# Client Port
EXPOSE 8083

ENTRYPOINT ["/usr/local/software/kafka/bin/connect.entrypoint.sh"]

# docker build . -f Connect.Dockerfile -t izzyacademy/kafka-connect:3.1.0-rc1

# docker build . -f Connect.Dockerfile -t izzyacademy/kafka-connect:3.1.0