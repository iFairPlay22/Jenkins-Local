# Jenkins/Docker configurations

This project contains the docker configurations to launch the jenkins server for the following repositories:
- [Vehicle API](https://github.com/iFairPlay22/Scala-Vehicles-API) ;
- ...

## Run the project

Install [docker](https://www.docker.com/)

Setup the following environment variables: 
```
export JENKINS_SERVICE_NAME=jenkins:local_service
export JENKINS_ADMIN_ID=admin
export JENKINS_ADMIN_PASSWORD=root
```

Generate the Jenkins container: 
```
docker build -t $JENKINS_SERVICE_NAME .
``` 

Launch the image: 
```
docker compose up
``` 

Open jenkins in `localhost:8080`.

## Useful links

Configs: https://github.com/abrahamNtd/poc-jenkins-jcasc
Jobs:  https://jenkinsci.github.io/job-dsl-plugin/#path/job