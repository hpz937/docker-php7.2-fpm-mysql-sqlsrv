FROM php:7.2-fpm
RUN apt-get update \
&& apt-get -y install gnupg \
&& curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
&& curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
&& apt-get update \
&& ACCEPT_EULA=Y apt-get -y --no-install-recommends install msodbcsql17 unixodbc-dev \
&& docker-php-ext-install mbstring pdo \
&& pecl install sqlsrv pdo_sqlsrv xdebug \
&& docker-php-ext-enable sqlsrv pdo_sqlsrv xdebug \
&& docker-php-ext-install mysqli \
&& sed -i "s/MinProtocol = TLSv1.2/MinProtocol = TLSv1.0/" /etc/ssl/openssl.cnf \
&& sed -i "s/CipherString = DEFAULT@SECLEVEL=2/CipherString = DEFAULT@SECLEVEL=1/" /etc/ssl/openssl.cnf
