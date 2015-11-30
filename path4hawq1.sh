export GPHOME=$HOME/workspace/hawq1/greenplum-db-devel
export HAWQ_ABBR=hawq1
export HAWQ_DATA_DIR=~/temp/$HAWQ_ABBR
export MASTER_DATA_DIRECTORY=$HAWQ_DATA_DIR/data/master/gpseg-1

source $GPHOME/greenplum_path.sh

export PATH=$GPHOME/bin:$PATH

alias mdd='cd $HAWQ_DATA_DIR/data/master'
alias sdd='cd $HAWQ_DATA_DIR/data/segment'

echo -ne "[NOTICE]: Run: \"alias\" to fetch other commands without thinking path dependency! \n"
echo -ne "[NOTICE]: Run: \"hawq_init.sh\", \"gpstart\", \"gpstop\"\n"
