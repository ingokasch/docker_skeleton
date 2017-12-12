#!/bin/bash

echo "Please enter your project name: "
read input_projectname

sed -i '' "s/{projectName}/${input_projectname}/g" ./docker-compose.yml
sed -i '' "s/{projectName}/${input_projectname}/g" ./docker/environment/mysql
sed -i '' "s/{projectName}/${input_projectname}/g" ./docker/mysql/script/import_dump.sh
sed -i '' "s/{projectName}/${input_projectname}/g" ./docker/mysql/script/export_dump.sh
sed -i '' "s/{projectName}/${input_projectname}/g" ./tools/mysql/mysql_import_dump.sh
sed -i '' "s/{projectName}/${input_projectname}/g" ./tools/mysql/mysql_export_dump.sh

echo "Please enter your project's vhost name: "
read input_vhostname
sed -i '' "s/{vhost_name}/${input_vhostname}/g" ./docker/environment/env-settings

# php version
echo "Please enter your php version (e.g. 7.1): "
read input_php_version
sed -i '' "s/{php_version}/${input_php_version}/g" ./Dockerfile

# MySQL version
echo "Please enter your mysql version (e.g. 5.7): "
read input_mysql_version
sed -i '' "s/{mysql_version}/${input_mysql_version}/g" ./docker-compose.yml

# Init TYPO3 project
while true; do
    read -p 'Init as TYPO3 project? ' answer
    case $answer in
        [Yy]* )

        # TYPO3 version
        echo "Please enter your TYPO3 version (e.g. 8.7): "
        read input_typo3_version
        sed -i '' "s/{typo3_version}/${input_typo3_version}/g" ./tools/typo3/typo3_init.sh
        
        ./tools/typo3/typo3_init.sh

        break;;
        [Nn]* ) echo '--> Skipping this step'; break;;
        * ) echo "### Please answer yes or no.";;
    esac
done

# Disable the init file
mv ./init.sh ./init.sh.done