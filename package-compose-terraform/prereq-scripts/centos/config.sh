#!/bin/bash


AMP_HOSTNAME="compose-amp.compose.canopy-cloud.com"          # Changes hostnames as you want
AMP_USER="compose"                                           # Dont change usernames for servers, it should be compose only. password could be anything that you want
AMP_USER_PASS="Canopy1!"

AMP_NGINX_HOSTNAME="amp-nginx.compose.canopy-cloud.com"
AMP_NGINX_USER="compose"
AMP_NGINX_USER_PASS="Canopy1!"

LDAP_HOSTNAME="ldap.compose.canopy-cloud.com"
LDAP_USER="compose"
LDAP_USER_PASS="Canopy1!"


COMPOSE_SUDO_PERM="compose ALL=(ALL)  ALL"
AMP_SUDO_PERM="amp ALL=(ALL)  ALL"
COMPOSE_NOPASSWD="compose         ALL=(ALL)       NOPASSWD: ALL"


echo $AMP_HOSTNAME
echo $AMP_NGINX_HOSTNAME
echo $LDAP_HOSTNAME

JUMP_HOST_PASS="Canopy1!"					#Set compose user's password to this variable
