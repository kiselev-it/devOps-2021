#!/bin/bash
#chmod +x task_1.2.sh
ss -tunap | sed -n '/firefox/p' | while read c1 c2 c3 c4 c5 c6 c7; do echo $c6; done | sed 's/:.*//' | sort | uniq -c | sort |sed -e :a -e '$q;N;6,$D;ba' | sed 's/^[ ]*[0-9]\+[ ]*//' | while read IP ; do whois $IP | grep Organization | sed 's/Organization:[ ]*//' ; done
