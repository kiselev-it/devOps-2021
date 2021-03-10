#!/bin/bash
#sudo apt -y update
#sudo apt -y upgrade
#sudo apt install net-tools
#sudo apt install whois
#chmod +x task_1.sh
echo Press the enter key if you want to use default values:
echo - name process: firefox
echo - number of results: 5
echo - connection states: LISTENING
echo Write PID or name of another process
read pid_id
if [[ "$pid_id" == "" ]]; then
	pid_id="firefox"
fi

echo Write the number of results you want to see
read quantity
number='[0-9]+$'
if [[ "$quantity" == "" ]]; then
        quantity="5"
elif [[ "$quantity" != "$number" ]]; then
	echo incorrect values
	exit
fi

echo Press any key to see other connections states
read states
if [[ "$states" == "" ]]; then
        states="l"
else
	states=""
fi


sudo netstat -tunap$states | grep $pid_id > /dev/null
if [[ $? -eq 1 ]]; then
echo You entered an incorrect name_process/PID
exit
else 
sudo netstat -tunap$states | awk '/'$pid_id'/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort | tail -n$quantity | grep -oP '(\d+\.){3}\d+' | while read IP ; do whois $IP | awk -F':' '/^Organization/ {print $2}' ; done | sort | uniq -c
fi
