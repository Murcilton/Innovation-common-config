FROM php:8.3-fpm

# Устанавливаем скрипт для установки PHP расширений
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions

# Устанавливаем необходимые пакеты
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    wget \
    ffmpeg \
    libzip-dev \
    libicu-dev \
    libpng-dev \
    libjpeg-dev \
    libwebp-dev \
    libfreetype6-dev \
    libavif-dev \
    libaom-dev \
    libxpm-dev \
    libjpeg62-turbo-dev \
    libpq-dev \
    zip \
    gnupg2 \
    ca-certificates \
    lsb-release \
    apt-transport-https && \
    apt-get clean

# Устанавливаем PHP расширения
RUN docker-php-ext-install -j$(nproc) pdo_mysql mysqli bcmath sockets calendar gettext && \
    docker-php-ext-configure gd --with-freetype --with-webp --with-jpeg --with-avif --with-xpm && \
    docker-php-ext-install -j$(nproc) gd && \
    docker-php-ext-enable gd && \
    docker-php-ext-configure intl && docker-php-ext-install intl && \
    docker-php-ext-configure exif && docker-php-ext-install exif && docker-php-ext-enable exif && \
    docker-php-ext-install pcntl && \
    docker-php-ext-enable opcache && \
    docker-php-ext-install zip && \
    docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && \
    docker-php-ext-install pdo pdo_pgsql pgsql

# Устанавливаем Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
    --filename=composer \
    --install-dir=/usr/local/bin

# Устанавливаем openswoole
RUN pecl install openswoole \
    && docker-php-ext-enable openswoole

# Устанавливаем PostgreSQL клиент
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(. /etc/os-release; echo $VERSION_CODENAME)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
    apt-get update && \
    apt-get install -y postgresql-client-17

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nodejs \
    npm                       # note this one
RUN npm install --save-dev chokidar

RUN apt-get update && apt-get install -y procps

# Копируем PHP конфигурации
COPY ./docker/php/php.ini /usr/local/etc/php/conf.d/php.ini
COPY ./docker/php/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# Рабочая директория
WORKDIR /var/www
