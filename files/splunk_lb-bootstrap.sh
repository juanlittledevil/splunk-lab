#!/bin/bash
# Template for bootstrapping.
# This is automatically placed in scenarioX/files/01-helper.sh
# The idea is that bootrapping will just execute any file called *-helper.sh
# living inside the files folder.

# Global Variables
# ================

# nfs mount back to your box.
base="/vagrant"

host_name=$1

# Splunk RPM get latest.
#splunk_rpm="${base}/files/rpm/splunk-6.5.1-f74036626f0c-linux-2.6-x86_64.rpm"
# Instal the newest file based on timestat. Best if you only put one file in there....
#splunk_rpm="$(ls -tr ${base}/files/rpm/splunk-*.rpm | tail -1)"
splunkforwarder_rpm="$(ls -tr ${base}/files/rpm/splunkforwarder-*.rpm | tail -1)"

splunk_home="/opt/splunkforwarder"

splunk_executable="${splunk_home}/bin/splunk"


# Functions
# =========

check_return() {
  return=$1
  if [ $return -eq 0 ]; then
    echo "[OK]"
  else
    echo "Whoops: something went wrong with that last step"
    exit 1
  fi
}

# Main
# ====

# Make me a user.
useradd -G wheel juan
password=$(openssl passwd -1 )
passwd -p '$6$yJE6yZ7.$4YxtXwiT4RO/05FPTCN9Z6Lkw8t27.0ZJK68JXURGvOrXvbCYFi0PKPptMEWNJPBjR2i7jljDt/VvAp3ueCWV0' juan

# disable SELENUX.
sed -i 's/=enforcing/=disabled/g' /etc/sysconfig/selinux

# Install NGINX
yum -y update
yum clean all

yum -y install epel-release
yum -y install nginx
yum -y install ${splunkforwarder_rpm}

# Configure nginx.
# ==================

# Move in all nginx configs into place.
pwd=$(pwd)
cd ${base}/files/$host_name
files=$(find etc -type f -print)
cd $pwd

for file in $files
do
  cp ${base}/files/$host_name/$file /$file
done

# Configure the universal forwarder
# =================================

# Move in all Splunk configs into place.
cd ${base}/files/$host_name
files=$(find . splunkforwarder -type f -print)
cd $pwd

for file in $files
do
  cp ${base}/files/$host_name/$file /opt/$file
done

# start the splunkforwarder for the first time. (run as root)
$splunk_executable start --answer-yet --accept-license
$splunk_executable enable boot-start

# inline mods.
#sed -i "s/^module = manage_bind/module = manage_dnsmasq/g" /etc/cobbler/modules.conf

# Enable services.
# ================
setsebool -P httpd_can_network_connect 1

service nginx start
service splunkforwarder start

exit 0
