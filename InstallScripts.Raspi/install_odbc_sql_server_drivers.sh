#!/bin/sh

# install MS SQL Server drivers
# https://gist.github.com/rduplain/1293636

sudo apt-get install unixodbc unixodbc-dev

sudo apt-get install freetds-dev freetds-bin tdsodbc

# automatic configuration in /etc/odbcinst.ini
sudo dpkg-reconfigure tdsodbc


# manual configuration

# In /etc/odbcinst.ini:
# Ubuntu
# ----
# [FreeTDS]
# Description=FreeTDS Driver
# Driver=/usr/lib/odbc/libtdsodbc.so
# Setup=/usr/lib/odbc/libtdsS.so
# ----

# Ubuntu 64
# ----
# [FreeTDS]
# Description=FreeTDS Driver
# Driver=/usr/lib/x86_64-linux-gnu/odbc/libtdsodbc.so
# Setup=/usr/lib/x86_64-linux-gnu/odbc/libtdsS.so
# ----

# Raspberry PI
# ----
# [FreeTDS]
# Description=FreeTDS Driver
# Driver=/usr/lib/arm-linux-gnueabihf/odbc/libtdsodbc.so
# Setup=/usr/lib/arm-linux-gnueabihf/odbc/libtdsS.so
# ----
