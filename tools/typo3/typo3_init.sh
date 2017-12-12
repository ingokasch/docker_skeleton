#!/bin/sh

echo "\n###############################\r"
echo "# Initializing TYPO3 instance #\r"
echo "###############################\n"

while true; do
    read -p '1. Download and symlink TYPO3 SRC? ' answer
    case $answer in
        [Yy]* ) echo '--> Creating files and folders\r';

        echo '--> Download TYPO3 SRC';
        wget -O - https://get.typo3.org/{typo3_version} | tar -xzf -

        echo '--> Linking typo3_src';
        rm -rf typo3_src
        ln -s typo3_src-* typo3_src

        echo '--> Linking typo3';
        rm -rf typo3
        ln -s typo3_src/typo3

        echo '--> Linking index.php';
        rm -f index.php
        ln -s typo3_src/index.php

        break;;
        [Nn]* ) echo '--> Skipping this step\r'; break;;
        * ) echo "\n### Please answer [y]es or [n]o.";;
    esac
done

echo "\r"

while true; do
    read -p '2. Is this the initial installation (folders, .htaccess and FIRST_INSTALL file will be created)? ' answer
    case $answer in
        [Yy]* ) echo '--> Creating files and folders\r';

        echo '--> Creating fileadmin';
        if [ ! -d "fileadmin" ]; then
          mkdir fileadmin
        fi

        echo '--> Creating uploads';
        if [ ! -d "uploads" ]; then
          mkdir uploads
        fi

        echo '--> Creating typo3conf';
        if [ ! -d "typo3conf" ]; then
          mkdir typo3conf
        fi

        echo '--> Creating .htaccess';
        if [ ! -f ".htaccess" ]; then
          cp typo3_src/_.htaccess .htaccess
        fi

        echo '--> Creating FIRST_INSTALL';
        if [ ! -f "FIRST_INSTALL" ]; then
          touch FIRST_INSTALL
        fi

        break;;
        [Nn]* ) echo '--> Skipping this step\r'; break;;
        * ) echo "\n### Please answer [y]es or [n]o.";;
    esac
done

echo "\r"

while true; do
    read -p '3. Import database dump? ' answer
    case $answer in
        [Yy]* ) echo '--> Importing dump\r';

        ../mysql/mysql_import_dump.sh

        break;;
        [Nn]* ) echo '--> Skipping this step\r'; break;;
        * ) echo "\n### Please answer [y]es or [n]o.";;
    esac
done

echo "\n########################\r"
echo "# TYPO3 is initialized #\r"
echo "########################\n"
