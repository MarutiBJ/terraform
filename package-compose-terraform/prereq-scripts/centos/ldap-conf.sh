#!/bin/bash

source /tmp/config.sh


echo "Add user compose"
echo $JUMP_HOST_PASS | sudo -S useradd $LDAP_USER

echo "Set Password for user compose"
echo $JUMP_HOST_PASS | echo $LDAP_USER_PASS | sudo -S passwd $LDAP_USER --stdin

echo "Add user compose in sudoers file"
echo $JUMP_HOST_PASS | sudo -S sed -i '100i'"$COMPOSE_SUDO_PERM"  /etc/sudoers

echo "Set compose user for NOPASSWD  in sudoers file"
echo $JUMP_HOST_PASS | sudo -S sed -i '111i'"$COMPOSE_NOPASSWD"  /etc/sudoers

echo "Update the /etc/sysconfig/network file with the new hostname/fqdn"
echo $JUMP_HOST_PASS | sudo -S sed -i "/HOSTNAME/c\HOSTNAME=$LDAP_HOSTNAME" /etc/sysconfig/network

echo "Update the running hostname"
echo $JUMP_HOST_PASS | sudo -S hostname $LDAP_HOSTNAME

echo "Update the OS"
echo $JUMP_HOST_PASS | sudo -S yum update -y

echo "Restart OS"
echo $JUMP_HOST_PASS | sudo -S init 6

