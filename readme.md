# Jenkins/Docker configurations

This project contains the docker configurations to launch the jenkins server for the following repositories:
- [Vehicle API](https://github.com/iFairPlay22/Scala-Vehicles-API) ;
- ...

## Run the project

Install [docker](https://www.docker.com/)

### Environment variables

Define the following environment variables: 
```sh
export JENKINS_ADMIN_ID=admin
export JENKINS_ADMIN_PASSWORD=root
export NEXUS_ADMIN_ID=admin
export NEXUS_ADMIN_PASSWORD=root
``` 

Then, setup a public Jenkins URL & Nexus using local tunnel (in separated terminals).
```sh
lt --port 8080 --subdomain ewenbouquet-jenkins-public-url
lt --port 8081 --subdomain ewenbouquet-nexus-public-url
```

Then, define the following environment variable with the displayed URLs.
```sh
export JENKINS_HOST_URL=ewenbouquet-jenkins-public-url.loca.lt
export JENKINS_BASE_URL=https://$JENKINS_HOST_URL
export NEXUS_HOST_URL=ewenbouquet-nexus-public-url.loca.lt
export NEXUS_BASE_URL=https://$NEXUS_HOST_URL
```

### Docker

Launch the services:
```sh
docker compose -p jenkins-group up --detach
```

### Setup Nexus

Once the nexus container is initializated, open nexus (URL = `NEXUS_BASE_URL`). Then, click on log-in and paste the default password (automatically copied thanks to the following command):
```sh
docker exec -it jenkins-group-nexus-1 cat /nexus-data/admin.password | pbcopy
```

Then, set the new nexus password with the value of `$NEXUS_ADMIN_PASSWORD`
```sh
echo "[ id = $NEXUS_ADMIN_ID / pwd = $NEXUS_ADMIN_PASSWORD ]"
```

Finally, execute this command to setup sbt the nexus configurations:
```sh
echo "
realm=Sonatype Nexus Repository Manager
host=$NEXUS_HOST_URL
user=$NEXUS_ADMIN_ID
password=$NEXUS_ADMIN_PASSWORD
" > ~/.sbt/.ewenbouquet_credentials
```

NB: Check also that the following lines are in `~/.sbt/repositories`:
```sh
local
ewenbouquet-nexus-releases: ${NEXUS_BASE_URL}/repository/maven-releases/
ewenbouquet-nexus-snapshots: ${NEXUS_BASE_URL}/repository/maven-snapshots/
ewenbouquet-nexus-public: ${NEXUS_BASE_URL}/repository/maven-public/
```

### Setup Jenkins

Once the jenkins container is initializated, open jenkins (URL = `JENKINS_BASE_URL`) and log in. The credentials are:
```sh
echo "[ id = $JENKINS_ADMIN_ID / pwd = $JENKINS_ADMIN_PASSWORD ]"
```

NB: Check that `JENKINS_BASE_URL` is used as a webhook for your github projects (donc forget to add the `/github-webhook` as suffix).

## Troubleshooting

### Update a docker image

If a nexus artifact is missing, you need to upload it in nexus. To upload it, run `sbt publish` in the one of the projects. Please mind the `$NEXUS_BASE_URL` environment variable, and the other Nexus configurations.

NB: Running the following command will NOT resolve the issue
```sh
sbt publishLocal
```

### Update a docker image

If a docker image is missing, you need to push it in the docker hub. To do that, execute the following command lines with the configured environment variables `DOCKERFILE_PATH` and `IMAGE_NAME`.

```sh
docker login
docker rmi $IMAGE_NAME
docker build -f $DOCKERFILE_PATH -t $IMAGE_NAME . --no-cache
docker push $IMAGE_NAME
```

For Jenkins: 
```sh
export IMAGE_NAME=ewenbouquet/jenkins:latest
export DOCKERFILE_PATH=dockerfile
```

For Jenkins/Scala
```sh
export IMAGE_NAME=ewenbouquet/jenkins-img-scala:latest
export DOCKERFILE_PATH=configs/images/scala.dockerfile
```

## Useful links

- [Configs](https://github.com/abrahamNtd/poc-jenkins-jcasc)
- [Jobs](https://jenkinsci.github.io/job-dsl-plugin/#path/job)