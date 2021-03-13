FROM php:7.4.1-apache

RUN apt-get update && apt-get install -y libpng-dev libonig-dev libxml2-dev zip unzip curl

RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY .docker/vhost.conf /etc/apache2/sites-available/000-default.conf

COPY . /var/www/html

RUN composer install

RUN chown -R www-data:www-data /var/www/html \
    && a2enmod rewrite

WORKDIR /var/www/html

EXPOSE  80


