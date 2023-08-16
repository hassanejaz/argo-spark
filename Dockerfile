ARG SPARK_IMAGE=gcr.io/spark-operator/spark-operator:latest
FROM ${SPARK_IMAGE}

ENV SBT_VERSION 1.9.3


# Switch to user root so we can add additional jars, packages and configuration files.
USER root

RUN apt-get update
RUN apt-get install -y \
    curl 

WORKDIR /app

#Install SBT
RUN curl -fsL https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz | tar xfz - -C /usr/local
ENV PATH /usr/local/sbt/bin:${PATH}

RUN sbt update

ADD build.sbt /app/
ADD project/plugins.sbt /app/project/
ADD project/build.properties /app/project/
ADD src/. /app/src/


#Build the projects
RUN sbt clean assembly

ENTRYPOINT ["/opt/entrypoint.sh"]
