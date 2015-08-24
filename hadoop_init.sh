#!/bin/bash

if [ -z "$HADOOP_ABBR" ]; then
    echo "[FATAL]: -Please firstly run: \". path4hadoop.sh\" or \". path4gphd.sh\"!"
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
$HADOOP_HOME/sbin/stop-dfs.sh 

#replace '$HOME'&'$USER' in config file, and copy into destination.
CPY_SRC=$SCRIPT_PATH/config/$HADOOP_ABBR/
CPY_DES=$HADOOP_HOME/etc/hadoop/
for i in `find $CPY_SRC \( -name "*.xml" -or -name "*conifg" \) -type f -exec basename {} \;` ; do 
	echo "=== copy $CPY_SRC/$i to $CPY_DES/$i ===\n";
	sed "s#\$HOME/#$HOME/#g; s#\$USER#$USER#g" "$CPY_SRC/$i" > "$CPY_DES/$i"; 
done 

HADOOP_DATA=~/temp/$HADOOP_ABBR
rm -rf   $HADOOP_DATA
mkdir -p $HADOOP_DATA/name
mkdir -p $HADOOP_DATA/data

$HADOOP_HOME/bin/hdfs namenode -format
$HADOOP_HOME/sbin/start-dfs.sh 

echo -ne "\n[NOTICE]: Run \"alias\" to fetch other commands without thinking path dependency!\n"
################
cd $CURRENT_DIR
