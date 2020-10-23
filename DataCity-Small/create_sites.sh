mkdir drupal/
mkdir drupal/sites/
docker run --rm drupal:7.73-apache tar -cC /var/www/html/sites . | tar -xC drupal/sites
mkdir drupal/sites/default/files
chmod 777 drupal/sites/default/files
cp drupal/sites/default/default.settings.php drupal/sites/default/settings.php
chmod 777 drupal/sites/default/settings.php

