# Usa una imagen base mínima de Linux
FROM debian:bullseye-slim

# Establece variables de entorno para NVM
ENV NVM_DIR=/usr/local/nvm
ENV NODE_VERSION=v20.15.0

# Instala las dependencias necesarias
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Instala NVM, Node.js, y PNPM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm use $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && curl -fsSL https://get.pnpm.io/install.sh | bash

# Añadir NVM, Node y PNPM al PATH
ENV PATH="$NVM_DIR/versions/node/v$NODE_VERSION/bin:/root/.local/share/pnpm:/usr/local/share/pnpm:$PATH"

# Directorio de trabajo
WORKDIR /usr/src/app

# Copia el contenido del directorio actual al directorio de trabajo del contenedor
COPY . .

# Exponer el puerto necesario
EXPOSE 3000 5173

# Comando predeterminado
CMD ["node"]
