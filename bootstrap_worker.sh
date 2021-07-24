#!/bin/bash

#start ssh deamon
service ssh start

cd /usr/local/spark/sbin/

./start-slave.sh $1

/bin/bash

