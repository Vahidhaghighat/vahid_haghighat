#!/bin/bash -x
cd /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs
HOST=172.16.118.50
USER=maintenance
PASSWORD=spec_cal
ftp -inv $HOST <<E0F
user $USER $PASSWORD
cd /log
cd /
mget errors.log
lcd
bye
E0F


#make newerrors.log
mv  /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/errors.log /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/newerrors.log
#cat  /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/newerrors.log  | mailx -s newerrors vahid.vh.991@gmail.com


# find daily errors and mail
diff -u /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/olderrors.log /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/newerrors.log |grep -E "^\+" > /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/dailyerrors.log
#cat /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/dailyerrors.log | mailx -s dailyerrors vahid.vh.991@gmail.com


#make all errors file 

cat /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/oldallerrors.log /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/dailyerrors.log >> /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/newallerrors.log


mv /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/newallerrors.log /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/oldallerrors.log
echo "number of sampels" >>  /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/dailyerrors.log
grep -c -i  "getput2 is finished" /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/dailyerrors.log >> /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/dailyerrors.log
grep "getput2 is finished" /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/dailyerrors.log >> /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/sample_changes/getputs_$(date +%Y%m%d%T).log 

mv /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/dailyerrors.log /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/daily_logs/daily_$(date +%Y%m%d%T).log

cp /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/newerrors.log /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/Raw_logs/Raw_$(date +%Y%m%d).log
mv /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/newerrors.log /mxn/home/biomax-user/Desktop/biomax/ISARA/ISARA_logs/olderrors.log


