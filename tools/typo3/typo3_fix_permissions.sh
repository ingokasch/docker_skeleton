#!/bin/sh

echo "### Fixing permissions - LocalConfiguration.php"
sudo chmod 777 /htdocs/spiegelau/spiegelauwebsiterelaunch/typo3conf/LocalConfiguration.php
echo "### Fixing permissions - PackageStages.php"
sudo chmod 777 /htdocs/spiegelau/spiegelauwebsiterelaunch/typo3conf/PackageStates.php