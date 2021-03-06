    # Health Check
for (Customer)
created on (date)

============  
Diagram overview of environment? (use https://www.draw.io/)  
Local link to S3: 

Start Health check if possible with perl nikto.pl -h https://FDQN:443/ -o FDQN -F txt if publicly accessible from your local Computer.
https://github.com/sullo/nikto

## Web server
- [ ] Number of servers:

Specs (per server)  
- [ ] VM (what kind of) or bare metal:

Hostname:  
- [ ] (hostname -f)

OS:  
- [ ] (lsb_release -a)

CPU:  
- [ ] (cat /proc/cpuinfo > cpu.txt)

RAM:  
- [ ] (free -m > ram.txt)

HDD:  
- [ ] (df -h > diskfree.txt)

Partitions:  
- [ ] (lsblk > lsblk.txt)

/etc/fstab:

Swappiness:  
- [ ] (cat /proc/sys/vm/swappiness)

### Software

#### ownCloud

- [ ] config.php

- [ ] owncloud.log (visual inspection)

- [ ] Ownerships and Permissions
(as per https://doc.owncloud.com/server/10.0/admin_manual/installation/installation_wizard.html#post-installation-steps-label)

- [ ] config report
(sudo -u www-data php /var/www/owncloud/occ configreport:generate > config_report.txt)

- [ ] LDAP config:
(sudo -u www-data php /var/www/owncloud/occ ldap:show-config > ldap_config.txt)

- [ ] Apps List (shows all apps installed, enabled and disabled)

(sudo -u www-data php /var/www/owncloud/occ app:list > app_list.txt)

- [ ] Check code intergrity
(occ integrity:check-core --output=json_pretty -vvv > integrity_check_core.txt)

- [ ] Check Background Jobs (run as root)
(crontab -u APACHE_USER -l > crontab.txt)

#### Apache
Module
- [ ] (apache2ctl -M > apache-modules.txt)

Config:
- [ ] (in /etc/apache2/)

Logs (visual inspection):
- [ ] (in /var/log/apache2/)

Performance Optimization for Apache with Apache2Buddy
- [ ] as per https://github.com/richardforth/apache2buddy

#### PHP
Version:
- [ ] (php -v > php.txt)

Module:
- [ ] (php -m >> php.txt)

Konfig (Apache und cli) "php -i > php_info.txt"

#### APCu
- [ ]  php -i | grep -i apcu
- [ ]  create phpinfo.php and check ACPU status
```
<?php
phpinfo();
?>
```
Or Memcached

## REDIS
- [ ] check Redis functionality with:  
```
redis-cli monitor
```
- [ ] benchmark Redis with:  
```
redis-benchmark
```
- [ ] and check performance with:
```
redis-cli --stat
```
## Database

- [ ] Number of servers:

- [ ] Hostname:
(hostname -f)

- [ ] OS:
(lsb_release -a)

- [ ] What kind and which Version of Database: 

Version 
- [ ] mysql --version

Specs (per server)  
- [ ] VM (what kind of) or bare metal:  
CPU:  
- [ ] (cat /proc/cpuinfo > cpu.txt)

RAM:  
- [ ] (free -m > ram.txt)

HDD:  
- [ ] (df -h > diskfree.txt)

Partitions:  
- [ ] (lsblk > lsblk.txt)

- [ ] cp /etc/fstab .

Swappiness:  
- [ ] (cat /proc/sys/vm/swappiness)

Tuning:
- [ ] https://github.com/major/MySQLTuner-perl

## Redis

- if installed on Web or DB, note here and delete the rest

- [ ] Number of servers:

- [ ] Hostname:
(hostname -f)

- [ ] OS:
(lsb_release -a)

Specs (per server)  
- [ ] VM (what kind of) or bare metal:  
- [ ] CPU:  
(cat /proc/cpuinfo > cpu.txt)

- [ ] RAM:  
(free -m > ram.txt)

- [ ] HDD:  
(df -h > diskfree.txt)

- [ ] Partitions:  
(lsblk > lsblk.txt)

- [ ] cp /etc/fstab .

- [ ] Swappiness:  
(cat /proc/sys/vm/swappiness)

Redis Version 

- [ ] redis-server -v


## Diff from Tarball to Original

## SSL Check for all Servers

- [ ] Check for valid ssl configurations



