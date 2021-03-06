#!/bin/bash
#
# AUTHOR: Fabio Pinto <fabio@parallel.co.za>
#
# DESCRIPTION :
#		Checks if the go_pnet_docs.log file has changed since the last execution of the script. 
# 		To be used in conjunction with Nagios and run at hourly intervals
# 		Place in /usr/local/nagios/libexec/
#

pnet_log_path="/var/log/placementpartner/go_pnet_docs.log"

while read line
do
	pnet_log_old_size=$line

	pnet_log_new_size_unformatted=`/usr/bin/du $pnet_log_path` 
	pnet_log_new_size=`/bin/echo $pnet_log_new_size_unformatted | /bin/cut -d " " -f 1`
	
	echo $pnet_log_new_size > /usr/local/nagios/libexec/check_pnet_docs_log.txt

	if [ $pnet_log_old_size == $pnet_log_new_size ]
		then
			echo "No Activity in go_pnet_docs.log file... investigate!"
			exit 2 #2 code means file sizes are the same, if run an hourly intervals this is 0 that means the go_pnet_docs.log file is not being updated
		else
			echo "Activity in go_pnet_docs.log file... All seems well."
			exit 0 #0 means the go_pnet_docs.log file is being updated, assumed normal functionality of pnet services
	fi
done < /usr/local/nagios/libexec/check_pnet_docs_log.txt
