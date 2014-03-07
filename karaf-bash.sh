#!/usr/bin/env bash

echo "Starting the karaf container"
docker run -p 8181 -i -t sleeperor/karaf:3.0.0 /bin/bash
