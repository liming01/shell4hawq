#!/bin/bash

killall -9 postgres
rm -rf /tmp/.s.PGSQL.*.lock

hdfs dfsadmin -safemode leave
hadoop fs -rm -R hdfs://localhost:8020/hawq_default
rm -rf /Users/gpadmin/hawq-data-directory/masterdd
rm -rf /Users/gpadmin/hawq-data-directory/segmentdd
