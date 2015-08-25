#!/bin/bash

if [ -z "$HAWQ_ABBR" ]; then
    echo "[FATAL]: -Please firstly run: \". path4hawq1.sh\" or \". path4hawq2.sh\"!"
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

################ workaround for dependency of new Mac OSX ################
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
cp -rf /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk/usr/lib/libz* /opt/releng/tools/third-party/ext/1.0/osx105_x86/lib/
cp -rf /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk/usr/lib/libz* ~/workspace/hawq1/greenplum-db-devel/lib/
cp -rf /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk/usr/lib/libz* ~/workspace/hawq1/ext/osx106_x86/lib/
fi
################
rm -rf $GPHOME/bin/my_host
echo -e "localhost\n" >> $GPHOME/bin/my_host

#replace '$HOME'&'$USER' in config file, and copy into destination.
CPY_SRC=$SCRIPT_PATH/config/$HAWQ_ABBR/
CPY_DES=$GPHOME/etc/
for i in `find $CPY_SRC \( -name "*.xml" -or -name "*conifg" \) -type f -exec basename {} \;` ; do 
	sed "s#\$HOME/#$HOME/#g; s#\$USER#$USER#g" "$CPY_SRC/$i" > "$CPY_DES/$i"; 
done 


source $GPHOME/greenplum_path.sh

rm -rf $HAWQ_DATA_DIR/data/master $HAWQ_DATA_DIR/data/primary $HAWQ_DATA_DIR/data1/primary $HAWQ_DATA_DIR/data2/primary
mkdir -p $HAWQ_DATA_DIR/data/master $HAWQ_DATA_DIR/data/primary $HAWQ_DATA_DIR/data1/primary $HAWQ_DATA_DIR/data2/primary
rm -rf $HOME/temp/hawq1/data1/tmp1 $HOME/temp/hawq1/data1/tmp2 $HOME/temp/hawq1/data2/tmp1 $HOME/temp/hawq1/data2/tmp2
mkdir -p $HOME/temp/hawq1/data1/tmp1 $HOME/temp/hawq1/data1/tmp2 $HOME/temp/hawq1/data2/tmp1 $HOME/temp/hawq1/data2/tmp2

rm -rf /tmp/.s.PGSQL.*.lock

$HADOOP_HOME/bin/hdfs dfsadmin -safemode leave
$HADOOP_HOME/bin/hdfs dfs -rm -R /$HAWQ_ABBR/

$GPHOME/bin/gpinitsystem -a -c $SCRIPT_PATH/config/$HAWQ_ABBR/gpinitsystem_config -h $GPHOME/bin/my_host

echo -ne "\n[NOTICE]: Run \"alias\" to fetch other commands without thinking path dependency! \n"
################
cd $CURRENT_DIR
