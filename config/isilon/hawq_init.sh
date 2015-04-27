#!/bin/bash

export GPHOME=$HOME/workspace/hawq1/greenplum-db-devel
export HAWQ_ABBR=hawq1
export HAWQ_DATA_DIR=~/temp/$HAWQ_ABBR
export MASTER_DATA_DIRECTORY=$HAWQ_DATA_DIR/data/master/gpseg-1

if [ -z "$GPHOME" ]; then
    echo "[FATAL]: -Please set $GPHOME in environment!"
    exit 1
fi

# Fetch absolute path to this script and current directory
pushd . > /dev/null
SCRIPT_PATH="${BASH_SOURCE[0]}";
  while([ -h "${SCRIPT_PATH}" ]) do 
    cd "`dirname "${SCRIPT_PATH}"`"
    SCRIPT_PATH="$(readlink "`basename "${SCRIPT_PATH}"`")"; 
  done
cd "`dirname "${SCRIPT_PATH}"`" > /dev/null
SCRIPT_PATH="`pwd`";
popd  > /dev/null

CURRENT_DIR=`pwd`

################
rm -rf $GPHOME/bin/my_host
echo -e "localhost\n" >> $GPHOME/bin/my_host

source $GPHOME/greenplum_path.sh

rm -rf $HAWQ_DATA_DIR/data/master $HAWQ_DATA_DIR/data/primary $HAWQ_DATA_DIR/data1/primary $HAWQ_DATA_DIR/data2/primary
mkdir -p $HAWQ_DATA_DIR/data/master $HAWQ_DATA_DIR/data/primary $HAWQ_DATA_DIR/data1/primary $HAWQ_DATA_DIR/data2/primary

rm -rf /tmp/.s.PGSQL.5432.lock

$GPHOME/bin/gpinitsystem -a -c $SCRIPT_PATH/gpinitsystem_config -h $GPHOME/bin/my_host

################
cd $CURRENT_DIR
