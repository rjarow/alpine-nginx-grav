FROM rjarow/alpine64-s6:3.7.0
LABEL maintainer "Rich J github.com/rjarow" architecture="AMD64/x86_64"

# Set grav version here
ENV GRAV_VERSION="1.4.0"

RUN apk update && \
    # Packages you want
    apk add bash less vim nginx ca-certificates git tzdata zip \
    libmcrypt-dev zlib-dev gmp-dev zendframework\
    freetype-dev libjpeg-turbo-dev libpng-dev mysql-client curl \
    # PHP Modules
    php7-fpm php7-json php7-zlib php7-xml php7-simplexml php7-pdo php7-phar \
    php7-openssl php7-pdo_mysql php7-mysqli php7-session \
    php7-gd php7-iconv php7-mcrypt php7-gmp php7-zip \
    php7-curl php7-opcache php7-ctype php7-apcu \
    php7-intl php7-bcmath php7-dom php7-mbstring php7-xmlreader \
    php7-pdo php7-pdo_sqlite php7-pdo_mysql php7-sqlite3 && \
    # Add musl
    apk add -u musl && \
    # Delete cache
    rm -rf /var/cache/apk/*

RUN \
    # Modify PHP Settings
    sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php7/php.ini && \
    sed -i 's/expose_php = On/expose_php = Off/g' /etc/php7/php.ini && \
    # Allow nginx user a bash shell
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/usr:\/bin\/bash/g" /etc/passwd && \
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/usr:\/bin\/bash/g" /etc/passwd- && \
    # Link executables
    ln -s /sbin/php-fpm7 /sbin/php-fpm

COPY files/ /

ENV TERM="xterm"

EXPOSE 80

VOLUME ["/usr"]
