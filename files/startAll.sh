#!/bin/bash

instances="REPLACE_THIS"


for instance in $instances
do
  export SPLUNK_HOME=/opt/$instance
  sudo -s su - splunk -c "$SPLUNK_HOME/bin/splunk start --answer-yes --accept-license"
done
