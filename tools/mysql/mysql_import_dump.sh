#!/bin/bash

docker-compose exec mysql-{projectName} /bin/bash -c '/tmp/mysql/script/import_dump.sh'