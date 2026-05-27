#!/bin/bash
user_id=$(id -u)
r="\e[31m"
g="\e[32m"
y="\e[33m"
n="\e[0m"
if [ $user_id -ne 0 ]
then 
    echo -e "$r Please run with sudo access $n"
else
    echo -e "$g You are in root access $n"
fi
log_folder= "/var/log/shell-logs"
log_file=$(echo $0 | cut -d "." -f1)
script_file="$log_folder/$log_file.log"
source_dir="/home/ec2-user/app-logs"
mkdir -p $log_folder
echo -e "$g Script execution started at $(date) $n"
validate() {
    if [ $1 -eq 0 ]
    then
    echo -e "$g $2 is successful $n"
    else
    echo -e "$r $2 is failed $n"
    exit 1
    fi
}
files_to_delete=$(find "$source_dir" -name "*.log" -mtime +14)
if [ -n $files_to_delete ]
then
    while IFS= read -r filepath
    do
        rm -rf $filepath
        validate $? "files deletion"
        done<<<"$files_to_delete"
else
    echo -e "$y No log files to delete $n"
fi
echo -e "$g Script execution completed"