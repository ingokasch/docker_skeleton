#!/bin/bash

docker-compose exec mysql-{projectName} /bin/bash -c '/tmp/mysql/script/export_dump.sh'