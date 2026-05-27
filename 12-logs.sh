#!/bin/bash
user_id=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
log_folder="/var/log/shellscript-log"
script_file=$(echo $0 | cut -d "." -f1)
log_file="$log_folder/$script_file.log"
packages=("mysql" "python" "nginx" "httpd")
mkdir -p $log_folder
echo"script started execution at $(date)" | tee -a $log_file

if [ $user_id -ne 0 ]
then
    echo -e "$R Error: Please run as root user $N" | tee -a $log_file
    exit 1
else
    echo "$G  You are in root access $N" | tee -a $log_file
fi
validate(){
    if [$1 -eq 0]
    then
        echo -e "$G $2 is installed $N" | tee -a $log_file
    else
        echo -e "$R $2 is failed to install $N" | tee -a $log_file
        exit 1
    fi
}
for package in ${packages[@]}
do
    dnf list installed $package &>> $log_file
    if [ $? -ne 0 ]
    then
        echo -e "$Y $package not installed, installing now.. $N" | tee -a $log_file

        dnf install $package -y &>> $log_file
        validate $? "$package"
    else
        echo -e "$G $package is already installed $N" | tee -a $log_file
    fi
done
echo -e "$G Script execution completed at $(date) $N" | tee -a $log_file
