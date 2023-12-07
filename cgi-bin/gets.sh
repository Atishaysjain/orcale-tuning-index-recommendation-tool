export ORACLE_HOME=/home/oracle/Downloads
export ORACLE_SID=orcl
export PATH=$ORACLE_HOME/bin:$PATH
export TNS_ADMIN=$ORACLE_HOME/network/admin
TN=$1
SQID=$2
sqlplus -s dbsnmp/oracle123@$TN  <<EOF
set verify off
set feedback off
@gets.sql $SQID
EOF 
