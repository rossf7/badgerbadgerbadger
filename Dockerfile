FROM alpine:3.4
MAINTAINER Ross Fairbanks "ross@microscaling.com"

RUN apk update && \
    apk upgrade && \
    rm -rf /var/cache/apk/*

# Add binary and supporting files
COPY badger3 index.html Dockerfile /

# Metadata params
ARG BUILD_DATE
ARG VCS_URL
ARG VCS_REF
ARG VERSION

# Metadata
LABEL com.microbadger.youtube-video="EIyixC9NsLI" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.schema-version="1.0-rc1" \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version=$VERSION 

CMD ["/badger3"]
