#!/bin/sh

# uninstall MS SQL Server drivers

sudo apt-get remove --purge freetds-dev freetds-bin tdsodbc
sudo apt-get remove --purge unixodbc unixodbc-dev

