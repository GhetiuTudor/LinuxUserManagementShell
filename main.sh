#!/bin/bash

clear

while true; do
  echo
  echo "--------------Hello------------"
  echo "1.Register"
  echo "2.Log in"
  echo "3.Log out"
  echo "4.Report"
  echo "5.Check logged users"
  echo "6.Check path"
  echo "7.Exit"
  echo "-------------------------------"
  echo
  read -p "Your option " optiune
  echo

  case $optiune in
        1)
            clear
            /home/stud1019/tudorG/proiect_so/register.sh
            ;;
        2)
            clear
	    source /home/stud1019/tudorG/proiect_so/log_in.sh
            stare_utilizator=1
            ;;
        3)
            if [ -n ${logged_in_users+x} ]; then
                clear
                source /home/stud1019/tudorG/proiect_so/Log_out.sh
            else
                echo "You are not logged in"
            fi
            ;;
        4)
            clear
            /home/stud1019/tudorG/proiect_so/report.sh
            ;;
        5)
            clear
            if [ -n ${logged_in_users+x} ] && [ ${#logged_in_users[@]} -gt 0 ] ; then
              old_IFS=$IFS
              IFS=","
              echo "Logged users: ${logged_in_users[*]}."
              IFS=$old_IFS
            else
              echo "No logged users."
            fi
            sleep 1
            ;;
        6)
            clear
            echo "Your path $PWD"
            sleep 1
            ;;
        7)
	    cd /home/stud1019/tudorG/proiect_so
            break
            ;;
        *)
            echo "Invalid option"
            ;;

    esac
done

sleep 1
echo "You exited"
