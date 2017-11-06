# Usage

## run param (docker no swarm mode )

> /bin/bash

# run param (swarm)

> mkdir -p secrets && echo "-master http://10.0.0.101 -password admin -username admin123" > secrets/jenkins
> docker run --rm -it --name jenkins-swarm-agent -e LABELS=docker-test \
> -v `pwd`/secrets:/run/secrets `cat TAG`:`cat VERSION`
