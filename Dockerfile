FROM rjarow/alpine-nginx-phpfpm
# This container picks up my nginx/php image as a base and does all the work using s6-overlay once the files are copied in.
# nginx and phpfpm run as services under s6
LABEL maintainer "Rich J github.com/rjarow" architecture="AMD64/x86_64"

# Set grav version desired here.
ENV GRAV_VERSION="1.3.10"

COPY files/ /

# files/etc/cont-init.d/90-grav does all the heavy lifting here.

# These can be removed later once nginx-phpfpm dev goes to master, added in that image as well
RUN apk update && \
    apk add zendframework php7-simplexml