#!/bin/bash
if [ $(id -u) -eq 0 ]; then
     read -p "Enter the username to create: " varusername
     read -p "Enter the name of the person or application that will be using this account: " varname
     read -p "Enter the password to use for the account: " varpasswd

     egrep "^$varusername" /etc/passwd >/dev/null
     if [ $? -eq 0 ]; then
         echo "$varusername exist!"
         exit 1
     else
         ENCRYPTEDPASSWD=$(openssl passwd -crypt $varpasswd)
         useradd -m -s /bin/bash -c "$varname" -p $ENCRYPTEDPASSWD $varusername
#        usermod -aG sudo $varname && pveum usermod sucahyo@pam -group admin
         [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
     fi
else
     echo "Only root may add a user to the system."
     exit 2
fi
