export HADOOP_HOME=$HOME/workspace/install/hadoop-2.4.1-gphd-3.2.0.0
export HADOOP_ABBR=gphd

export PATH=$HADOOP_HOME/sbin/:$HADOOP_HOME/bin:$PATH

alias start-dfs=$HADOOP_HOME/sbin/start-dfs.sh 
alias stop-dfs=$HADOOP_HOME/sbin/stop-dfs.sh 

echo -ne "[NOTICE]: Run: \"alias\" to fetch other commands without thinking path dependency! \n"
echo -ne "[NOTICE]: Run: \"hadoop_init.sh\", \"start-dfs\", \"stop-dfs\"\n"
