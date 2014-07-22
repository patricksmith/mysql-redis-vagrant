mysql-redis-vagrant
===================

Very simple Vagrantfile to provision a VM with MySQL and Redis.


MySQL
-----

The `root` user will be created with the password `root` (or change, `PASSWORD` in `provision.sh`). You can then connect to MySQL by running `mysql -uroot -proot -h 127.0.0.1` on the host machine.

If `dump.sql` exists, the data will be loaded into MySQL.


Redis
-----

Redis will be copmiled from source (using [latest stable version](http://download.redis.io/redis-stable.tar.gz)) and installed using the default settings.
