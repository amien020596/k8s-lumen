
FROM php:7.4-fpm

# Install dockerize so we can wait for containers to be ready
RUN curl -s -f -L -o /tmp/dockerize.tar.gz https://github.com/jwilder/dockerize/releases/download/v$DOCKERIZE_VERSION/dockerize-linux-amd64-v$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf /tmp/dockerize.tar.gz \
    && rm /tmp/dockerize.tar.gz

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    git \
    vim \
    libmemcached-dev \
    libz-dev \
    libpq-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libssl-dev \
    libmcrypt-dev \
    libzip-dev \
    unzip \
    zip \
    nodejs \
    && docker-php-ext-configure gd \
    && docker-php-ext-configure zip \
    && docker-php-ext-install \
    gd \
    exif \
    opcache \
    pdo_mysql \
    pdo_pgsql \
    pcntl \
    zip \
    && rm -rf /var/lib/apt/lists/*;

COPY . /var/www/html
WORKDIR /var/www/html

RUN rm /etc/nginx/sites-enabled/default

COPY /docker/nginx/nginx.conf /etc/nginx/conf.d/default.conf

ADD https://getcomposer.org/download/1.6.2/composer.phar /usr/bin/composer
RUN chmod +rx /usr/bin/composer

RUN composer install

RUN cp .env.example .env
RUN php artisan key:generate

RUN chmod +x ./entrypoint

ENTRYPOINT ["./entrypoint"]

EXPOSE 80