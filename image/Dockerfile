# Usa una imagen base de Ubuntu 24.04
FROM ubuntu:24.04

# Variables de entorno para NVM y Node.js
ENV NVM_DIR=/usr/local/nvm
ENV NODE_VERSION=20.14.0

# Variables de entorno para MySQL
ENV MYSQL_ROOT_PASSWORD=laravel_root_password
ENV MYSQL_DATABASE=laravel_database
ENV MYSQL_USER=laravel_user
ENV MYSQL_PASSWORD=laravel_password

# Variables de entorno para proyecto laravel
ENV LARAVEL_DIR=/home/searchsam/Documentos

# Actualiza el sistema e instala dependencias básicas
RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    wget \
    gnupg2 \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    build-essential \
    git \
    unzip \
    zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala PHP 8.1 y extensiones necesarias
RUN add-apt-repository ppa:ondrej/php -y \
    && apt-get update && apt-get install -y \
    php8.1 \
    php8.1-cli \
    php8.1-fpm \
    php8.1-mysql \
    php8.1-zip \
    php8.1-gd \
    php8.1-mbstring \
    php8.1-curl \
    php8.1-xml \
    php8.1-bcmath \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Añade la clave GPG y el repositorio de MySQL 8
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server-8.0 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala Nginx
RUN apt-get update && apt-get install -y nginx \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala Redis
RUN apt-get update && apt-get install -y redis-server \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala Node.js, NVM y PNPM
RUN mkdir -p $NVM_DIR \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm use $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && npm install -g pnpm

# Añadir NVM, Node y PNPM al PATH
ENV PATH="$NVM_DIR/versions/node/v$NODE_VERSION/bin:/root/.local/share/pnpm:/usr/local/share/pnpm:$PATH"

# Instala Mailpit
RUN wget https://github.com/axllent/mailpit/releases/download/v1.4.0/mailpit-linux-amd64.tar.gz \
    && tar -xzf mailpit-linux-amd64.tar.gz -C /usr/local/bin \
    && rm mailpit-linux-amd64.tar.gz

# Configura Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Copia el script para crear enlaces simbólicos
COPY create_symlinks.sh /create_symlinks.sh
RUN chmod +x /create_symlinks.sh

# Ejecuta el script para crear enlaces simbólicos
RUN /create_symlinks.sh

# Copia el script de inicialización de MySQL
COPY init.sql /docker-entrypoint-initdb.d/init.sql

# Expon los puertos necesarios
EXPOSE 80 443 3306 6379 8025 5173

# Script de inicio para todos los servicios
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]

