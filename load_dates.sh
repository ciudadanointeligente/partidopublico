#!/bin/bash


array=(20170306 20170313 20170502 20170508 20170515 20170522 20170529 20170605 20170612 20170619 20170626 20170703 20170710 20170717 20170724 20170731 20170807)

echo "Array size: ${#array[*]}"

echo "Array items:"
for item in ${array[*]}
do
    echo "rake etl:start[$item] --trace"
    # rake etl:start[$item] --trace
done
