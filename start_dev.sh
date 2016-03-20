#!/bin/sh
#sudo service postgresql status
sudo service postgresql start

rails s -b $IP -p $PORT