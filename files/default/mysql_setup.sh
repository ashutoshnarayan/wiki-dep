#!/bin/bash

# installing epel release
cd /tmp
wget https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
rpm -Uvh epel-release-7-11.noarch.rpm
yum install pwgen

PASS=`pwgen -s 40 1`
echo $PASS > /tmp/mariadb_pass
mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE wikidatabase;
CREATE USER 'bob'@'localhost' IDENTIFIED BY '$PASS';
GRANT ALL PRIVILEGES ON wikidatabase.* TO 'bob'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

