#!/bin/bash
user_id=$(id -u)
if [$user_id -ne 0]
then
    echo "Please run script as root"
else
    echo "you are in root access"

validate() {
    if [$1 -ne 0]
    then
    echo "$2 not installed"
    else
    echo "$2 is installed"
    fi
}
dnf list installed mysql
if [$? =ne 0]
then
    echo "installing mysql"
    dnf install mysql-server -y
    validate $? "mysql"
else 
echo "mysql is already installed"
fi
dnf list installed nginx
if [$? -ne 0]
then
    echo "nginx not installed"
    dnf install nginx -y
    validate $? "nginx"
else
    echo "nginx is already installed"
fi
