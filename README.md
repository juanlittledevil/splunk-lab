# Splunk

## Description:

Use this environment to quickly spin up a Splunk Lab.

## Configuration:

In order to conserve laptop resources we will run multiple instances of Splunk from a
single server. Here is the server breakdown.

1. `splunk` - stand-alone server running a single instance of Splunk.
2. `splunk_idxc` - server running all indexer instances with exception of the cluster-master.
3. `splunk_shc` - server running all the search instances with exception of the deployer.
4. `splunk_misc` - server running all management pieces (master node, license master, deployment server, deployer)
5. `splunk_lb` - server running an nginx proxy with a sticky LB configuration, used as a front-end to the shcluster.

**NOTE:** splunk-lb will also be configured as a splunk forwarder and can be used to test ingesting data.

### Host Details:

#### splunk

This server is a standalone instance of Splunk. There is nothing special about this. It runs with all
the default ports:

ip address: `192.168.3.61`

| name | path | guest ports | local port |
| --- | --- | --- | --- |
| splunk | /opt/splunk | splunkd:8089, web:8000, listen:9997 | [localhost:8101](http://localhost:8101) |


#### splunk_idxc

This node contains all the splunk indexers. Each instance runs from a separate folder, each having its own
set of used ports. See  table below for details.

ip address: `192.168.3.62`

| name | path | guest ports | local port |
| --- | --- | --- | --- |
| idx1 | /opt/idx1 | splunkd:8189, web:8100, listen:9197, replication:9100 | [localhost:8201](http://localhost:8201) |
| idx2 | /opt/idx2 | splunkd:8289, web:8200, listen:9297, replication:9200 | [localhost:8202](http://localhost:8202) |
| idx3 | /opt/idx3 | splunkd:8389, web:8300, listen:9397, replication:9300 | [localhost:8203](http://localhost:8203) |
| idx4 | /opt/idx4 | splunkd:8489, web:8400, listen:9497, replication:9400 | [localhost:8204](http://localhost:8204) |


#### splunk_shc

This vm is home for splunk web (search heads). Each instance runs from a separate folder, eaching having its
own set of ports. Note that search heads do not listen to incoming data. See table below:

ip address: `192.168.3.63`

| name | path | guest ports | local ports |
| --- | --- | --- | --- |
| sh1 | /opt/sh1 | splunkd:8189, web:8100, replication:9100 | [localhost:8301](http://localhost:8301) |
| sh2 | /opt/sh2 | splunkd:8289, web:8200, replication:9200 | [localhost:8302](http://localhost:8302) |
| sh3 | /opt/sh3 | splunkd:8389, web:8300, replication:9300 | [localhost:8303](http://localhost:8303) |


#### splunk_misc

This vm is home for the management pieces.

ip address: `192.168.3.64`

| name | path | guest ports | local ports |
| --- | --- | --- | --- |
| cluster master | /opt/cm | splunkd:8189, web:8100 | [localhost:8401](http://localhost:8401) |
| license master | /opt/lm | splunkd:8289, web:8200 | [localhost:8402](http://localhost:8402) |
| deployer | /opt/dep | splunkd:8389, web:8300 | [localhost:8403](http://localhost:8403) |
| deployment server | /opt/ds | splunkd:8489, web:8400 | [localhost:8404](http://localhost:8404) |
| monitoring console | /opt/mc | splunkd:8589, web:8500 | [localhost:8405](http://localhost:8405) |


#### splunk_lb

This node serves two functions, it is the way to access the web UI for the cluster, etc. It also
provides us with logs we can ingest into splunk.

ip address: `192.168.3.65`

| name | path | guest ports | local ports |
| --- | --- | --- | --- |
| nginx | /etc/nginx | httpd:8080 | [localhost:8080](http://localhost:8080) |
| splunk forwarder | /opt/splunk | splunkd:8089, 9997 | |


## Usage:

**NOTE:** only the standalone version has been configured right now.

To sping up everything in one go:

    vagrant up
    vagrant ssh <vm_name>

To sping up a single host:

    vagrant up splunk
    vagrant ssh splunk
