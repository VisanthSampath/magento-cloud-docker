# This file is automatically generated. Do not edit directly. #
FROM php:7.3-cli-stretch
ARG GOSU_VERSION=1.11

ENV PHP_MEMORY_LIMIT 2G
ENV MAGENTO_ROOT /app
ENV DEBUG false
ENV MAGENTO_RUN_MODE production
ENV UPDATE_UID_GID false
ENV COMPOSER_ALLOW_SUPERUSER 1

ENV PHP_EXTENSIONS bcmath bz2 calendar exif gd gettext intl mysqli opcache pdo_mysql redis soap sockets sysvmsg sysvsem sysvshm xsl zip pcntl

# Configure Node.js version
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash

# Install dependencies
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
  apt-utils \
  cron \
  git \
  mariadb-client \
  nano \
  nodejs \
  python3 \
  python3-pip \
  redis-tools \
  rsyslog \
  sendmail \
  sendmail-bin \
  sudo \
  unzip \
  vim \
  libbz2-dev \
  libjpeg62-turbo-dev \
  libpng-dev \
  libfreetype6-dev \
  libgeoip-dev \
  wget \
  libgmp-dev \
  libmagickwand-dev \
  libmagickcore-dev \
  libc-client-dev \
  libkrb5-dev \
  libicu-dev \
  libldap2-dev \
  libpspell-dev \
  librecode0 \
  librecode-dev \
  libtidy-dev \
  libxslt1-dev \
  libyaml-dev \
  libzip-dev \
  zip \
  && rm -rf /var/lib/apt/lists/*

# Install PyYAML
RUN pip3 install --upgrade setuptools \
    && pip3 install pyyaml

# Install Grunt
RUN npm install -g grunt-cli

# Configure the gd library
RUN docker-php-ext-configure \
  gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-configure \
  imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-configure \
  ldap --with-libdir=lib/x86_64-linux-gnu
RUN docker-php-ext-configure \
  opcache --enable-opcache
RUN docker-php-ext-configure \
  zip --with-libzip

# Install required PHP extensions
RUN docker-php-ext-install -j$(nproc) \
  bcmath \
  bz2 \
  calendar \
  exif \
  gd \
  gettext \
  gmp \
  imap \
  intl \
  ldap \
  mysqli \
  opcache \
  pdo_mysql \
  pspell \
  recode \
  shmop \
  soap \
  sockets \
  sysvmsg \
  sysvsem \
  sysvshm \
  tidy \
  xmlrpc \
  xsl \
  zip \
  pcntl

RUN pecl install -o -f \
  geoip-1.1.1 \
  igbinary \
  imagick \
  mailparse \
  msgpack \
  oauth \
  pcov \
  propro \
  raphf \
  redis \
  xdebug-2.7.1 \
  yaml

RUN rm -f /usr/local/etc/php/conf.d/*sodium.ini \
  && rm -f /usr/local/lib/php/extensions/*/*sodium.so \
  && apt-get remove libsodium* -y  \
  && mkdir -p /tmp/libsodium  \
  && curl -sL https://github.com/jedisct1/libsodium/archive/1.0.18-RELEASE.tar.gz | tar xzf - -C  /tmp/libsodium \
  && cd /tmp/libsodium/libsodium-1.0.18-RELEASE/ \
  && ./configure \
  && make && make check \
  && make install  \
  && cd / \
  && rm -rf /tmp/libsodium  \
  && pecl install -o -f libsodium
RUN cd /tmp \
  && curl -O https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz \
  && tar zxvf ioncube_loaders_lin_x86-64.tar.gz \
  && export PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;") \
  && export PHP_EXT_DIR=$(php-config --extension-dir) \
  && cp "./ioncube/ioncube_loader_lin_${PHP_VERSION}.so" "${PHP_EXT_DIR}/ioncube.so" \
  && rm -rf ./ioncube \
  && rm ioncube_loaders_lin_x86-64.tar.gz

RUN docker-php-ext-enable \
  bcmath \
  bz2 \
  calendar \
  exif \
  gd \
  geoip \
  gettext \
  gmp \
  igbinary \
  imagick \
  imap \
  intl \
  ldap \
  mailparse \
  msgpack \
  mysqli \
  oauth \
  opcache \
  pcov \
  pdo_mysql \
  propro \
  pspell \
  raphf \
  recode \
  redis \
  shmop \
  soap \
  sockets \
  sodium \
  sysvmsg \
  sysvsem \
  sysvshm \
  tidy \
  xdebug \
  xmlrpc \
  xsl \
  yaml \
  zip \
  pcntl \
  ioncube

ADD etc/php-cli.ini /usr/local/etc/php/conf.d/zz-magento.ini
ADD etc/php-xdebug.ini /usr/local/etc/php/conf.d/zz-xdebug-settings.ini
ADD etc/php-pcov.ini /usr/local/etc/php/conf.d/zz-pcov-settings.ini
ADD etc/mail.ini /usr/local/etc/php/conf.d/zz-mail.ini

# Get composer installed to /usr/local/bin/composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ADD bin/* /usr/local/bin/

RUN groupadd -g 1000 www && useradd -g 1000 -u 1000 -d ${MAGENTO_ROOT} -s /bin/bash www

ADD docker-entrypoint.sh /docker-entrypoint.sh

RUN ["chmod", "+x", \
    "/docker-entrypoint.sh", \
    "/usr/local/bin/magento-installer", \
    "/usr/local/bin/magento-command", \
    "/usr/local/bin/mftf-command", \
    "/usr/local/bin/ece-command", \
    "/usr/local/bin/cloud-build", \
    "/usr/local/bin/cloud-deploy", \
    "/usr/local/bin/cloud-post-deploy", \
    "/usr/local/bin/run-cron", \
    "/usr/local/bin/run-hooks" \
]

RUN mkdir -p ${MAGENTO_ROOT}

VOLUME ${MAGENTO_ROOT}

ENTRYPOINT ["/docker-entrypoint.sh"]

USER root

WORKDIR ${MAGENTO_ROOT}

CMD ["bash"]
