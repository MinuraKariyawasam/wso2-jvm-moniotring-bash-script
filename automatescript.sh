#!/bin/bash
cd tmp/
git https://github.com/MinuraKariyawasam/wso2-jvm-moniotring-bash-script.git && unzip main.zip && cd wso2-jvm-moniotring-bash-script-main/
chmod +x ./heap.sh && chmod +x ./metricpush.sh
crontab -l > crontab_new
echo "* * * * * /tmp/wso2-jvm-moniotring-bash-script-main/heap.sh" >> crontab_new
echo "* * * * * /tmp/wso2-jvm-moniotring-bash-script-main/metricpush.sh" >> crontab_new
crontab crontab_new
rm crontab_new