#!/bin/bash

#start ssh deamon
service ssh start

cd /usr/local/spark/sbin/

./start-master.sh

/bin/bash

