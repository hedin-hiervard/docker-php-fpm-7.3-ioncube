FROM php:7.3-fpm

RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libzip-dev

RUN docker-php-ext-install zip mysqli pdo_mysql

RUN cd /tmp \
	&& curl -o ioncube.tar.gz http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz \
    && tar -xvvzf ioncube.tar.gz \
    && mv ioncube/ioncube_loader_lin_7.3.so /usr/local/lib/php/extensions/ \
    && rm -Rf ioncube.tar.gz ioncube \
    && echo "zend_extension=/usr/local/lib/php/extensions/ioncube_loader_lin_7.3.so" > /usr/local/etc/php/conf.d/00_docker-php-ext-ioncube_loader_lin_7.3.ini

WORKDIR /var/www

EXPOSE 9000

CMD ["php-fpm"]