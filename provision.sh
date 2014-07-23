#!/bin/bash
PASSWORD='root'

sudo debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password_again password $PASSWORD"
sudo apt-get update
sudo apt-get -y install mysql-server-5.5

echo "Removing bind-address"
# Or change it to '0.0.0.0'
sudo sed -i "s/^bind-address/#bind-address/" /etc/mysql/my.cnf

echo "Restarting MySQL"
sudo service mysql restart

if [ -e /vagrant/dump.sql ]
then
    echo "Loading dump"
    mysql -uroot -p$PASSWORD < /vagrant/dump.sql
fi

# Allow root to connect from anywhere
echo "Updating privileges"
mysql -uroot -p$PASSWORD <<< "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"


## Install redis
sudo apt-get install make
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
sudo make install
# Install the service using defaults
echo -e '' | sudo ./utils/install_server.sh
