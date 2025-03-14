#!/bin/bash

incercari_logare=0

if [ -z ${logged_in_users+x} ]; then
  declare -a logged_in_users
fi



while true; do

  read -p "Username: " username
  user=$(cut -d ',' -f 1 /home/stud1019/tudorG/proiect_so/users.csv 2>/dev/null | grep -w "$username")

   case "$user" in
    "$username")
      if echo "${logged_in_users[@]}" | grep -qw "$user"; then
        echo "User is already logged in."
      else
        break
      fi
      read -p "Want to try again? (y/n) " raspuns
      if [[ "$raspuns" != "y" ]]; then
        sleep 1
        echo "You chose to continue."
        return 1
      fi

      ;;
    *)
      echo "User $username does not exist"
      read -p "Want to try again? (y/n) " raspuns
      if [[ "$raspuns" != "y" ]]; then
        sleep 1
        echo "You chose to continue."
        return 1
      fi
      ;;

  esac

done

row=$(awk -F ',' -v user="$user" '{ if ($1 == user) { print NR } }' /home/stud1019/tudorG/proiect_so/users.csv)

while [ $incercari_logare -lt 3 ]; do
  read -sp "Enter Password:  " password
  echo

  pass=$(sed -n "${row}p" /home/stud1019/tudorG/proiect_so/users.csv | cut -d ',' -f 3 | grep -w "$password")
  if [[ "$pass" == "$password" ]]; then
    break
  else
    let incercari_logare++
    if [ $incercari_logare -eq 3 ]; then
    sleep 1
    echo "You have no more tries."
    return 1
    elif [ $incercari_logare -eq 2 ]; then
    echo "Wrong password, $((3-incercari_logare)) more tries"
    else
    echo "Wrong password $((3-incercari_logare)) more tries"
    fi
  fi
done

logged_in_users+=("$user")

data=$(date +%d-%m-%Y-%H:%M:%S)
awk -F ',' -v user="$user" -v data="$data" 'BEGIN { OFS = FS } { if ($1 == user) { $5 = data } print }' /home/stud1019/tudorG/proiect_so/users.csv > /home/stud1019/tudorG/proiect_so/temp.csv && mv /home/stud1019/tudorG/proiect_so/temp.csv /home/stud1019/tudorG/proiect_so/users.csv


cd "/home/stud1019/tudorG/proiect_so/home/$user"
nume_din_dir=$(pwd | cut -d '/' -f 7) > /dev/null
echo "Welcome $user!"
