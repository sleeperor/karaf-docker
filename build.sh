#!/usr/bin/env bash

echo "building the Docker container for http://karaf.apache.org/"
docker build -t sleeperor/karaf:3.0.0 .

