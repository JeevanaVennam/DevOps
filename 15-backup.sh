#!/bin/bash
user_id=$(id -u)
source_dir=$1
desti_dir=$2
days=$(3: -14)
lof_folder="/var/logs/backup_logs"
script_name=$(echo $0 | cut -d "." -f1)
log_file="$log_folder/$script_name.log"
r="\e[31m"
g="\e[32m"
y="\e[33m"
n="\e[0m"
checkroot(){
    if [ user_id -ne 0]
    then
        echo -e "$r Please run with sudo access $n"
        exit 1
    else
        echo -e "$g You are in root access $n"
    fi
}
usage(){
    echo -e "$r Usage:: $n 15.backup.sh <source_directory> <destination_directory> <days(optional)>"
    exit 1
}
checkroot

if [ $# -lt 2]
then
    usage
fi

if [! -d source_dir]
then
    echo -e "$r Source directory does not exist $n"
    exit 1
fi
if [! -d desti_dir]
then
    echo -e "$r Destination directory does not exist $n"
    exit 1
fi
file= find $source_dir -name "*.log" -mtime +$days
if [! -z "$files"]
 then
 echo "Files to zip : $files"
    timestamp=$(date +%F-%H-%M-%S)
    zip_file="$desti_dir/app-logs-$timestamp.zip"
    find $source_dir -name "*.log" -mtime +$days | zip -@ $zip_file
    if [-f $zip_file]
    then
        echo -e "$g successfully created backup file $n"
        while IFS= read -r filepath
        do
            echo "deleting file $filepath"
            rm -rf $filepath
        done<<<"$file"
        echo -e "$g Files older than $days from $sorce_dir are removed $n"
    
    else
        echo -e "$r Failed to creates zip file $n"
        exit 1
    fi
else
    echo -e "$y No log files found in $source_dir older than $days..$y skipping $n"
fi
echo "script execution completed"