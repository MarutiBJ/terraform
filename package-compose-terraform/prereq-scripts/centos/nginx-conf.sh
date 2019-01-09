#!/bin/bash

source /tmp/config.sh


echo "Add user compose"
echo $JUMP_HOST_PASS | sudo -S useradd $AMP_NGINX_USER

echo "Set Password for user compose"
echo $JUMP_HOST_PASS | echo $AMP_NGINX_USER_PASS | sudo -S passwd $AMP_NGINX_USER --stdin

echo "Add user compose in sudoers file"
echo $JUMP_HOST_PASS | sudo -S sed -i '100i'"$COMPOSE_SUDO_PERM"  /etc/sudoers

echo "Set compose user for NOPASSWD  in sudoers file"
echo $JUMP_HOST_PASS | sudo -S sed -i '111i'"$COMPOSE_NOPASSWD"  /etc/sudoers

echo "Update the /etc/sysconfig/network file with the new hostname/fqdn"
echo $JUMP_HOST_PASS | sudo -S sed -i "/HOSTNAME/c\HOSTNAME=$AMP_NGINX_HOSTNAME" /etc/sysconfig/network

echo "Update the running hostname"
echo $JUMP_HOST_PASS | sudo -S hostname $AMP_NGINX_HOSTNAME

echo "Update the OS"
echo $JUMP_HOST_PASS | sudo -S yum update -y

echo "Restart OS"
echo $JUMP_HOST_PASS | sudo -S init 6

