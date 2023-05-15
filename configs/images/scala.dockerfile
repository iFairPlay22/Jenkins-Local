FROM sbtscala/scala-sbt:eclipse-temurin-11.0.17_8_1.8.2_2.13.10

# Install brew
# RUN apt-get install procps curl git
# RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

# Setup Nexus
ARG NEXUS_BASE_URL
ARG NEXUS_HOST_URL
ARG NEXUS_ADMIN_ID
ARG NEXUS_ADMIN_PASSWORD

RUN echo "realm=Sonatype Nexus Repository Manager\nhost=${NEXUS_HOST_URL}\nuser=${NEXUS_ADMIN_ID}\npassword=${NEXUS_ADMIN_PASSWORD}" > ~/.sbt/.ewenbouquet_credentials
RUN echo "[repositories]\nlocal\newenbouquet-nexus-releases: ${NEXUS_BASE_URL}/repository/maven-releases/\newenbouquet-nexus-snapshots: ${NEXUS_BASE_URL}/repository/maven-snapshots/\newenbouquet-nexus-public: ${NEXUS_BASE_URL}/repository/maven-public/" > ~/.sbt/repositories
