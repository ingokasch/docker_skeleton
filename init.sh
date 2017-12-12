#!/bin/bash

# MySQL version
echo "Please enter your mysql version (e.g. 5.7): "
read input_mysql_version
sed -i '' "s/{mysql_version}/${input_mysql_version}/g" ./docker-compose.yml

# php version
echo "Please enter your php version (e.g. 7.1): "
read input_php_version
sed -i '' "s/{php_version}/${input_php_version}/g" ./Dockerfile

echo "Please enter your project name: "
read input_projectname

echo "Your project ${input_projectname} will be created..."

sed -i '' "s/{projectName}/${input_projectname}/g" ./docker-compose.yml
sed -i '' "s/{projectName}/${input_projectname}/g" ./docker/environment/mysql
sed -i '' "s/{projectName}/${input_projectname}/g" ./docker/mysql/script/import_dump.sh
sed -i '' "s/{projectName}/${input_projectname}/g" ./docker/mysql/script/export_dump.sh
sed -i '' "s/{projectName}/${input_projectname}/g" ./tools/mysql/mysql_import_dump.sh
sed -i '' "s/{projectName}/${input_projectname}/g" ./tools/mysql/mysql_export_dump.sh

echo "Please enter your project's vhost name: "
read input_vhostname
sed -i '' "s/{vhost_name}/${input_vhostname}/g" ./docker/environment/env-settings

# MySQL version
echo "Please enter your mysql version (e.g. 5.7): "
read input_mysql_version
sed -i '' "s/{mysql_version}/${input_mysql_version}/g" ./docker-compose.yml

# php version
echo "Please enter your php version (e.g. 7.1): "
read input_php_version
sed -i '' "s/{php_version}/${input_php_version}/g" ./Dockerfile

# Init TYPO3 project
while true; do
    read -p 'Init as TYPO3 project? ' answer
    case $answer in
        [Yy]* ) ./tools/typo3/typo3_init.sh
        break;;
        [Nn]* ) echo '--> Skipping this step'; break;;
        * ) echo "### Please answer yes or no.";;
    esac
done

# Disable the init file
mv ./init.sh ./init.sh.done