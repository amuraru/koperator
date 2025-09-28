ARG JMX_EXPORTER_VERSION=1.4.0 # renovate: datasource=github-releases depName=prometheus/jmx_exporter

FROM maven:3-amazoncorretto-21 AS build
ARG JMX_EXPORTER_VERSION

# Install wget to download the release tarball
RUN yum install -y wget && yum clean all

# Download and extract the JMX exporter release
RUN wget https://github.com/prometheus/jmx_exporter/archive/refs/tags/${JMX_EXPORTER_VERSION}.tar.gz -O /tmp/jmx_exporter.tar.gz && \
    tar -xzf /tmp/jmx_exporter.tar.gz -C /tmp && \
    mv /tmp/jmx_exporter-${JMX_EXPORTER_VERSION} /src && \
    rm /tmp/jmx_exporter.tar.gz

WORKDIR /src
RUN mvn -Dmaven.javadoc.skip=true clean package

FROM scratch
ARG JMX_EXPORTER_VERSION

COPY --from=build /src/jmx_prometheus_javaagent/target/jmx_prometheus_javaagent-${JMX_EXPORTER_VERSION}.jar /jmx_prometheus_javaagent.jar