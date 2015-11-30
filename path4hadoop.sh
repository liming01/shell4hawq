export HADOOP_HOME=$HOME/workspace/install/hadoop-2.5.1
export HADOOP_ABBR=hadoop

export PATH=$HADOOP_HOME/sbin/:$HADOOP_HOME/bin:$PATH

alias start-dfs=$HADOOP_HOME/sbin/start-dfs.sh 
alias stop-dfs=$HADOOP_HOME/sbin/stop-dfs.sh 

echo -ne "[NOTICE]: Run: \"alias\" to fetch other commands without thinking path dependency! \n"
echo -ne "[NOTICE]: Run: \"hadoop_init.sh\", \"start-dfs\", \"stop-dfs\"\n"
