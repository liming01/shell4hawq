#!/bin/bash

# Create same uid & gid with your account on hawq master host
# Using commmand "id" to get uid/gid on hawq master hostchangeme
isi auth groups create --zone=system --provider=local --name=hadoop_mili --gid=20
isi auth users create mili --zone=system --provider=local --uid=501 --primary-group=hadoop_mili --home-directory=/ifs/home/mili --password=changeme --enabled=true
# if already exists, then using: "isi auth users view --uid 501" to look and delete user

mkdir -p /ifs/gpsql
chown -R mili:hadoop_mili /ifs/gpsql
chmod 777 /ifs/home/mili

