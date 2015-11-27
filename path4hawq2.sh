export GPHOME=$HOME/workspace/hawq2/hawq-db-devel
export HAWQ_ABBR=hawq2
export HAWQ_DATA_DIR=~/temp/$HAWQ_ABBR
export MASTER_DATA_DIRECTORY=$HAWQ_DATA_DIR/data/master/gpseg-1

source $GPHOME/greenplum_path.sh

export PATH=$GPHOME/bin;$PATH

alias mdd='cd $HAWQ_DATA_DIR/master'
alias sdd='cd $HAWQ_DATA_DIR/segment'

echo -ne "[NOTICE]: Run: \"alias\" to fetch other commands without thinking path dependency! \n"
echo -ne "[NOTICE]: Run: \"hawq2_init.sh\", \"hawq start cluster -a\", \"hawq stop cluster -a\"\n"
