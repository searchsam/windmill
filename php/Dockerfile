# Usa la imagen oficial de PHP como base
FROM php:8.1-fpm

# Instala las dependencias necesarias, incluyendo oniguruma y Composer
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    libonig-dev \
    zip \
    unzip \
    curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql mbstring zip

# Instala Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Limpia la cache de apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Copia el contenido del directorio actual al directorio de trabajo del contenedor
COPY . /var/www/html

WORKDIR /var/www/html
