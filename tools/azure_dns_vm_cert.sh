#!/bin/bash

# WASOC Azure VM DNS Zone Certbot - A simple bash script to authenticate against a exisiting A records in Azure DNS Zones to a authorised Azure VMs for Let Encrypts SSL Certs Generation (Certbot) via Azure Managed Indentity.
# Author: Joshua Hitchen

Green='\033[0;32m' # Green Color
NC='\033[0m' # No Color

cat << EndOfMessage

#####################################
#  WASOC Azure VM DNS Zone Certbot  #
#####################################

EndOfMessage

printf "${Green}|--Installing all dependencies--|${NC} \n"

apt update -y && apt upgrade -y
snap install core
snap refresh core
snap install --classic certbot
ln -s /snap/bin/certbot /usr/bin/certbot
snap set certbot trust-plugin-with-root=ok
snap install --edge certbot-dns-azure
snap connect certbot:plugin certbot-dns-azure

printf "${Green}|--Collecting revelant Azure credentials from user--|${NC} \n"

read -p 'DNS Zone Name: ' dns_name
read -p 'DNS Zone Subscription ID: ' dns_sub_id
read -p 'DNS Zone Resource Group Name: ' dns_rg_name

echo "Writing credentials to file --> azure_certbot_config.ini"=

cat << EOF > azure_certbot_config.ini
dns_azure_msi_system_assigned = true

dns_azure_environment = "AzurePublicCloud"

dns_azure_zone1 = $dns_name:/subscriptions/$dns_sub_id/resourceGroups/$dns_rg_name
EOF

printf "${Green}|--Initalising the certbot--|${NC} \n"

read -p 'Support Email Address For Lets Encrypt Certbot: ' email_address
read -p 'New Domain Url: ' domain

chmod 600 azure_certbot_config.ini

certbot certonly \
  --authenticator dns-azure \
  --preferred-challenges dns \
  --noninteractive \
  --agree-tos \
  --email $email_address \
  --dns-azure-config azure_certbot_config.ini \
  -d $domain

cat << EndOfMessage

###########################################
#  Azure DNS Zone Certbot Task Completed  #
###########################################

EndOfMessage