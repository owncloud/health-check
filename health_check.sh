#!/bin/bash
# Create folder for all information collected
mkdir -p  ownCloud_Health_Check
dir="ownCloud_Health_Check"

echo "Please enter your company name, followed by [ENTER]."
echo "(only alphanumeric characters and underscore):"
read customer
customer=$(echo "$customer" | tr " " "_")

echo "Please enter the path of the ownCloud Installation"
read ocpath
ocpath=$(echo "$ocpath")
echo "Your ownCloud installation path is: " $ocpath

echo "Please enter the name of your Webserver User"
read htuser
htuser=$(echo "$htuser")
echo "Your webserver user is " $htuser

echo "Please enter the name of your Webserver Group"
read htgroup
htgroup=$(echo "$htgroup")
echo "your webserver group is " $htgroup

# create date string
today=$(date +%Y_%m_%d)
# create filename for output file
outfile="health_check_${customer}_$today.md"
# create output file
touch ownCloud_Health_Check$outfile

# create filename for output file
dbconfig_outfile=$dir"dbconfig_${customer}_$today.md"
# create output file
touch $dbconfig_outfile

# OS detection
if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi


# write title
printf "# Health Check\n\n" > $outfile
printf "for $customer  \n" >> $outfile
printf "created on $today\n" >> $outfile
printf "\n" >> $outfile

# get FQDN
printf "## Hostname:\n" >> $outfile
printf '```\n' >> $outfile
hostname -f >> $outfile
printf '```\n' >> $outfile
printf "\n" >> $outfile

# write OS
printf "## OS:\n" >> $outfile
printf '```\n' >> $outfile
printf "$OS " >> $outfile
printf "$VER\n" >> $outfile
printf '```\n' >> $outfile
printf "\n" >> $outfile

# number of CPUs
printf "## Number of CPUs:\n" >> $outfile
printf '```\n' >> $outfile
lscpu | grep '^CPU(s):' | rev | cut -b 1-2 | rev >> $outfile
printf '```\n' >> $outfile

# RAM
printf "## RAM\n" >> $outfile
printf '```\n' >> $outfile
free -m >> $outfile
printf '```\n' >> $outfile
printf "\n" >> $outfile

# Hard Disk information
printf "## HDD\n" >> $outfile
printf "output of df -h:  \n" >> $outfile
printf '```\n' >> $outfile
df -h >> $outfile
printf '```\n' >> $outfile
printf "\n" >> $outfile
printf "output of lsblk:  \n" >> $outfile
printf '```\n' >> $outfile
lsblk >> $outfile
printf '```\n' >> $outfile
printf "\n" >> $outfile
printf '```\n' >> $outfile
printf "\n" >> $outfile
cat /etc/fstab >> $outfile
printf '```\n' >> $outfile

# PHP
printf "## PHP\n" >> $outfile
printf "Version information:\n" >> $outfile
printf '```\n' >> $outfile
php -v >> $outfile
printf '```\n' >> $outfile
printf "PHP modules:\n" >> $outfile
printf '```\n' >> $outfile
php -m >> $outfile
printf '```\n' >> $outfile

#LDAP
printf "##Ldap Config\n" >> $outfile
printf '```\n' >> $outfile
sudo -u $htuser php occ ldap:show-config >> $outfile

# Swappiness
printf "## Swappiness:\n" >> $outfile
printf '```\n' >> $outfile
cat /proc/sys/vm/swappiness >> $outfile
printf '```\n' >> $outfile

# List of enabled services
printf "## List of enabled services:\n" >> $outfile
printf '```\n' >> $outfile
systemctl list-unit-files | grep enabled | sort >> $outfile
printf '```\n' >> $outfile

# List of Apache modules
printf "## List of Apache modules:\n" >> $outfile
printf '```\n' >> $outfile
apache2ctl -M >> $outfile
printf '```\n' >> $outfile

#Database
#/usr/sbin/mysqld mysqladmin variables >> $dbconfig_outfile


# if OS=RedHat getenforce
# apache2ctl -M
sudo -u $htuser php occ configreport:generate > config-report_$customer_$today.json
# SELECT count (*) FROM oc_filecache WHERE storage NOT IN (SELECT numeric_id FROM oc_storages);

wget http://mysqltuner.pl/ -O mysqltuner.pl
perl mysqltuner.pl >> $dbconfig_outfile
curl -sL https://raw.githubusercontent.com/richardforth/apache2buddy/master/apache2buddy.pl | perl >> apacheconfig.txt
