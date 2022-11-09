#!/bin/bash


### Bash Script to install and set up  PostgreSQL 
### NB: This script must be run as a Super User else add `sudo` in front of all the commands listed below

## Update and Upgrade the system
apt -y update && sudo apt -y upgrade

## Install GnuPG for encryption
apt install -y gnupg2

## Add PostgreSQL's apt Repository
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

## Download PostgreSQL ASC Key
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

## Update and Upgrade the system
apt -y update && sudo apt -y upgrade

## Install PostgreSQL using apt
apt -y install postgresql-15 postgresql-contrib


## Create a new  database using postgreSQL
sudo -i -u postgres psql -c "CREATE DATABASE ugodb WITH ENCODING 'UTF8' TEMPLATE template0"


## Create a new user with password
sudo -i -u postgres psql -c "CREATE USER ugochukwu WITH ENCRYPTED PASSWORD '#altschoolEXAM2022'"


## Grant the new user all privileges on ugodb database
sudo -i -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE ugodb to ugochukwu"


## Configure login method  for the new user
echo -e 'local\tall\t\tdaniel\t\t\t\t\tmd5' >> /etc/postgresql/15/main/pg_hba.conf


## Restart PostgreSQL service
systemctl restart postgresql


## Login to ugoDB as  ugochukwu
psql -h localhost -U ugochukwu -d ugodb
