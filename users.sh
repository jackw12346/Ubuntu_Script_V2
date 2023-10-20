#!/bin/bash

read -p "Enter authorized users (comma-separated): " authorized_users
read -p "Enter authorized admins (comma-separated): " authorized_admins

default_accounts=("root" "daemon" "bin" "sys" "sync" "games" "man" "lp" "mail" "news" "uucp" "proxy" "www-data" "backup" "list" "irc" "gnats" "nobody" "libuuid" "syslog" "messagebus" "landscape" "sshd")

current_users=$(cut -d: -f1 /etc/passwd | grep -v "^\(root\|sync\|shutdown\|halt\)" | tr '\n' ',' | sed 's/,$//')
current_admins=$(grep -Po '^.*?(?= :\[)' /etc/group | tr '\n' ',' | sed 's/,$//')

IFS=',' read -r -a authorized_users_array <<< "$authorized_users"
IFS=',' read -r -a authorized_admins_array <<< "$authorized_admins"

for user in ${current_users//,/ }; do
  if [[ ! " ${authorized_users_array[*]} " =~ " $user " ]]; then
    unauthorized_users+=($user)
  fi 
done

for user in "${authorized_users_array[@]}"; do
  if [[ ! " $current_users " =~ " $user " ]]; then
    missing_users+=($user)
  fi
done

for admin in ${current_admins//,/ }; do
  if [[ ! " ${authorized_admins_array[*]} " =~ " $admin " ]]; then
    unauthorized_admins+=($admin)
  fi  
done

for admin in "${authorized_admins_array[@]}"; do
  if [[ ! " $current_admins " =~ " $admin " ]]; then
    missing_admins+=($admin)
  fi
done

echo "Unauthorized users: ${unauthorized_users[@]}"
echo "Missing users: ${missing_users[@]}"  
echo "Unauthorized admins: ${unauthorized_admins[@]}"
echo "Missing admins: ${missing_admins[@]}"

read -p "Fix these issues? (yes/no) " consent

if [[ $consent == "yes" ]]; then
  
  for user in "${unauthorized_users[@]}"; do
    userdel $user
  done
  
  for admin in "${unauthorized_admins[@]}"; do
    deluser $admin sudo
  done  

  for user in "${missing_users[@]}"; do
    useradd $user -m
  done

  for admin in "${missing_admins[@]}"; do
    usermod -aG sudo $admin
  done

  for user in "${authorized_users_array[@]}"; do
    if ! id $user > /dev/null 2>&1; then
      useradd $user -m 
      echo "Added user: $user"  
    fi
  done

  new_password="ThisIsASecurePassword12345!"

  for user in $(cut -d: -f1 /etc/passwd); do
    echo $new_password | passwd --stdin $user  
  done

  echo $new_password > /tmp/passwords.txt
  echo "Saved new password to /tmp/passwords.txt"

  for user in $(cut -d: -f1 /etc/passwd | grep -v "^\(root\|sync\|shutdown\|halt\)"); do
    chage -M 90 -m 7 $user
  done  

fi