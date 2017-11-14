#!/usr/bin/python
# Acts like rpm -qa and lists the names of all the installed packages.
# The main difference is that this will print out each package as an event in json format.
# the goal is to make this easy to ingest into splunk.
# Usage:
# python pkg_audit.py

import rpm
import json
import datetime

ts = rpm.TransactionSet()
mi = ts.dbMatch()
ts = '%s' % datetime.datetime.now()
output = []

for h in mi:
  pkg = {
    'ts': ts,
    'pkg_name': h['name'],
    'pkg_version': h['version'],
    'pkg_release': h['release'],
    'pkg_arch': h['arch'],
    'pkg_vendor': h['vendor'],
    'pkg_group': h['group']
    }
  output.append(json.dumps(pkg))

for line in output:
  print line
