# Thanks to Kamesh Sampath for most of this, taken from his quarkus-java-builder
FROM registry.redhat.io/openshift4/ose-jenkins-agent-base:latest
MAINTAINER Gerald Nunn <gnunn@redhat.com>

ARG MAVEN_VERSION=3.6.2
ARG MAVEN_BASE_URL=https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries

ARG GRAAL_VM_VERSION=19.2.1
ARG GRAAL_VM_BASE_URL=https://github.com/oracle/graal/releases/download/vm-${GRAAL_VM_VERSION}

ARG PKGS="tar zip gzip findutils wget curl unzip gcc glibc-devel zlib-devel shadow-utils"

USER root

RUN yum -y install $PKGS \
    && mkdir -p /usr/share/maven /usr/share/maven/ref \
    && curl -fsSL -o /tmp/apache-maven.tar.gz ${MAVEN_BASE_URL}/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \
    && mkdir -p /opt/graalvm  \
    && curl -fsSL -o /tmp/graalvm-ce-amd64.tar.gz ${GRAAL_VM_BASE_URL}/graalvm-ce-linux-amd64-${GRAAL_VM_VERSION}.tar.gz \
    && tar -xzf /tmp/graalvm-ce-amd64.tar.gz -C /opt/graalvm --strip-components=1 \
    && /opt/graalvm/bin/gu --auto-yes install native-image \
    && rm -f /tmp/apache-maven.tar.gz  /tmp/graalvm-ce-amd64.tar.gz

USER 1001

ENV MAVEN_VERSION 3.6
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
ENV GRAALVM_HOME /opt/graalvm
ENV JAVA_HOME /opt/graalvm
ENV PATH $PATH:$JAVA_HOME/bin