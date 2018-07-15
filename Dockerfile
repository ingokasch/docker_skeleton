FROM php:{php_version}-apache

MAINTAINER Ingo Kasch <ingo.kasch@loom-dxp.com>

RUN usermod -u 500 www-data && groupmod -g 500 www-data

RUN a2enmod rewrite

RUN rm -rf /var/www/html/*

RUN echo "deb http://deb.debian.org/debian stretch main" > /etc/apt/sources.list.d/stretch.list && \
    echo "Package: *\\nPin: release n=jessie\\nPin-Priority: 900\\n\\nPackage: libpcre3*\\nPin: release n=stretch\\nPin-Priority: 1000" > /etc/apt/preferences

RUN touch /etc/apt/apt.conf.d/99fixbadproxy
RUN echo "Acquire::http::Pipeline-Depth 0;" >> /etc/apt/apt.conf.d/99fixbadproxy
RUN echo "Acquire::http::No-Cache true;" >> /etc/apt/apt.conf.d/99fixbadproxy
RUN echo "Acquire::BrokenProxy true;" >> /etc/apt/apt.conf.d/99fixbadproxy
RUN apt-get update -o Acquire::CompressionTypes::Order::=gz
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update -y

# Fix outdated PCRE bug in Debian 8
RUN apt-get install -y -t stretch libpcre3 libpcre3-dev

RUN apt-get install -y libpng-dev libmcrypt-dev libmcrypt4 libcurl3-dev libfreetype6 libjpeg62-turbo libjpeg62-turbo-dev libfreetype6-dev libicu-dev libxslt1-dev imagemagick gettext vim git wget colordiff curl rsync ssh mysql-client zip ssmtp cron
RUN rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-install mcrypt
RUN docker-php-ext-install gettext
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install zip
RUN docker-php-ext-install intl
RUN docker-php-ext-install xsl
RUN docker-php-ext-install soap
RUN docker-php-ext-install opcache

RUN pecl install xdebug-2.5.0
RUN apt-get purge --auto-remove -y libpng-dev libmcrypt-dev libcurl3-dev libfreetype6-dev libjpeg62-turbo-dev

RUN chmod +x /usr/local/bin/*

COPY ./docker/apache/copyToContainer/* /usr/local/etc/php/conf.d/

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

#RUN sed -i 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-enabled/000-default.conf
RUN sed -i 's!mailhub=mail!mailhub=mail-{projectName}:1025!g' /etc/ssmtp/ssmtp.conf
RUN sed -i 's!#FromLineOverride=YES!FromLineOverride=YES!g' /etc/ssmtp/ssmtp.conf

# Redirect the log files (needed due to nginx proxy)
RUN rm -f /var/log/apache2/error.log
RUN rm -f /var/log/apache2/access.log
RUN touch /var/log/apache2/error.log
RUN touch /var/log/apache2/access.log
