#!/bin/sh
echo "Aspetta 20 secondi (per essere sicuro che mysql sia attivo)!"

# check if drupal has already been installed
if [ ! -e /var/www/html/sites/default/settings.php ]
then

  # wait - sql might still be spawning
  sleep 20

  echo "Ciao2!"

  # pear install Console_Table
  # 
  # drush -y si \
  #   --db-url="mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}/${MYSQL_DATABASE}" \
  #   --account-name="admin" \
  #   --account-pass="${DRUPAL_ADMIN_PASSWORD}" \
  #   --site-name="${DRUPAL_SITE_NAME}" \
  #   -v --debug
  #   #--locale="de" \

fi

# call the entrypoint of the base-baseimage (php:7.1-apache) manually
docker-php-entrypoint apache2-foreground
