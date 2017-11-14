#!/bin/bash

#sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq -y ssh < /dev/null > /dev/null
sed -i "/^deb cdrom:/s/^/#/" /etc/apt/sources.list

# Reset the hosts file
echo "Fixing the hosts file"
sudo mv /etc/hosts{,.old}
MYIP=$(hostname -I | tr -d '[:space:]')
printf '127.0.0.1\tlocalhost.localdomain\tlocalhost\n127.0.1.1\tubuntu\n'$MYIP'\t'$(hostname)'\tzimbra.mail.local\tzimbra' | sudo tee -a /etc/hosts >/dev/null 2>&1

echo "Setting hostname to zimbra.mail.local"
hostnamectl set-hostname zimbra.mail.local >/dev/null 2>&1

echo "Setting timezone to Singapore"
timedatectl set-timezone Asia/Singapore >/dev/null 2>&1

echo "Update apt package list"
apt-get -qq update
