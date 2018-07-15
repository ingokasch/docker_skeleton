#!/bin/sh

# Output styling
bold=$(tput bold)
normal=$(tput sgr0)
underline=$(tput smul)

printf "\n###############################\n"
printf "# Initializing docker project #\n"
printf "###############################\n\n"

# Project name
printf "${underline}Please enter your project name:${normal} "
read input_projectname
printf -- "--> Project name set to: ${bold}${input_projectname}${normal}\n\n"

sed -i '' "s/{projectName}/${input_projectname}/g" ./docker-compose.yml
sed -i '' "s/{projectName}/${input_projectname}/g" ./Dockerfile
sed -i '' "s/{projectName}/${input_projectname}/g" ./docker/environment/mysql
sed -i '' "s/{projectName}/${input_projectname}/g" ./docker/mysql/script/import_dump.sh
sed -i '' "s/{projectName}/${input_projectname}/g" ./docker/mysql/script/export_dump.sh
sed -i '' "s/{projectName}/${input_projectname}/g" ./tools/mysql/import_dump.sh
sed -i '' "s/{projectName}/${input_projectname}/g" ./tools/mysql/export_dump.sh
sed -i '' "s/{projectName}/${input_projectname}/g" ./tools/typo3/clear_temp.sh
sed -i '' "s/{projectName}/${input_projectname}/g" ./tools/typo3/fix_permissions.sh
sed -i '' "s/{projectName}/${input_projectname}/g" ./tools/apache/access_log.sh
sed -i '' "s/{projectName}/${input_projectname}/g" ./tools/apache/error_log.sh

# vHost
printf "${underline}Please enter your project's vhost name:${normal} "
read input_vhostname
printf -- "--> vHost set to: ${bold}${input_vhostname}${normal}\n\n"

sed -i '' "s/{vhost_name}/${input_vhostname}/g" ./docker/environment/env-settings

# php version
printf "${underline}Please enter your php version (e.g. 7.1):${normal} "
read input_php_version
printf -- "--> PHP version set to: ${bold}${input_php_version}${normal}\n\n"

sed -i '' "s/{php_version}/${input_php_version}/g" ./Dockerfile

# MySQL version
printf "${underline}Please enter your mysql version (e.g. 5.7):${normal} "
read input_mysql_version
printf -- "--> MySQL version set to: ${bold}${input_mysql_version}${normal}\n\n"

sed -i '' "s/{mysql_version}/${input_mysql_version}/g" ./docker-compose.yml

printf "${underline}Project type:${normal}\n"
PS3='Choose your project type: '
options=("TYPO3" "Generic PHP project")
select opt in "${options[@]}"
do
    case $opt in
        "TYPO3")

            # TYPO3 version
            printf "${underline}Please enter your TYPO3 version (e.g. 8.7):${normal} "
            read input_typo3_version
            sed -i '' "s/{typo3_version}/${input_typo3_version}/g" ./tools/typo3/typo3_init.sh

            ./tools/typo3/typo3_init.sh
            break;
            ;;
        "Generic PHP project")
            echo "\n########################\r"
            echo "# Nothing to do here #\r"
            echo "########################\n"
            break;
            ;;
        *) echo "${underline}Invalid option '$REPLY' selected${normal}\n";;
    esac
done

# Disable the init file
mv ./init.sh ./init.sh.done

printf "\n######################\n"
printf "# All done \o/ ENJOY #\n"
printf "######################\n"
