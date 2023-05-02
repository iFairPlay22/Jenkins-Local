FROM jenkins/jenkins:lts

# Install docker
USER root
RUN apt-get update
RUN apt-get install -yq \
    ca-certificates \
    curl \
    gnupg
RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN chmod a+r /etc/apt/keyrings/docker.gpg
RUN echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update
RUN apt-get install -yq docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Manage jenkins user
RUN usermod -aG docker jenkins
RUN gpasswd -a jenkins docker

# Jenkins configurations
USER jenkins
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
ENV DOCKER_HOST=unix:///var/run/docker.sock
COPY configs/plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY configs/casc.yaml /var/jenkins_home/casc.yaml
COPY configs/jobs /usr/local/jobs
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt


