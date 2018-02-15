#!/bin/bash

echo "Please enter your company name, followed by [ENTER]."
echo "(only alphanumeric characters and underscore):"
read customer
customer=$(echo "$customer" | tr " " "_")

# create date string
today=$(date +%Y_%m_%d)
# create filename for output file
outfile="health_check_${customer}_$today.md"
# create output file
touch $outfile

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
printf "\n" >> $outfile

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

# Swappiness
printf "## Swappiness:\n" >> $outfile
printf '```\n' >> $outfile
cat /proc/sys/vm/swappiness >> $outfile
printf '```\n' >> $outfile

# if OS=RedHat getenforce
#sudo -u www-data /usr/bin/php /var/www/owncloud/occ config-report:generate > config-report_$today.json
