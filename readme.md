# Jenkins/Docker configurations

This project contains the docker configurations to launch the jenkins server for the following repositories:
- [Vehicle API](https://github.com/iFairPlay22/Scala-Vehicles-API) ;
- ...

## Run the project

Install [docker](https://www.docker.com/)

Setup the following environment variables: 
```sh
export JENKINS_ADMIN_ID=admin
export JENKINS_ADMIN_PASSWORD=root
```

Generate the Jenkins image: 
```sh
docker build -f dockerfile -t ebouquet/jenkins:latest .
docker build -f configs/images/scala.dockerfile -t ebouquet/images/scala:latest .
``` 

Launch the container: 
```sh
docker compose -p jenkins-group up
``` 

Open jenkins in `localhost:8080`.

To trigger builds automatically based on github, use
```sh
lt --port 8080
```

Copy paste the generated url + `github-webhook/`, and add them as a github webhook.

## Useful links

- [Configs](https://github.com/abrahamNtd/poc-jenkins-jcasc)
- [Jobs](https://jenkinsci.github.io/job-dsl-plugin/#path/job)