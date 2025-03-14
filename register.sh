#!/bin/bash

iesire_bucla=false

while true; do
  read -p "Enter username: " username
  verificare_username=$(echo "$username" | tr '[:upper:]' '[:lower:]')
  user=$(cut -d ',' -f 1 /home/stud1019/tudorG/proiect_so/users.csv 2>/dev/null | grep -w "$verificare_username")
  if [ "$verificare_username" == "$user" ]; then
    echo "Username '$username' already exists."
  else
    break
  fi
done

while ! $iesire_bucla; do
  read -p "Enter email address: " email
  mail=$(cut -d ',' -f 2 /home/stud1019/tudorG/proiect_so/users.csv 2>/dev/null | grep -w "$email")
  if [[ "$mail" == "$email" ]]; then
    echo "This email was already used"
  elif ! [[ $email =~ ^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
      echo "Invalid email address."
  else
    iesire_bucla=true
  fi
done

while true; do
  read -sp "Password: " password
  echo
  if [[ ${#password} -ge 6 && "$password" == *[A-Z]* && "$password" == *[a-z]* && "$password" == *[0-9]* ]]; then
    break
  else
    echo "The password has to be at least 6 characters long containing a capital character,a low character and a number"
  fi
done


read -sp "Confirm password: " password_confirm

while [ "$password" != "$password_confirm" ]; do
  echo -e "\nThe passwords are different."
  echo -e "\nPlease try again."
  sleep 2
  read -sp "Password " password
  echo
  read -sp "Confirm password: " password_confirm
done

uid=$(uuidgen)
data=$(date +%d-%m-%Y-%H:%M:%S)

echo "$username,$email,$password,$uid,$data" >> users.csv


mkdir -p "/home/stud1019/tudorG/proiect_so/home/$username"


echo -e "\nYour account with the username: '$username' was successfully created."
