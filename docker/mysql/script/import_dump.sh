#!/bin/bash

mysql -u root -proot -h mysql-{projectName} --default_character_set utf8 {projectName}_01 < /tmp/mysql/dump/{projectName}_01.sql > /dev/null
