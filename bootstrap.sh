#!/bin/bash
# Author: Juan Segovia
# Generic bootsrap that hides output of what is happening.
# NOTE: meant for centos65
# also, this will get executed post install so assume base_dir is /vagrant... see $base.

# Global Variables
# ================

# which vm am I spinning up?.
host_name=$1

# nfs mount back to your box.
base="/vagrant"

# anything other than "no" will cause the mount to be unmounted.
unmount_vagrant="no"

# text file containting a list of packages to install. Must match what yum excpects....
packages=$(grep -v '#' ${base}/files/${host_name}-packages.list)

# any script to be executed by this bootstrap script. can start with anything but must end with "-helper.sh"
# script will be executed in the order displayed by 'ls'.
# NOTE: This script will be ran on ALL of the vms in the scenario. For guest specific use the host_script option.
helper_scripts=$(ls ${base}/files/*-helper.sh)

# Host specific helper script.
host_script=${base}/files/${host_name}-bootstrap.sh

# log file location....
log_file=${base}/files/${host_name}-bootstrap.log

# verboseity
if [ $2 == "verbose" ]; then
  verbose='true'
fi

# Other varibables used....
lb="================================================================================="

# Functions
# =========

# Report usage to the screen
install_package() {
  package=$1
  echo "yum -y install ${package}" >> ${log_file} 2>&1
  yum -y install ${package} >> ${log_file} 2>&1
  check_return $?
}

run_helper_script() {
  echo "$*" >> ${log_file} 2>&1
  $* >> ${log_file} 2>&1
  check_return $?
}

check_return() {
  return=$1
  if [ $return -eq 0 ]; then
    echo "[OK]"
  else
    echo "Whoops: something went wrong with that last step! " >> ${log_file} 2>$1
    [ -z $verbose ] && echo "Whoops: something went wrong with that last step! "
    exit 1
  fi
}

# Main
# ====

echo "Initiating bootstrap steps..... " > ${log_file} 2>&1
echo "${lb}" >> ${log_file} 2>&1
[ -z $verbose ] && echo "Initiating bootstrap steps..... "
[ -z $verbose ] && echo "${lb}"
[ -z $verbose ] || tail -f ${log_file} &

# install additional packages as needed.
echo "Installing packages....." >> ${log_file} 2>&1
echo "${lb}" >> ${log_file} 2>&1
[ -z $verbose ] && echo "Installing packages....."
[ -z $verbose ] && echo "${lb}"
for package in ${packages}
do
  install_package ${package}
done

# run any helper scripts.
echo "Executing helper scripts......" >> ${log_file} 2>&1
echo "${lb}" >> ${log_file} 2>&1
[ -z $verbose ] && echo "Executing helper scripts......"
[ -z $verbose ] && echo "${lb}"
for script in ${helper_scripts}
do
  run_helper_script ${script} ${host_name}
done

# run host bootstrap scripts.
echo "Executing host bootstrap script......" >> ${log_file} 2>&1
echo "${lb}" >> ${log_file} 2>&1
[ -z $verbose ] && echo "Executing host bootstrap script......"
[ -z $verbose ] && echo "${lb}"
for script in ${host_script}
do
  run_helper_script ${script} ${host_name}
done

# Unmount the vagrant filesystem once done.
if [ ${unmount_vagrant} != 'no' ]; then
  echo "Un-mounting vagrant folder.... " >> ${log_file} 2>&1
  echo "${lb}" >> ${log_file} 2>&1
  [ -z $verbose ] && echo "Unmounting vagrant folder.... "
  [ -z $verbose ] && echo "${lb}"

  echo "sleep 5 && cd / && umount -f ${base}" >> ${log_file} 2>&1
  nohup sleep 5 && cd / && umount -f ${base} &
fi

# There is a bug when upgrading kernel mounts disappear after reboot.
# This is a workaround.

/etc/init.d/vboxadd setup

echo -e "If /vagrant won't mount try this:\n"
echo "sudo /etc/init.d/vboxadd setup"

exit 0
