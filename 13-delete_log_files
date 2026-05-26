#1/bin/bash
source_dir=("/home/ec2-user/app-logs")
files_to_delete=$(find $source_dir . -name "*.log" -mtime +14)
while IFS= read -r filepath
do
    rm-rf $filepath
done<<<"files_to_delete"