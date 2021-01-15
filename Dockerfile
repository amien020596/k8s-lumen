
FROM php:7.3.26-apache-stretch

COPY --chown=www-data:www-data . /var/www/html

COPY ./deploy/vhost.conf /etc/apache2/sites-available/000-default.conf 

RUN docker-php-ext-install mbstring pdo pdo_mysql \ 
    && a2enmod rewrite negotiation \
    && docker-php-ext-install opcache

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

RUN chmod -R 0777 ./storage

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install

RUN cp .env.example .env
