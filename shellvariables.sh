#!/bin/bash
echo "print all the variables passed to the script: $@"
echo "Number of variables: $#"
echo "Script name: $0"
echo "PID at the background: $!"
echo "PID $$"
echo "current directory: $(pwd)"
sleep 10 &
echo "user running the script: $USER"
