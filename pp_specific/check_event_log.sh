#!/bin/bash
#
# AUTHOR: Fabio Pinto <fabio@parallel.co.za>
#
# DESCRIPTION :
#		Checks if the event_processor.log file has changed since the last execution of the script. 
# 		To be used in conjunction with Nagios an run at hourly intervals
# 		Place in /usr/local/nagios/libexec/
#

event_log_path="/var/log/placementpartner/event_processor.log"

while read line
do
	event_log_old_size=$line

	event_log_new_size_unformatted=`/usr/bin/du $event_log_path` 
	event_log_new_size=`/bin/echo $event_log_new_size_unformatted | /bin/cut -d " " -f 1`
	
	echo $event_log_new_size > /usr/local/nagios/libexec/check_event_log.txt

	if [ $event_log_old_size == $event_log_new_size ]
		then
			echo "No Activity in event_processor.log file... investigate!"
			exit 2 #2 code means file sizes are the same, if run an hourly intervals this is 0 that means the event_processor.log file is not being updated
		else
			echo "Activity in event_processor.log file... All seems well."
			exit 0 #0 means the event_processor.log file is being updated, assumed normal functionality of the event processor
	fi
done < /usr/local/nagios/libexec/check_event_log.txt
