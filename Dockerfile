FROM wordpress:php8.2-apache

RUN apt-get update && apt-get install -y \
    libpq-dev \
    git \
    unzip \
    && docker-php-ext-install pgsql pdo pdo_pgsql

WORKDIR /var/www/html

RUN git clone https://github.com/kevinoid/postgresql-for-wordpress.git /tmp/pg4wp && \
    mv /tmp/pg4wp/pg4wp /var/www/html/wp-content/ && \
    cp /var/www/html/wp-content/pg4wp/db.php /var/www/html/wp-content/

# Force SSL Supabase
RUN sed -i "s/define('DB_HOST'.*/define('DB_HOST', getenv('DB_HOST') . ' sslmode=require');/g" /var/www/html/wp-content/db.php

RUN chown -R www-data:www-data /var/www/html
