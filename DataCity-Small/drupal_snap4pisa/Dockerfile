FROM drupal:7.73-apache

#Aggiorna e installa i pacchetti che ci servono
RUN apt-get update

#Installa alcuni paccheti di base
RUN apt-get install -y  curl
RUN apt-get install -y nano wget

#Installa ldap  (per encriptare la password di ldap)
RUN apt-get install -y  libldap2-dev

#Configura ldap
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install ldap

#Aggiungi la lingua Italiana
WORKDIR /var/www/html/profiles/standard/translations
RUN curl -s -o drupal-7.73.it.po \
  https://ftp.drupal.org/files/translations/7.x/drupal/drupal-7.73.it.po


# Installa i moduli
WORKDIR /var/www/html/modules


# Clean repository
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

#crea la directory vuota di base
RUN mkdir /var/www/html_base/

RUN chown -R www-data:www-data /var/www/html

WORKDIR /etc/apache2/sites-available/
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf


WORKDIR /var/www/html/
# Installa Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    ln -s /root/.composer/vendor/bin/drush /usr/local/bin/drush

# Installa Drush
RUN composer global require drush/drush:7.x && \
    composer global update

# ctools module
ENV url https://ftp.drupal.org/files/projects/ctools-7.x-1.14.tar.gz
ENV md5_sum 88dbe403ecfe2fe434f4237e5fd5ec67
RUN curl -s -o module.tar.gz $url \
    && echo $md5_sum module.tar.gz | md5sum -c \
    && tar zxf module.tar.gz && rm module.tar.gz

# jquery_update module
ENV url https://ftp.drupal.org/files/projects/jquery_update-7.x-2.7.tar.gz
ENV md5_sum 85eaf02362c384979bc475df30ae7a3e
RUN curl -s -o module.tar.gz $url \
    && echo $md5_sum module.tar.gz | md5sum -c \
    && tar zxf module.tar.gz && rm module.tar.gz

RUN mkdir /var/www/html_base/diego


COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
