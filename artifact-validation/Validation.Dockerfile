FROM izzyacademy/kafka-validation-base:1.0.0

ENV TMPDIR="/tmp/kafka-validation"

# This is the Kafka version
ENV PROJECT_KAFKA_VERSION="3.1.0"

# This is the Scala version
ENV PROJECT_SCALA_VERSION="2.13"

# This is the download URL for release artifacts
ENV PROJECT_DOWNLOAD_URL="https://home.apache.org/~dajac/kafka-3.1.0-rc0/"

COPY scripts/verify-artifacts.sh /usr/local/software/verify-artifacts.sh

RUN chmod 0755 /usr/local/software/verify-artifacts.sh

# This is how to build the base Docker image
# docker build . -f Validation.Dockerfile -t izzyacademy/kafka-artifact-base:3.1.0-rc0

