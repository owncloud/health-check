# A collection of Questions and Scripts to verify ownCloud Environments

## Health Check Check-list
    
    - [ ] Evaluate if it is possible to get an Logging Tool for metrics: 
    
    - [ ] Use Case: Clients used, file types and sizes. 
    
    - [ ] Get Useragents from ownCloud.log how is ownCloud accessed. Are the clients up to date. (Parse Apache ownCloud.log. Is Oauth used?
    User Agent Names: mirall, Android, ownCloud-iOS
    
    `grep -EIho 'mirall|Android|ownCloud-iOS' *|sort|uniq -c`
    
    - [ ] Verify how Shibboleth is setup. Where is the Shibboleth Config. 
    
    
   - [ ] Backup and Disaster Recovery, How our endusers supported, what is the ownCloud Knowledge at the Customer. 
   
   - [ ] Staging: System 
   
   - [ ] Is the Systemadministrator capable of updating ownCloud himself. 
   
   - [ ] Fresh Version or upgraded from previous versions? 
        
## Application Servers    
    
    ### Apache
 - [ ] Where are the Apache config files. Can they be merged into owncloud.conf
    
    #### Which Apache /Version 
    
    
    -  [x] Modules (Already in Script)
    -  [ ] Maxworkers
    -  [ ] Memory


## PHP: 
Php Version.
PHP Modules
PHP Settings (Max Memory, Session Handling, Garbage Collection, Max execution Time, Opcache Settings- Cache Perfomance) 

Test via occ (cli) (config-report).
An test via Apache2 
Write a php-file

## Cache
Which Cache is used. APCU / Memcached, local, service. 

### REDIS:
  - [ ]  Version.
    
    Test if Redis is accessible and can be written to. 
    
    redis-cli ping

Database:
    Which Database Server, Version
    Connectivity:
        Read and Write
    Try Mysql Tuner. 
    Storage Engine: Database - Innodb - 
    What is the Filesystem for the Database.
    Which Tables are present, which should be present. (Might come in config-report)
    Slow Query Logs.
    
    
        
    ## Architecture
    Questionary upfront --> Draw.io Scheme. 
    
    ## Storage:
      ###  Main Storage:  
 Which: 
      ###   How: Mount Points, Buckets, NFS (Version, Network Connectivity, Storage IOPS, SMB, Version, ADFS.
     
     
     Secondary Storage:
         Which: 
      ###   How: Mount Points, Buckets, NFS (Version, Network Connectivity, Storage IOPS, SMB, Version, ADFS.
      

         
     ## 3rd Party applications:
         Only Office/Collabora, Elastic Search, Files Antivirus, Sharepoint, LDAP Home,     
    
    
## User Authentication
AD /LDAP 
CAS    
Shibboleth

- [ ] Check SSL config via SSLLabs

## ownCloud 
Version
Apps
Nutzerzahl
ownCloud.log (Tool to evaluate ownCloud.log (Which exeception happens how often)
Config.php

## Apps

### LDAP Configuration


### App configs


### Federation

### Verify Notifications
(emails).

    
# Standard Deployment -Max 500 Users.

## Apache
Define Apache Config locations  
Have all ownCloud apache relevant config in one file. 
## PHP 

Php Version.
PHP Modules
PHP Settings (Max Memory, Session Handling, Garbage Collection, Max execution Time, Opcache Settings- Cache Perfomance) 

