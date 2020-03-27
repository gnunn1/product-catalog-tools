FROM registry.access.redhat.com/ubi8/go-toolset:latest as builder

# Based on image from Robert Bohne <robert.bohne@redhat.com>
LABEL maintainer="Gerald Nunn"

ENV SKOPEO_VERSION=v0.1.41

RUN git clone -b $SKOPEO_VERSION https://github.com/containers/skopeo.git && \
    cd skopeo/ && \
    make binary-local DISABLE_CGO=1

FROM quay.io/openshift/origin-cli:latest as final

LABEL maintainer="Gerald Nunn"

RUN mkdir /etc/containers/

COPY --from=builder /opt/app-root/src/skopeo/default-policy.json /etc/containers/policy.json
COPY --from=builder /opt/app-root/src/skopeo/skopeo /usr/bin/
