#!/bin/bash

docker-compose exec web-{projectName} /bin/bash -c 'tail -f /var/log/apache2/error.log'
