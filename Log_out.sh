#!/bin/bash

if [ -z ${logged_in_users+x} ] || [ ${#logged_in_users[@]} -eq 0 ]; then
  echo "There are no logged users."
  return 1
fi

while true; do
  read -p "User name for log out: " username
  cheie=""
  for i in "${!logged_in_users[@]}"; do
    if [[ "${logged_in_users[$i]}" = "$username" ]]; then
      cheie=$i
      break
    fi
  done
  if [ -n "$cheie" ]; then
    unset 'logged_in_users[cheie]'
    echo "The User $username was logged out"
  else
    echo "The user $username is not logged in"
  fi
  logged_in_users=("${logged_in_users[@]}")
done
