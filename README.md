# Credit Card Management System

This project is our case study for Data Engineering Training at Per Scholas. 
It contains a java application for managing Customers details and Transaction details. 
And Hadoop Ecosystem queries, scripts and jobs to visualize, process and analyze credit card data. 

## Getting Started

To get this project up and running on your local machine, you will need to install:

1.	[Eclipse Java EE IDE (Oxygen) with java 1.8](http://www.eclipse.org/downloads/packages/eclipse-ide-java-ee-developers/oxygen3a),                            
2.	Install a Linux virtual machine [(CentOS)](https://www.centos.org/download/) or other linux distribution
3.	Hadoop Ecosystem with Sqoop, Hive, Oozie, and Pig [(Hortonworks sandbox)](https://hortonworks.com/products/sandbox/?utm_source=google&utm_medium=cpc&utm_campaign=hw_sandbox&gclid=Cj0KCQjw37fZBRD3ARIsAJihSr0gGnpqPHK97e-aPT_xUj5OWtequ2jQ-lArPV5Vy3AlTXKJnW2aG38aAvy_EALw_wcB).
4.	Install [Mysql Workbench](https://dev.mysql.com/downloads/workbench/8.0.html) on your virtual machine

### Prerequisites

We assume that 
* Eclipse IDE is up and running in your local machine
* HortonWorks Sandbox with Hadoop Ecosystem included (Sqoop, Hive, Oozie, and Pig) is up and running in your local machine
* Mysql Workbench is up and running in your local machine 

### Configuring Java Application

1.	Database parameters                                                                          	

Mysql driver is provided in the java project zip file. It's located under jar directory. 
If you need to use other database than Mysql, so you need to provide the driver and setup the project build path with that driver.
	
The properties file `db.properties` located in the project classpth (under `src` directory) 
content the parameters of your database. Each property must be in form `DatabaseReference.paramName=paramValue'. 

To setup your database, you need to define the properties: 
* DatabaseReference.driver content the driver class of your database
* DatabaseReference.url content l'URL of your database
* DatabaseReference.user content the user name or login of your database
* DatabaseReference.password copntent the password of the giving user
By default, the properties file content the parameters of the provided mysql database.

```
MY_CDW_SAPP.driver=com.mysql.jdbc.Driver
MY_CDW_SAPP.url=jdbc:mysql://localhost:3306/CDW_SAPP?useSSL=false
MY_CDW_SAPP.user=root
MY_CDW_SAPP.password=password
```
In case of more than one database parameters in your properties file, the application will give you an option to choose the 
database you want to connect to.

2.	Setup the java zip file in Eclipse

To Import the java zip file 
* `projectjavacs.zip` by choosing `File->Import..-> Projects from folder or archive`
* Click on `Next>`
* For the `Import source:` Click on `Archive...` button an select `projectjavacs.zip`
* Check the option `projectjavacszip_expanded\ProjectCSJava`
* Click on `Finish` to open the project `ProjectCSJava`
* The Main program is in the package `com.cdw.runner` named `MenuCDW.java`

3.	Java project package 
The project content seven package.
* Package `com.cdw.dao` content the data access objects.
  `ConnectionDAO.java`: Abstract class ConnectionDAO define the protocol to establish and close the connection to the database. 
  `DBProperties.java`: Get the database parameters from DBProperties. Manage the properties file in order to get the database parameters. 
  `CustomerDAO.java`: Manage data request at the data access layer for customer details module.
  `TransactionDAO.java`: Manage data request at the data access layer for transaction details module.

* Package `com.cdw.model` content the data model class
  `Ttransaction.java`: Define the transaction model class for the transaction details module
  `Customer.java`: Define the customer model class for the customer details module

* Package `com.cdw.blo` content the business logic objects or service layer. It's between presentation layer and data access layer. 
  `CustomerBLO.java`: Get the data request from the presentation object to the data access object for customer details module.
  `TransactionBLO.java`: Get the data request from the presentation object to the data access object for transaction details module.
* Package `com.cdw.exceptions` content the exception class used to manage the application exception
  `DBConfigException.java`: Implement RuntimeException. This class is used to manage the application exception.

* Package `com.cdw.constants` content the application constant classes
  `Queries.java`: Content SQL queries 
  `ViewData.java`: Content screen display related constants

* Package `com.cdw.controller` content presentation classes
 `SimpleMenu.java`: Content data and methods to manage the main menu
 `InOutController.java`: Content methods to display data on the console screen 

* Package `com.cdw.runner` content the main program
 `MenuCDW.java`: Main class of the application

4.	 Java documentation the this application is stored under `doc` folder.


### Setup Mysql database

1.	Unzip db.zip file.
2.	Open Mysql Workbench and execute the below scripts to create the database
```
CDW_SAPP_routines.sql
CDW_SAPP_CDW_SAPP_CREDITCARD.sql
CDW_SAPP_CDW_SAPP_BRANCH.sql
CDW_SAPP_CDW_SAPP_CUSTOMER.sql
```
 
### Hosts file
Edit your `hosts` file to map the hostname `sandbox.hortonworks.com` to you computer IP Address.

### Install WinSCP on your computer 

Download and install [WinSCP](https://winscp.net/eng/download.php) in your computer. This tool will allow you to copy files from your computer to the virtual machine.

### Vitual machine local system

1.	Create a new directories `oozie_jobs` and `sqooop_scripts` under  `/home/maria_dev`
```
mkdir /home/maria_dev/oozie_jobs
mkdir /home/maria_dev/sqoop_scripts
```
2.	Copy files to your virtual machine in the folder `/home/maria_dev/oozie_jobs`

```
jobs1.properties
jobs_coord.properties
jobs_coord_opt.properties
```
3.	Copy files to your virtual machine in the folder `/home/maria_dev/sqoop_scripts`

```
sqoop_jobs_opt_metastore.sh
sqoop_jobs_metaconnect.sh
```

4.	Make sqoop jobs executable

* Open a terminal and start sqoop metastore. Keep the sqoop metastore running.
```
sqoop metastore
```

* Open an other terminal and execute the following command to make all sqoop jobs available for execution

```
cd /home/maria_dev/ sqoop_scripts
chmod +x sqoop_jobs_opt_metastore.sh
chmod +x sqoop_jobs_metaconnect.sh
./sqoop_jobs_metaconnect.sh
./sqoop_jobs_opt_metastore.sh
```

### Hadoop/hdfs/dataware housing

1.	Create the following directories in hdfs:
```
hdfs dfs -mkdir /user/CDW_SAPP
hdfs dfs -mkdir /user/CDW_SAPP/Hive_Scripts
hdfs dfs -mkdir /user/CDW_SAPP/Oozie_Jobs
hdfs dfs -mkdir /user/CDW_SAPP/Pig_Scripts
hdfs dfs -mkdir /user/Credit_Card_System
```
2.	Upload the following hive scripts in `/user/CDW_SAPP/Hive_Scripts/` directory using Hortonworks Sandbox.

```
CDW_SAPP_D_BRANCH_DATA.HIVE
CDW_SAPP_D_CUSTOMER_DATA.HIVE
CDW_SAPP_D_TIME_DATA.HIVE
CDW_SAPP_F_CREDIT_CARD_DATA.HIVE
CDW_SAPP_D_BRANCH_OPT.HIVE
CDW_SAPP_D_CUSTOMER_OPT.HIVE
CDW_SAPP_D_TIME_OPT.HIVE
CDW_SAPP_F_CREDIT_CARD_OPT.HIVE
```
3.	Upload the following oozie workflow files in `/user/CDW_SAPP/Oozie_Jobs/` directory using Hortonworks Sandbox.

```
coordinator.xml
workflow.xml
workflow1.xml
coordinatoropt.xml
workflowopt.xml
```
Oozie workflow.xml example:

```
<?xml version="1.0" encoding="UTF-8"?>
<!-- This is a comment -->
<workflow-app xmlns="uri:oozie:workflow:0.4" name="first_Workflow">
  <start to="branch_allData"/>
 
 <action name="branch_allData">
  <sqoop xmlns="uri:oozie:sqoop-action:0.4">
    <job-tracker>${jobTracker}</job-tracker>
    <name-node>${nameNode}</name-node>
    <!--Delete CDW_SAPP_BRANCH, CDW_SAPP_CUSTOMER, CDW_SAPP_CREDITCARD, CDW_SAPP_TIME directories before running the sqoop job, this directry will be created again during the execution of the sqoop job --> 
    <prepare>
      <delete path="${sqoopData}/CDW_SAPP_BRANCH"/>
      <delete path="${sqoopData}/CDW_SAPP_CUSTOMER"/>
      <delete path="${sqoopData}/CDW_SAPP_CREDITCARD"/>
      <delete path="${sqoopData}/CDW_SAPP_TIME"/>
     </prepare>
         <configuration>
      <property>
         <name>mapred.job.queue.name</name>
         <value>${queueName}</value>
      </property>
    </configuration>
    <!-- Get data from mysql using sqoop job and store data in /user/Credit_Card_System/CDW_SAPP_BRANCH directory  -->
    <command>${sqoop_job} branch_allData </command>
    
  </sqoop>
  <ok to="customer_allData" />
  <error to="kill_job" />
 </action>

   <action name="customer_allData">
    <sqoop xmlns="uri:oozie:sqoop-action:0.4">
      <job-tracker>${jobTracker}</job-tracker>
      <name-node>${nameNode}</name-node>
      <configuration>
        <property>
           <name>mapred.job.queue.name</name>
           <value>${queueName}</value>
        </property>
      </configuration>
      <!-- Get data from mysql using sqoop job and store data in 
          /user/Credit_Card_System/CDW_SAPP_CUSTOMER directory -->
      <command>${sqoop_job} customer_allData</command>
    </sqoop>
    <ok to="creditcard_allData" />
    <error to="kill_job" />
   </action>

   <action name="creditcard_allData">
    <sqoop xmlns="uri:oozie:sqoop-action:0.4">
      <job-tracker>${jobTracker}</job-tracker>
      <name-node>${nameNode}</name-node>
      <configuration>
        <property>
           <name>mapred.job.queue.name</name>
           <value>${queueName}</value>
        </property>
      </configuration>
      <!-- Get data from mysql using sqoop job and store data in 
          /user/Credit_Card_System/CDW_SAPP_CREDITCARD/  directory -->
      <command>${sqoop_job} creditcard_allData</command>
    </sqoop>
    <ok to="timetable_allData" />
    <error to="kill_job" />
   </action>
  
   <action name="timetable_allData">
    <sqoop xmlns="uri:oozie:sqoop-action:0.4">
      <job-tracker>${jobTracker}</job-tracker>
      <name-node>${nameNode}</name-node>
      <configuration>
        <property>
           <name>mapred.job.queue.name</name>
           <value>${queueName}</value>
        </property>
      </configuration>
      <!-- Get data from mysql using sqoop job and store data in 
          /user/Credit_Card_System/CDW_SAPP_TIME/  directory -->
      <command>${sqoop_job} timetable_allData</command>
    </sqoop>
    <ok to="CDW_SAPP_D_BRANCH_DATA" />
    <error to="kill_job" />
   </action>


    <!-- Create an external table CDW_SAPP_D_BRANCH_EXT in hive
 		Create an internal table CDW_SAPP_D_BRANCH in hive and load data using 
        the external table CDW_SAPP_D_BRANCH_EXT  -->
    <action name="CDW_SAPP_D_BRANCH_DATA">
      <hive xmlns="uri:oozie:hive-action:0.4">
        <job-tracker>${jobTracker}</job-tracker>
        <name-node>${nameNode}</name-node>
        <script>${hiveScripts}/CDW_SAPP_D_BRANCH_DATA.HIVE</script>
      </hive>
      <ok to="CDW_SAPP_D_CUSTOMER_DATA" />
      <error to="kill_job" />
    </action>


    <!-- Create an external table CDW_SAPP_D_CUSTOMER_EXT in hive
 		Create an internal table CDW_SAPP_D_CUSTOMER in hive and load data using 
        the external table CDW_SAPP_D_CUSTOMER_EXT  -->
    <action name="CDW_SAPP_D_CUSTOMER_DATA">
      <hive xmlns="uri:oozie:hive-action:0.4">
        <job-tracker>${jobTracker}</job-tracker>
        <name-node>${nameNode}</name-node>
        <script>${hiveScripts}/CDW_SAPP_D_CUSTOMER_DATA.HIVE</script>
      </hive>
      <ok to="CDW_SAPP_F_CREDIT_CARD_DATA" />
      <error to="kill_job" />
    </action>


    <!-- Create an external table CDW_SAPP_F_CREDIT_CARD_EXT in hive
  		Create an internal table CDW_SAPP_F_CREDIT_CARD in hive and load data using 
        the external table CDW_SAPP_F_CREDIT_CARD_EXT  -->
    <action name="CDW_SAPP_F_CREDIT_CARD_DATA">
      <hive xmlns="uri:oozie:hive-action:0.4">
        <job-tracker>${jobTracker}</job-tracker>
        <name-node>${nameNode}</name-node>
        <script>${hiveScripts}/CDW_SAPP_F_CREDIT_CARD_DATA.HIVE</script>
      </hive>
      <ok to="CDW_SAPP_D_TIME_DATA" />
      <error to="kill_job" />
    </action>


    <!-- Create an external table CDW_SAPP_D_TIME_EXT in hive
		Create an internal table CDW_SAPP_D_TIME in hive and load data using 
        the external table CDW_SAPP_D_TIME_EXT -->
    <action name="CDW_SAPP_D_TIME_DATA">
      <hive xmlns="uri:oozie:hive-action:0.4">
        <job-tracker>${jobTracker}</job-tracker>
        <name-node>${nameNode}</name-node>
        <script>${hiveScripts}/CDW_SAPP_D_TIME_DATA.HIVE</script>
      </hive>
      <ok to="end" />
      <error to="kill_job" />
    </action>

 <kill name="kill_job">
  <message>Job failed</message>
 </kill>
 <end name="end" />
</workflow-app>
```


4.	Upload the following oozie configuration file for sqoop job in `/user/oozie/share/lib/lib_20161025075203/sqoop/` directory using Hortonworks Sandbox.

```
/user/oozie/share/lib/lib_20161025075203/sqoop/java-json.jar
```

5.	Upload the following pig script file in `/user/CDW_SAPP/Pig_Scripts/` directory using Hortonworks Sandbox.
```
pig_scripts_cdw.pig
```


### Sqoop scripts

To handle the data transfert from `CDW_SAPP` Mysql database to hadoop hdfs, we will create a sqoop job. 
So, for each table to transfert, we will create two type of data transfert.
- The first one will transfert all data content in the table to hadoop (_allData);
- The second one will transfert only the new or modified data from the concerned table to hadoop hdfs (_newData).
1.	CDW_SAPP_BRANCH All Data transfer example 

```
sqoop job --meta-connect jdbc:hsqldb:hsql://sandbox.hortonworks.com:16000/sqoop --create branch_allData -- import 
--connect jdbc:mysql://localhost/CDW_SAPP --driver com.mysql.jdbc.Driver 
--query "SELECT BRANCH_CODE, BRANCH_NAME, BRANCH_STREET, BRANCH_CITY, BRANCH_STATE, CASE WHEN BRANCH_ZIP is null
 then 999999 ELSE BRANCH_ZIP END AS BRANCH_ZIP, CONCAT('(',RIGHT(BRANCH_PHONE,3),')', MID(BRANCH_PHONE,4,3),'-', 
LEFT(BRANCH_PHONE,4)) AS BRANCH_PHONE, LAST_UPDATED FROM CDW_SAPP_BRANCH WHERE \$CONDITIONS" -m 1 
--delete-target-dir --target-dir /user/Credit_Card_System/CDW_SAPP_BRANCH/ --fields-terminated-by ','
```

2.	CDW_SAPP_CUSTOMER New Data transfer example  

```
sqoop job --meta-connect jdbc:hsqldb:hsql://sandbox.hortonworks.com:16000/sqoop --create customer_newData -- import 
--connect jdbc:mysql://localhost/CDW_SAPP --driver com.mysql.jdbc.Driver 
--query "SELECT CAST(SSN AS UNSIGNED INTEGER) AS SSN, CONCAT(UPPER(LEFT(FIRST_NAME,1)), LOWER(SUBSTRING(FIRST_NAME,2)))
 AS FIRST_NAME, LOWER(MIDDLE_NAME) AS MIDDLE_NAME, CONCAT(UPPER(LEFT(LAST_NAME,1)), LOWER(SUBSTRING(LAST_NAME,2))) 
AS LAST_NAME, CREDIT_CARD_NO, CONCAT(APT_NO,',', STREET_NAME) AS STREET_NAME_APT_NO,
CUST_CITY, CUST_STATE, CUST_COUNTRY, CAST(CUST_ZIP AS UNSIGNED INTEGER) AS CUST_ZIP, CONCAT(RIGHT(CUST_PHONE,3),'-', 
MID(CUST_PHONE,4,4)) AS CUST_PHONE,CUST_EMAIL, LAST_UPDATED FROM CDW_SAPP_CUSTOMER WHERE \$CONDITIONS" -m 1 
--incremental lastmodified --target-dir /user/Credit_Card_System/CDW_SAPP_CUSTOMER/ 
--check-column LAST_UPDATED --last-value 2018-06-04 --merge-key SSN,CREDIT_CARD_NO --fields-terminated-by '\t'
```

### Hive partition

All data imported by sqoop in Hadoop hdfs will be handle by Hive using dynamic partition. For each table to transfer, 
we will create one hive external table to reference each data directory, and one dynamic partitioned internal table to
transfer that data to Hive warehouse.  

1.	CDW_SAPP_D_TIME external table

```
CREATE DATABASE IF NOT EXISTS CASE_STUDY;
USE CASE_STUDY;
CREATE EXTERNAL TABLE IF NOT EXISTS CASE_STUDY.CDW_SAPP_D_TIME_EXT 
(TIMEID  String, DAY int, MONTH Int, QUARTER String, YEAR Int, TRANSACTION_ID INT) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','  
location '/user/Credit_Card_System/CDW_SAPP_TIME';
```

2.	CDW_SAPP_D_TIME dynamic partitioned table

We partitioned ` CDW_SAPP_D_TIME` on `QUARTER` and `YEAR`
```
SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;
DROP TABLE IF EXISTS CASE_STUDY.CDW_SAPP_D_TIME;
CREATE TABLE IF NOT EXISTS CASE_STUDY.CDW_SAPP_D_TIME
(TIMEID  String, DAY int, MONTH Int, TRANSACTION_ID INT)
PARTITIONED BY (QUARTER String, YEAR Int) STORED AS ORC;

INSERT OVERWRITE TABLE  CASE_STUDY.CDW_SAPP_D_TIME PARTITION (QUARTER, YEAR)
SELECT TIMEID, DAY, MONTH , TRANSACTION_ID, QUARTER, YEAR
FROM CASE_STUDY.CDW_SAPP_D_TIME_EXT;
```

### Oozie (Sqoop and Hive)

1.	Execute the following command to run oozie workflow
```
oozie job -oozie http://sandbox.hortonworks.com:11000/oozie -config /home/maria_dev/oozie_jobs/job1.properties
```

2.	Execute the following command to run oozie coordinator
```
oozie job -oozie http://sandbox.hortonworks.com:11000/oozie 
 -config /home/maria_dev/oozie_jobs/job_coord.properties
```

3.	Execute the following command to run oozie coordinator optimization
```
oozie job -oozie http://sandbox.hortonworks.com:11000/oozie 
 -config /home/maria_dev/oozie_jobs/job_coord_opt.properties
```

