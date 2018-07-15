#!/bin/sh

echo "--> Cleaning the typo3temp folder"
docker-compose exec web-{projectName} /bin/bash -c 'rm -rf /var/www/html/typo3temp/*'

echo '--> Cleaning "cf_extbase_object"'
docker-compose exec mysql-{projectName} /bin/bash -c 'mysql -u root -p"root" -h mysql-{projectName} -e "TRUNCATE TABLE cf_extbase_object;" {projectName}_01'

echo '--> Cleaning "cf_extbase_reflection"'
docker-compose exec mysql-{projectName} /bin/bash -c 'mysql -u root -p"root" -h mysql-{projectName} -e "TRUNCATE TABLE cf_extbase_reflection;" {projectName}_01'

echo '--> Cleaning "cf_extbase_typo3dbbackend_tablecolumns"'
docker-compose exec mysql-{projectName} /bin/bash -c 'mysql -u root -p"root" -h mysql-{projectName} -e "TRUNCATE TABLE cf_extbase_typo3dbbackend_tablecolumns;" {projectName}_01'

echo '--> Cleaning "cf_extbase_typo3dbbackend_queries"'
docker-compose exec mysql-{projectName} /bin/bash -c 'mysql -u root -p"root" -h mysql-{projectName} -e "TRUNCATE TABLE cf_extbase_typo3dbbackend_queries;" {projectName}_01'

echo '--> Cleaning "cf_extbase_datamapfactory_datamap"'
docker-compose exec mysql-{projectName} /bin/bash -c 'mysql -u root -p"root" -h mysql-{projectName} -e "TRUNCATE TABLE cf_extbase_datamapfactory_datamap;" {projectName}_01'
