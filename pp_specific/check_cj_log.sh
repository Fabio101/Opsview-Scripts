#!/bin/bash
#
# AUTHOR: Fabio Pinto <fabio@parallel.co.za>
#
# DESCRIPTION :
#		Checks if the cj.log file has changed since the last execution of the script. 
# 		To be used in conjunction with Nagios and run at hourly intervals
# 		Place in /usr/local/nagios/libexec/
#

cj_log_path="/var/log/placementpartner/cj.log"

while read line
do
	cj_log_old_size=$line

	cj_log_new_size_unformatted=`/usr/bin/du $cj_log_path` 
	cj_log_new_size=`/bin/echo $cj_log_new_size_unformatted | /bin/cut -d " " -f 1`
	
	echo $cj_log_new_size > /usr/local/nagios/libexec/check_cj_log.txt

	if [ $cj_log_old_size == $cj_log_new_size ]
		then
			echo "No Activity in cj.log file... investigate!"
			exit 2 #2 code means file sizes are the same, if run an hourly intervals this is 0 that means the cj.log file is not being updated
		else
			echo "Activity in cj.log file... All seems well."
			exit 0 #0 means the cj.log file is being updated, assumed normal functionality of cj services
	fi
done < /usr/local/nagios/libexec/check_cj_log.txt
