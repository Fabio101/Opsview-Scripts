# opsview-nrpe-scripts
Some Scripts in use with NRPE and Opsview for customized monitoring purposes.

* All scripts should be placed in </usr/local/nagios/libexec/> on any server running the opsview-agent (NRPE) daemon 

## pp_specific
Checks specific to Parallel Software such a log file monitoring etc...

* Generally, log check scripts are run by Opsview on an hourly basis and within working hours.

## general
Checks downloaded that cater for extra monitoring functionality such as mysql slave replciation monitoring etc...
