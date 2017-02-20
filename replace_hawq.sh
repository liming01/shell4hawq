#!/bin/bash

if [ "$#" != "1" ]; then
  echo "ERROR: Need pass param: hawq tar URL or hawq tar path.">&2;
  exit 1;
fi

# $1 is the hawq tar file
#if [ -d $1 ]; then
#  sudo mkdir -p

#fi
echo "param1: $1"

FILE_PATH="hawq-my-bin-dbg"
# unzip to destination directory
sudo mkdir -p /usr/local/$FILE_PATH
sudo tar -zxvf $1 -C /usr/local/$FILE_PATH

# copy config files from original hawq
sudo mkdir -p /usr/local/config_bak
sudo cp -f /usr/local/hawq/greenplum_path.sh /usr/local/config_bak/
sudo cp -rf /usr/local/hawq/etc /usr/local/config_bak/

# ln hawq with replaced hawq binary
sudo rm -f /usr/local/hawq
sudo ln -fs /usr/local/$FILE_PATH /usr/local/hawq

# copy back the backup config files
sudo cp -rf /usr/local/config_bak/* /usr/local/hawq

# version specific link
sudo ln -fs /usr/local/$FILE_PATH /usr/local/hawq_2_1_0_0
