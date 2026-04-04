#!/usr/bin/env bash

echo "Installing Cron Jobs"
crontab -l > thejobs 
echo "*/3 * * * * bash /home/pi/dev/sys/jobs/get_dotdoing.com.sh" >> thejobs
crontab thejobs
rm thejobs
echo "All done"
