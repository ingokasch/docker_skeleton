# docker_skeleton

### What is it?
The docker_skeleton is a kick starter for docker based web development projects (e. g. TYPO3).

### What am I able to do with it?
The docker_skeleton will support you to quickly collect the configuration you need, without having to write any line of "Dockerfile" or "docker-compose.yml" configuration code.

It uses all official vendor images (e. g. php) for building your project.

### What services are included?
The docker_skeleton offers the following services atm:

* **Apache2 / PHP**
* **MySQL**
* **nginx-proxy** (use real domain names in your development process)
* **phpMyAdmin**
* **mailhog**

Please see "[7. Service frontends](#7-service-frontends)" in the "[Getting started section](#getting-started)".

---
# Getting started

### 1. Download
Clone or download this repository.


### 2. Check you ports
As a locally installed application, a docker container will bind itself to a specific port.

Please make sure that the following TCP ports are free:

* **80** (Web frontend - used by the nginx-proxy container)
* **8080** (Web frontend - used by the apache2 webserver container)
* **3306** (Database communication - used by the MySQL database container)
* **8091** (phpMyAdmin frontend - used by the phpMyAdmin container)
* **9055** (mailhog frontend - used by the mailhog container)

**Notice:  
All ports can be modified in the "docker-compose.yml" file.**


### 3. Run the init script
The init script will run through a series of questions. The docker_skeleton will build your environment depending on your answers.

Run the init script from your terminal:

```
./init.sh
```
### 4. What questions will be asked and what are your options?

#### 4.1 Project name
The project name will be used to name your containers. As multiple docker containers can be used, a unique name e. g. "example-website" is recommended.

```
Please enter your project name: example-website
```


#### 4.2 Virtual host (vHost)
The domain name under which you will be able to access the webserver e. g. "dev.example.com".

```
Please enter your project's vhost name: dev.example.com
```

**Attention:  
Please sure to add the virtual host to your host file.**

The line should look like this:
```
127.0.0.1 dev.example.com
```


