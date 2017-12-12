#!/bin/sh

printf "\n###############################\n"
printf "# Initializing docker project #\n"
printf "###############################\n\n"

# Project name
printf "Please enter your project name: "
read input_projectname
printf -- "--> Project name set to: ${input_projectname}\n\n"

sed -i '' "s/{projectName}/${input_projectname}/g" ./docker-compose.yml
sed -i '' "s/{projectName}/${input_projectname}/g" ./docker/environment/mysql
sed -i '' "s/{projectName}/${input_projectname}/g" ./docker/mysql/script/import_dump.sh
sed -i '' "s/{projectName}/${input_projectname}/g" ./docker/mysql/script/export_dump.sh
sed -i '' "s/{projectName}/${input_projectname}/g" ./tools/mysql/mysql_import_dump.sh
sed -i '' "s/{projectName}/${input_projectname}/g" ./tools/mysql/mysql_export_dump.sh

# vHost
printf "Please enter your project's vhost name: "
read input_vhostname
printf -- "--> vHost set to: ${input_vhostname}\n\n"

sed -i '' "s/{vhost_name}/${input_vhostname}/g" ./docker/environment/env-settings

# php version
printf "Please enter your php version (e.g. 7.1): "
read input_php_version
printf -- "--> PHP version set to: ${input_php_version}\n\n"

sed -i '' "s/{php_version}/${input_php_version}/g" ./Dockerfile

# MySQL version
printf "Please enter your mysql version (e.g. 5.7): "
read input_mysql_version
printf -- "--> MySQL version set to: ${input_mysql_version}\n\n"

sed -i '' "s/{mysql_version}/${input_mysql_version}/g" ./docker-compose.yml

# Init TYPO3 project
while true; do
    read -p 'Init as TYPO3 project? ' answer
    case $answer in
        [Yy]* )

        # TYPO3 version
        printf "Please enter your TYPO3 version (e.g. 8.7): "
        read input_typo3_version
        sed -i '' "s/{typo3_version}/${input_typo3_version}/g" ./tools/typo3/typo3_init.sh

        ./tools/typo3/typo3_init.sh

        break;;
        [Nn]* ) printf '--> Skipping this step'; break;;
        * ) printf "### Please answer [y]es or [n]o.";;
    esac
done

# Disable the init file
mv ./init.sh ./init.sh.done

printf "\n\n######################\n"
printf "# All done \o/ ENJOY #\n"
printf "######################\n"
