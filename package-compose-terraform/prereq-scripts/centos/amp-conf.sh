#!/bin/bash

source /tmp/config.sh


echo "Add compose user"
echo $JUMP_HOST_PASS | sudo -S useradd $AMP_USER

echo "Set Password for compose user"
echo $JUMP_HOST_PASS | echo $AMP_USER_PASS | sudo -S passwd $AMP_USER --stdin

echo "Add user amp"
echo $JUMP_HOST_PASS | sudo -S useradd amp

echo "Set Password for user amp"
echo $JUMP_HOST_PASS | echo $AMP_USER_PASS | sudo -S passwd amp --stdin

echo "Add compose user in sudoers file"
echo $JUMP_HOST_PASS | sudo -S sed -i '100i'"$COMPOSE_SUDO_PERM"  /etc/sudoers

echo "Add user amp in sudoers file"
echo $JUMP_HOST_PASS | sudo -S sed -i '100i'"$AMP_SUDO_PERM"  /etc/sudoers

echo "Set compose user for NOPASSWD  in sudoers file"
echo $JUMP_HOST_PASS | sudo -S sed -i '111i'"$COMPOSE_NOPASSWD"  /etc/sudoers

echo "set ulimit in /etc/security/limits.conf file"
echo $JUMP_HOST_PASS | sudo -S sed -i '50i'"amp  soft  nproc 16384"  /etc/security/limits.conf
echo $JUMP_HOST_PASS | sudo -S sed -i '50i'"amp  hard  nproc 16384"  /etc/security/limits.conf
echo $JUMP_HOST_PASS | sudo -S sed -i '50i'"amp  soft  nofile 16384"  /etc/security/limits.conf
echo $JUMP_HOST_PASS | sudo -S sed -i '50i'"amp  hard  nofile 16384"  /etc/security/limits.conf

echo "Update the /etc/sysconfig/network file with the new hostname/fqdn"
echo $JUMP_HOST_PASS | sudo -S sed -i "/HOSTNAME/c\HOSTNAME=$AMP_HOSTNAME" /etc/sysconfig/network

echo "Update the running hostname"
echo $JUMP_HOST_PASS | sudo -S hostname $AMP_HOSTNAME

echo "Update the OS"
echo $JUMP_HOST_PASS | sudo -S yum update -y 

echo "Restart OS"
echo $JUMP_HOST_PASS | sudo -S init 6

