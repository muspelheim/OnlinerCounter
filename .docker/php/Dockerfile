FROM php:7.4-fpm

RUN pecl install redis xdebug-2.9.8 apcu && docker-php-ext-enable redis xdebug apcu

RUN apt update && apt install git -y

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY conf/php.ini $PHP_INI_DIR/conf.d/zz-php.ini
COPY conf/xdebug.ini $PHP_INI_DIR/conf.d/zz-xdebug.ini
