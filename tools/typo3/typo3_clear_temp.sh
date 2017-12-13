#!/bin/sh

echo "-->d Cleaning the typo3temp folder"
docker-compose exec web-{projectName} /bin/bash -c 'rm -rf /var/www/html/typo3temp/*'