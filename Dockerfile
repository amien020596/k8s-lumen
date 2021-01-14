
FROM php:7.3.26-apache-stretch

COPY --chown=www-data:www-data . /var/www/html

COPY ./deploy/vhost.conf /etc/apache2/sites-available/000-default.conf 

RUN docker-php-ext-install mbstring pdo pdo_mysql \ 
    && a2enmod rewrite negotiation \
    && docker-php-ext-install opcache

COPY . /var/www/html
WORKDIR /var/www/html

RUN chmod -R 0777 ./storage

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install

RUN cp .env.example .env
