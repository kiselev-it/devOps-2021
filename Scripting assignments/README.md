# Task 1 - Scripting assignments
## Task 1.1 - Turn this one-liner into a nice script
### These points are done in the script: task_1.sh
* 1 point for parametrization: you might want to enter PID or name of another process as an argument
* 1 point for parametrization: you might want to see more results
* 1 point for parametrization: you might want to see other connection states
* 1 point for securing script execution and nice error messages
* 2 points for writing a README.md for what your script does
* 2 points for adding count of connections per organization to the final output

### These point are done in the script: task_1.2.sh
* 2 points for rewriting the functionality differently, say using `ss`, `sed`, built-ins like `"${VAR%%:*}"` (might be a separate script)

## Description of what my script does
First, the user is prompted to enter some parameters. If he does not want to do this, he simply presses enter and the default values are taken from the task. The correctness of entering some parameters is checked. 
Before starting the execution of the main part of the script, the PID/name of another process value is checked in the output of the netstat -tunapl command. If there is no PID/name of another process, then the script will no longer be executed.

Next, let's look at the script in parts:

Print network connections:
* -t (TCP)
* -u (UDP)
* -n (Show numerical addresses instead of trying to determine symbolic host, port or user names )
* -a (Show  both  listening  and non-listening sockets)
* -p (Show the PID and name of the program to which each socket belongs)
* -l (Show only listening sockets)
```
sudo netstat -tunap$states
```

Print out the 5th column value(Foreign Address) by word "firefox"(defoult)

```sh
| awk '/'$pid_id'/ {print $5}'
```
Сut out the port value
* -d (use DELIM instead of TAB for field delimiter)
* -f (select  only these fields)
```sh
| cut -d: -f1
```
Sort ascending numbers
```sh
 | sort
```
Omit repeated lines and prefix lines by the number of occurrences
```sh
 | uniq -c
```

Sort ascending numbers
```sh
 | sort
```
Output the last 5 (defoult) lines of files
```sh
 | tail -n$quantity
```
By regular expression we cut out only ip
* -o (returns not the whole string that matches the pattern, but only part of the string)
* -P (treats the pattern as a Perl regular expression)
```sh
 | grep -oP '(\d+\.){3}\d+'
```

For each ip the whois command is executed. Next, only the value of the line "Organization" is print.
* WHOIS is a query and response protocol that is widely used for querying databases that store the registered users or assignees of an Internet resource, such as a domain name, an IP address block or an autonomous system, but is also used for a wider range of other information. The protocol stores and delivers database content in a human-readable format.
* -F':' (field separator, used to split text into columns). 

```sh
  | while read IP ; do whois $IP | awk -F':' '/^Organization/ {print $2}' ; done 
```
Print the number of connections per organization to the final result
```sh
   | sort | uniq -c; fi
```

