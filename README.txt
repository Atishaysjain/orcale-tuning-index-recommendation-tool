# Enhancing Oracle Database Performance through Query Optimization 

## Database System Principles Final Project

### Student Names:
* Atishay Jain (016915626)
* Roshan Uvaraj (017410718)

### Individual Contributions:
1. Atishay (016915626):
- Index Recommender
- load generator
- Project Setup (Configuring and running the project on Google Cloud Platform)
- Query Cost Analysis
- Documentation

2. Roshan (017410718)
- UI Creation
- Schema Creation
- Documentation

### Setting up and Running the project
Step 1: Install and configure Apache http server
        sudo yum install httpd perl-CGI -y
        sudo systemctl enable --now httpd

Step 2: Clone the repo in the /var/www/html directory
        sudo git clone 

Step 3: Uncomment /etc/httpd/conf/httpd.conf file with following
        <Directory "/var/www/cgi-bin">
        AllowOverride None
        Options None
        Require all granted
        Options +ExecCGI
        AddHandler cgi-script .cgi .pl .py
        </Directory>

Step 4:  change the user to oracle and Group to oinstall in httpd.conf file

Step 5: Restart the httpd via command
        sudo systemctl restart httpd

Step 7: Change ORACLE_HOME/ORACLE_SID in shell files and add tns entry in  tnsnames.ora in $ORACLE_HOME/network/admin 

Step 8: Change the oracle dbsnmp password in shell files as appropriate

Step 9 : Access the url http://<ipaddress>/testindex.html

#### Setting up Schema

To install the workload follow below steps

To install Database schema and objects, connect to a database (or a pluggable database) using a privileged 
user and execute the setup script to create dbloadgen tablespace and user.


Then connect as dbloadgen user and execute the following scripts to create schema objects.

* dbloadgen_tables.sql
* buyer_seed_data.sql
* merchant_seed_data.sql
* proc_load_no_comp.sql


* ins.sql
* testbitmap.sql

### Setting up environment

first create the virtual python envirnoment

```
python3 -m venv db
source .db/bin/activate
pip install cx-Oracle
```

Run the following procedures:
```
@/dbloadgen/lib/test_proc.sql
@/dbloadgen/lib/htest_proc1_run.sql
```

### Flow:

1. submit the inputs in the URL which calls ora.sh in cgi-bin 
2. Based on drop down selection ora.sh will in turn call    

    * indrecom_new.sh (for index recommmendation)
    * fts.sh (full table scan queries)
    * gets.sh (for variation of time for sql_id)
        
3. indrecom_new.sh will call internally indrecom.sql/numcoldist.sql/numcoldist_bitmap.sql
4. indrecom.sql --> checks for full table scan queries in v$sqlplan
5. numcoldist.sql --> checks the numnber of distinct values for a column in a table
6. numcoldist_bitmap.sql --> check number of distinct as well as number of row for  a column in a table
7. fts.sh calls fts.sql internally which displays the sql_id and the sql text which are doing full table scan
8. gets.sh call gets.sql internally which gives the plan hash value / elapsed time if plan changed after creating index











