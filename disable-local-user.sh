#!/bin/bash

DeleteUser() {
    read -p "Please input the desired account carefully:" account 
    if [ $(id -u $account) -ge 1000 ]; then
       egrep "^$account" /etc/passwd >/dev/null
       if [ $? -eq 0 ]; then
       	   tar -czf /home/archives/$account.tar.gz /home/$account/ ; sleep 5
           userdel -r $account &>> ./logs/user-deletion.log
	   [ $? -eq 0 ] && echo "User $account has been deleted and it home directory has been archived" || echo "You must provide userid greater than or equal to 1000!"
       else
           echo "$account doesn't exist!"
           exit 1
       fi
    else
	echo "User deletion failed!"
	exit 2
    fi 
}

if [ $(id -u) -eq 0 ]; then
     read -p "Do you wish to delete a user? [Yy] or [Nn]" answer
     while true; do
       case $answer in
  	     [Yy]* ) DeleteUser;break;;
  	     [Nn]* ) exit;;
  	     * ) echo "Please answer Yy or Nn";;
       esac
     done
else
     echo "Only root may add a user to the system."
     exit 2
fi

