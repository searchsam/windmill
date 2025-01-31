#!/bin/bash

# Iniciar MySQL
service mysql start

# Esperar a que MySQL esté disponible
while ! mysqladmin ping --silent; do
    echo "Esperando a que MySQL inicie..."
    sleep 1
done

# Inicializar MySQL con datos predeterminados
mysql -uroot -p${MYSQL_ROOT_PASSWORD} < /docker-entrypoint-initdb.d/init.sql


# Iniciar PHP-FPM
service php8.1-fpm start

# Iniciar Nginx
service nginx start

# Iniciar Redis
#service redis-server start

# Iniciar Mailpit
mailpit &

# Mantener el contenedor en ejecución
tail -f /dev/null

