## Quick Validation with Pre-Compiled Docker Images

This validation walks you through the validation of Apache Kafka 3.1.0 RC0 using the following pre-packaged Docker images based on the first release candidate for Apache kafka 3.1.0

- izzyacademy/kafka-artifact-base:3.1.0-rc1
- izzyacademy/kafka-binary-base:3.1.0-rc1
- izzyacademy/kafka-docs:3.1.0-rc1
- izzyacademy/zookeeper:3.1.0-rc1
- izzyacademy/kafka-broker:3.1.0-rc1
- izzyacademy/kafka-connect:3.1.0-rc1

Follow the steps here to boot up the environment in a few seconds without having to prepare the docker images

The validation steps remain the same from the [README page](README.md) for each section you need to validate

- Release Candidate Artifacts
- Site Documentation for 3.1.0 RC1
- Validation of Cluster in Zookeeper Mode
- Validation of Cluster in KRaft Mode (Single and Multi-Node)


## Validation of Hashes, GPG Keys and Source Code

Follow the steps below to spin up the environment

```bash

# Navigate to the Artifact Validation Folder
cd artifact-validation

# Fire up the Docker Compose instance to boot up the Docker container(s)
cd compose 
docker-compose up

# Log into the running container in a separate window or tab
docker exec -it validator /bin/bash

# To shut down the contain run the following command after exiting:
docker-compose down --remove-orphans

```

## Site Docs Validation

Follow the steps below to spin up the environment

```bash

# Navigate to the Artifact Validation Folder
cd docs-validation

# Update the docker images in the docker compose file with the docker image you just built
# Fire up the Docker Compose instance to boot up the Docker container(s)
cd compose 
docker-compose up

# (Optional) You can log into the running container for exploration, if you wish
docker exec -it kafkadocs /bin/bash


# To shut down the contain run the following command after exiting:
docker-compose down --remove-orphans

```


## Cluster Validation with Zookeeeper (Legacy Mode) and Without Zookeeper (KRaft Mode)


Follow the steps below to spin up the environment

```bash

# Navigate to the Cluster Validation Folder
cd cluster-validation

```

## Legacy Mode With Zookeeper (Multi-Node)

Follow the steps below to spin up the environment

```bash

## 
cd compose/legacy

# Update the docker images in the docker compose file with the dockers image you just built earlier
# Deploys a multi-node cluster using Zookeeper 
docker-compose up

# Shuts down containers
docker-compose down --remove-orphans

# You can log onto broker2 to validate the cluster in a separate window or tab
docker exec -it broker2 /bin/bash

```


## KRaft Mode without Zookeeper (Single Node)

Follow the steps below to spin up the environment

```bash

cd compose/kraft

# Update the docker images in the docker compose file with the docker images you just built
# Deploys a simple single-node cluster in KRaft Mode
docker-compose up

# Shuts down the containers
docker-compose down --remove-orphans

# Log on to NodeId=1 from a separate window or tab
docker exec -it node1 /bin/bash


```


## KRaft Mode without Zookeeper (Multi-Node)

Follow the steps below to spin up the environment

```bash

cd compose/kraft

# Update the docker images in the docker compose file with the docker images you just built
# Deploys a multi-node cluster in KRaft Mode
docker-compose --env-file ./environment-variables.sh -f multi-node-docker-compose.yml up

# Shuts down the containers
docker-compose --env-file ./environment-variables.sh -f multi-node-docker-compose.yml down --remove-orphans

# Log on to NodeId=2 from a separate window or tab
docker exec -it node2 /bin/bash

```
