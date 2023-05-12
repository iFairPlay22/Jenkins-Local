FROM sbtscala/scala-sbt:eclipse-temurin-11.0.17_8_1.8.2_2.13.10

# Install brew
RUN apt-get install procps curl git
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

# Setup Nexus
RUN echo "echo "realm=Sonatype Nexus Repository Manager \n host=${NEXUS_HOST_URL} \n user=${NEXUS_ADMIN_ID} \n password=${NEXUS_ADMIN_PASSWORD}" > ~/.sbt/.ewenbouquet_credentials"
RUN echo "[repositories] \n local \n ewenbouquet-nexus-releases: ${NEXUS_BASE_URL}/repository/maven-releases/ \n ewenbouquet-nexus-snapshots: ${NEXUS_BASE_URL}/repository/maven-snapshots/ \n ewenbouquet-nexus-public: ${NEXUS_BASE_URL}/repository/maven-public/" > ~/.sbt/repositories