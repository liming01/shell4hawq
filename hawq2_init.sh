#!/bin/bash

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

################ workaround for dependency of new Mac OSX ################
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
cp -rf /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk/usr/lib/libz* /opt/releng/tools/third-party/ext/1.0/osx105_x86/lib/
cp -rf /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk/usr/lib/libz* ~/workspace/hawq2/greenplum-db-devel/lib/
cp -rf /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk/usr/lib/libz* ~/workspace/hawq2/ext/osx106_x86/lib/
fi
################
export GPHOME=$HOME/workspace/hawq2/greenplum-db-devel
export HAWQ_ABBR=hawq2
export HAWQ_DATA_DIR=~/temp/$HAWQ_ABBR

#replace '$HOME'&'$USER' in config file, and copy into destination.
CPY_SRC=$SCRIPT_PATH/config/$HAWQ_ABBR/
CPY_DES=$GPHOME/etc/
for i in `find $CPY_SRC \( -name "*.xml" -or -name "*conifg" \) -type f -exec basename {} \;` ; do 
	sed "s#\$HOME/#$HOME/#g; s#\$USER#$USER#g" "$CPY_SRC/$i" > "$CPY_DES/$i"; 
done 

source $GPHOME/greenplum_path.sh

rm -rf $HAWQ_DATA_DIR/
mkdir -p $HAWQ_DATA_DIR/master $HAWQ_DATA_DIR/segment $HAWQ_DATA_DIR/temp/master $HAWQ_DATA_DIR/temp/segment $HAWQ_DATA_DIR/temp/resourcemanager

rm -rf /tmp/.s.PGSQL.*.lock

$HADOOP_PREFIX/bin/hdfs dfs -rm -R /hawq2/

$GPHOME/bin/hawq init cluster -a

#$GPHOME/bin/hawq start cluster -a

echo -ne "\n[NOTICE]: Run \"alias\" to fetch other commands without thinking path dependency! \n"
################
cd $CURRENT_DIR
