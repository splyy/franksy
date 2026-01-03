FROM dunglas/frankenphp:1-php8.5

RUN install-php-extensions \
    pdo_pgsql \
    pgsql \
    intl \
    opcache \
    zip \
    apcu

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Optimisations OPcache
RUN echo "opcache.enable=1" >> "$PHP_INI_DIR/conf.d/opcache.ini" \
    && echo "opcache.memory_consumption=256" >> "$PHP_INI_DIR/conf.d/opcache.ini" \
    && echo "opcache.interned_strings_buffer=16" >> "$PHP_INI_DIR/conf.d/opcache.ini" \
    && echo "opcache.max_accelerated_files=20000" >> "$PHP_INI_DIR/conf.d/opcache.ini" \
    && echo "opcache.validate_timestamps=0" >> "$PHP_INI_DIR/conf.d/opcache.ini" \
    && echo "opcache.preload_user=www-data" >> "$PHP_INI_DIR/conf.d/opcache.ini"

# APCu pour le cache Symfony
RUN echo "apc.enable_cli=1" >> "$PHP_INI_DIR/conf.d/apcu.ini"

WORKDIR /app

ENV APP_ENV=dev
ENV FRANKENPHP_CONFIG="worker ./public/index.php"
ENV SERVER_NAME=":80"

EXPOSE 80 443

ENTRYPOINT ["frankenphp", "run", "--config", "/etc/caddy/Caddyfile"]
