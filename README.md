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

**!!! Please sure to add the virtual host to your host file !!!**

The line should look like this:
```
127.0.0.1 dev.example.com
```

#### 4.3 php version
You are able to choose any php version that is available as an [official vendor docker apache image](https://hub.docker.com/_/php/) (see images with "-apache" postfix e. g. "7.1-apache, 7.2-apache").

**!!! As the docker_skeleton only supports apache images you only need to enter the needed php version !!!**

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

If you want the TYPO3 verison "**8.7**" you just need to enter: 

```
Please enter your TYPO3 version (e.g. 8.7): 8.7
```

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

**!!! If any of the files and folders mentioned above exists prior to running the script, they will NOT be overwritten !!!**

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

### 7. Final thoughts
The docker_skeleton might only be a kick starter for your project. Feel free to modify the created "Dockerfile" and "docker-compose.yml" files at any time.

If will refine the the process in the future and add more configuration options.

Feed free to leave my comments and suggestions.