#### 4.3 php version
You are able to choose any php version that is available as an [official vendor docker apache image](https://hub.docker.com/_/php/) (see images with "-apache" postfix e. g. "7.1-apache, 7.2-apache").

**Attention:  
As the docker_skeleton only supports apache images you only need to enter the needed php version.**

If you want the php verison "**7.1**" you just need to enter: 

```
Please enter your php version (e.g. 7.1): 7.1
```


#### 4.4 MySQL version
You are able to choose any MySQL version that is available as an [official vendor docker apache image](https://hub.docker.com/_/mysql/).

If you want the MySQL verison "**5.7**" you just need to enter: 

```
Please enter your mysql version (e.g. 5.7): 5.7
```


### 5. TYPO3 project
The docker_skeleton supports the implementation of TYPO3. If you want to include TYPO3 answere the question with "**yes or y**", otherwise answere with "**no or n**" and the step will be skipped.

```
Init as TYPO3 project? yes/no
```


#### 5.1 TYPO3 version
You are able to choose any TYPO3 version that is available https://get.typo3.org/.

If you want the latest TYPO3 **8.7**-branch version you just need to enter: 

```
Please enter your TYPO3 version (e.g. 8.7): 8.7
```

You can also use strict versions from any branch:

```
Please enter your TYPO3 version (e.g. 8.7): 8.7.9
```

**Notice:  
Please read the section "2.2 Update the TYPO3 core" in the "Tools" section**.

#### 5.2 Download and create symlinks
If you want to download and symlink the chosen TYPO3 version, answere the question with "**yes or y**", otherwise answere with "**no or n**" and the step will be skipped.

```
1. Download and symlink TYPO3 SRC? yes/no
```
The following symlinks would be created:
 
* typo3_src
* typo3
* index.php


#### 5.3 Create initial installation files/folders
If you want to create the initial installation files and folders, answere the question with "**yes or y**", otherwise answere with "**no or n**" and the step will be skipped.

```
2. Is this the initial installation (folders, .htaccess and FIRST_INSTALL file will be created)? yes/no
```
The following files/folders would be created:
 
* fileadmin [d]
* uploads [d]
* typo3conf [d]
* FIRST_INSTALL [f]
* .htaccess [f] - will be copied from the TYPO3 source folder

**Attention:  
If any of the files and folders mentioned above exists prior to running the script, they will NOT be overwritten.**


#### 5.4 Import database dump
If you want to import a database dump, answere the question with "**yes or y**", otherwise answere with "**no or n**" and the step will be skipped.

```
3. Import database dump? yes/no
```

The database dump needs to be placed in the folder "**docker/mysql/dump/**" and it needs to be named like the project you named in step 4.1 followed by "**_01**" and needs to be a "**.sql**" file.

For example:

Your project is named "**example-website**"

```
Please enter your project name: example-website
```

Then your sql file need to be named:

```
example-website_01.sql
```

### 6. Start up your environment
After configuring your environment you and build and run your docker setup using

```
docker-compose up -d
```

It might take a while for docker to build your webserver container and to download all the needed sources. After your containers are build the start up process will be much faster.

You can rebuild your containers at any time using the default docker-compose command
```
docker-compose build
```

### 7. Service frontends

Some container e. g. phpMyAdmin offer a frontend. The frontends can be accessed by via the defined ports:

* **Apache2 / PHP**: Use the URL entered in "[4.2 Virtual host (vHost)](#42-virtual-host-vhost)"
* **phpMyAdmin**: 127.0.0.1:8091 or localhost:8091 or your vHost URL (see [4.2 Virtual host (vHost)](#42-virtual-host-vhost)) followed by the port 8091
* **mailhog**: 127.0.0.1:9055 or localhost:9055 or your vHost URL (see [4.2 Virtual host (vHost)](#42-virtual-host-vhost)) followed by the port 9055
* **MySQL**: No Frontend available
* **nginx-proxy** No Frontend available

---

# Tools
The docker_skeleton ships with some handy tools supporting you in everyday development tasks.


## 1. MySQL
### 1.1 Import MySQL database dump
To import a MySQL database dump run the following command in your CLI:

```
./tools/mysql_import_dump.sh
```

The dump file (.sql) must be placed here: "**docker/mysql/dump/${projectName}_01.sql**"

### 1.2 Export MySQL database dump
To export your database run the following command in your CLI:

```
./tools/mysql_export_dump.sh
```

The exported .sql file will be stored here: "**docker/mysql/dump/${projectName}_01.sql**"

**Attention:  
An existing .sql file will be overwritten.**


## 2. TYPO3
### 2.1 Initialize a TYPO3 project
To initialize a TYPO3 project (see "[5. TYPO3 project](#5-typo3-project)" in the "[Getting started section](#getting-started)") run the following command in your CLI:

```
./tools/typo3/typo3_init.sh
```

### 2.2 Update the TYPO3 core
To update the TYPO3 run the following initialization command in your CLI:

```
./tools/typo3/typo3_init.sh
```
This will promt you with the questions of the initialization script (see [5.2](#52-download-and-create-symlinks), [5.3](#53-create-initial-installation-filesfolders) and [5.4](#54-import-database-dump) in the "[Getting started section](#getting-started)").

To update the core files you only need to download and symlink TYPO3 sources (see [5.2](#52-download-and-create-symlinks) in the "[Getting started section](#getting-started)").

```
1. Download and symlink TYPO3 SRC? yes
```

The other questions (see [5.3](#53-create-initial-installation-filesfolders) and [5.4](#54-import-database-dump) in the "**Gettings started**" section) should be answered with "**no**".

**Notice:  
Updating the TYPO3 core files this way only works if you have not specified a strict TYPO3 version e. g. "8.7.9". Instead use the latest 8.7-branch version using "8.7" while initializing your project (see [5.1](#51-typo3-version) in the "[Getting started section](#getting-started)").**

### 2.3 Clear TYPO3 cache
Clearing the cache is a frequently used task while developing TYPO3 projects, esp. if you are developing extensions. To clear the system cache run the following command in your CLI:

```
./tools/typo3/typo3_clear_temp.sh
```
The task will clear your "typo3temp" directory and specific database cache tables.


### 2.4 Fix file permission
Sometimes the permission of the "LocalConfiguration.php" and "PackageStates.php" files are set incorrectly, resulting in not being able to install/uninstall extensions or access the install tool. Run the following command in your CLI to fix the file permissions:

```
./tools/typo3/typo3_fix_permissions.sh
```

---
# File/Folder structure
This section will describe the file and folder structure of the docker_skeleton.

| File&#160;[f]&#160;/&#160;Folder&#160;[d]&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; | Description | Additional information |
|:--- |:---| :---|
| docker [d]| General storage folder for docker configuration/script files ||
|&#160;|&#160;|&#160;|
| . apache [d]| apache configuration folder||
| . . copyToContainer [d]| Files/Folders in this folder will be copied to the apache webserver container||
| . . . php [d]| php configuration files||
| . . . . ssmtp.ini [f]|smtp configuration file|
| . . . . zzz_additional.ini [f]|php configuration file|
| . . . ssmtp [d]| ssmtp configuration files||
| . . . . ssmtp.conf [f]|ssmtp configuration file|
|&#160;|&#160;|&#160;|
| . environment [d]| environment configuration folder||
| . . env-settings [f]| environment configuration file||
| . . mysql [f]| mysql environment configuration file||
|&#160;|&#160;|&#160;|
| . mysql [d]| mysql configuration folder||
| . . copyToContainer [d]| Files/Folders in this folder will be copied to the MySQL container||
| . . . my.cnf [f]| MySQL configuration file||
| . . dump [d]| MySQL dump files (.sql) will be exported/imported to and from this folder||
| . . mysql_data [d]| This folder contains all MySQL database information|**MySQL database files. Do NOT modify!**|
| . . script [d]| MySQL scripts used by the tools|see "[Tools section](#tools)"|
|&#160;|&#160;|&#160;|
| . nginx-proxy [d]| nginx configuration folder||
|. . copyToContainer [d]| Files/Folders in this folder will be copied to the nginx container||
|. . . nginx.conf [f]| nginx configuration file|Currently **DISABLED** in the docker-compose.yml file|
|. . . proxy.conf [f]| nginx proxy configuration file|Currently **DISABLED** in the docker-compose.yml file|

---
# Final thoughts
The docker_skeleton might only be a kick starter for your project. Feel free to modify the created "Dockerfile" and "docker-compose.yml" files at any time.

If will refine the the process in the future and add more configuration options.

Feed free to leave my comments and suggestions.

For any docker specific questions please visit the [official docker documentation](https://docs.docker.com/).
