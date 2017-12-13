#!/bin/sh

echo "--> Fixing permissions - LocalConfiguration.php"
docker-compose exec web-{projectName} /bin/bash -c 'chmod 777 /var/www/html/typo3conf/LocalConfiguration.php'
echo "--> Fixing permissions - PackageStages.php"
docker-compose exec web-{projectName} /bin/bash -c 'chmod 777 /var/www/html/typo3conf/PackageStates.php'