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

# Rename the hostname.
echo "Changing hostname..."
sed -i "s/HOSTNAME=localhost.localdomain/HOSTNAME=${host_name}.localdomain/g" /etc/sysconfig/network
hostname ${host_name}.localdomain
check_return $?

exit 0
