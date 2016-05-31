#!/bin/sh
#sudo service postgresql status
output="$(sudo service postgresql status |grep online)" 
if [ X"$output" = X"" ]; then
  echo "launching database"
  sudo service postgresql start
fi
rails s -b $IP -p $PORT