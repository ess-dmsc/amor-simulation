# Streaming pipeline containers

The repository contains a collection of containers that run the different components of the ESS streaming pipeline.

The `docker-compose` in `amor` runs the whole set of containers required to simulate a whole instrument (AMOR). 

## How to run

### AMOR simulation

In the `amor` folder:

1. make sure that the topics used in `docker-compose.yml` are correct. If more topics are required, add to the `KAFKA_CREATE_TOPICS` list. The syntax for each entry is
```shell
<topic name>:<partitions>:<replicas>
```
to set the cleanup policy to `compact` use
```shell
<topic name>:<partitions>:<replicas>:compact
```

2. this repository contains the container required to run the deep EPICS simulation of the system. Nevertheless, all the EPICS scripts and databases are in a separate repository. This repository is connected as a submodule. Use the following to checkout:

```shell
git submodule init
git submodule update
```

3. launch the docker-compose:
```shell
docker-compose up
```
or
```shell
docker-compose up -d
```

### forwarder/kafka-to-nexus/just-bin-it/neutron-event-generator

The single services can be run in a container. Just enter the corresponding directory, eventually configure the topics and run the composer.

```shell
cd <service>
docker-compose up
```

### Regarding kafkacat

The containters mount a volume that contains all the libraries and the executable required to run `kafkacat`. This tool is used in the launch files to make sure that the kafka broker is up and all the topics are loaded.

### Running on a macOS

The `docker` system on macOS requires to create a `docker-machine` and set up the environment in each shell. Please make sure that `KAFKA_ADVERTISED_HOST_NAME`, `KAFKA_BROKER`, `BROKER_URI` and all the `*_URI`s use the IP address of the docker machine.

```shell
docker-machine create --driver=virtualbox <machine name>
eval `docker-machine env <machine name>`
echo $DOCKER_HOST
```


## Known bugs

- Despite the `kafkacat` statup system, it is possible that a service fails because the kafka server is up and running, but the topic not yet completely loaded. If this happens, please just  start the single service or start (again) the machine. DO NOT EXECUTE `docker-compose down`
