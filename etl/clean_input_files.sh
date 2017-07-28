#!/bin/bash

find ./etl/input_files/ -name *.csv| xargs sed -i "s/^M//g"
