#!/bin/bash

generare_raport() {

user_home="/home/stud1019/tudorG/proiect_so/home/$1"

nr_fisiere=$(find "$user_home" -type f | wc -l)
nr_dir=$(find "$user_home" -type d | wc -l)
dim_total=$(du -sh "$user_home" | cut -f1)

echo "Report for: $1" > /home/stud1019/tudorG/proiect_so/home/$1/raport$1.txt
echo ".............................." >> /home/stud1019/tudorG/proiect_so/home/$1/raport$1.txt
echo "Number of files: $nr_fisiere" >> /home/stud1019/tudorG/proiect_so/home/$1/raport$1.txt
echo "Number of directories : $nr_dir" >> /home/stud1019/tudorG/proiect_so/home/$1/raport$1.txt
echo "Total disk space: $dim_total" >> /home/stud1019/tudorG/proiect_so/home/$1/raport$1.txt
echo ".............................." >> /home/stud1019/tudorG/proiect_so/home/$1/raport$1.txt
}

read -p "Username for report: " nume
user=$(cut -d ',' -f 1 /home/stud1019/tudorG/proiect_so/users.csv | grep -w "$nume")
if [ -n "$user" ]; then
    generare_raport "$nume" &
    echo "Generating..."
    sleep 3
    read -p "The report was created. Want to see the report? (y/n) " opt
    if [[ "$opt" == 'y' ]]; then
    cat /home/stud1019/tudorG/proiect_so/home/$nume/raport$nume.txt
    else
        exit 1
    fi
else
    echo "Invalid Username"
    exit 1;
fi
