#!/bin/bash

sudo apt-get update

# Install vsftpd, python, python3 and python3-pip
sudo apt-get install -y vsftpd
sudo apt-get install -y python
sudo apt-get install -y python3

# Allow FTP connections
sudo ufw default deny outgoing
sudo ufw default deny incoming
sudo ufw allow 20/tcp
sudo ufw allow 21/tcp
sudo ufw allow 22/tcp
sudo ufw allow 2019/tcp

# Change SSH config
sudo cp our_sshd_config /etc/ssh/sshd_config
sudo systemctl restart sshd

# Change config to allow anonymous access
sudo cp our_vsftpd.conf /etc/vsftpd.conf
sudo systemctl restart vsftpd

# Create directory and test file for anonymous FTP to read
sudo mkdir -p /var/ftp/pub
sudo chown nobody:nogroup /var/ftp/pub
echo "vsftpd test file" | sudo tee /var/ftp/pub/test.txt

# Copy new user info to anon FTP directory
sudo cp new_user.txt /var/ftp/pub/.new_user.txt

# Make user 'garrett' to run service
sudo useradd garrett
sudo mkdir -p /home/garrett
sudo chown garrett:garrett /home/garrett
sudo usermod -s /bin/bash garrett
sudo echo 'garrett:P@$$w0rd_random_P@$$w0rd_hahaha' | sudo chpasswd

# Change the sudoers file so 'garrett' can run things as root
sudo cp our_sudoers /etc/sudoers

# Make User 2
sudo useradd hq_admin
sudo mkdir -p /home/hq_admin
sudo chown hq_admin:hq_admin /home/hq_admin
sudo usermod -s /bin/bash hq_admin
sudo echo 'hq_admin:P@$$w0rd_random_P@$$w0rd_ha_admin' | sudo chpasswd

# Install python3 pip in order to install pycrypto
sudo apt-get install -y python3-pip
sudo pip3 install pycrypto

# Move cmd_service to directory
sudo mkdir -p /var/cmd/
sudo cp cmd_service.py /var/cmd/.cmd_service.py
sudo chmod +x /var/cmd/.cmd_service.py

# Make cmd service function as a service
sudo cp cmd.service /etc/systemd/system/cmd.service

sudo systemctl daemon-reload
sudo systemctl enable cmd.service
sudo systemctl restart cmd.service

# Copy SSH key for 'garrett'
sudo mkdir -p /home/garrett/.ssh
sudo cp garrett_id_rsa /home/garrett/.ssh/id_rsa
sudo cp garrett_id_rsa.pub /home/garrett/.ssh/id_rsa.pub
sudo cp garrett_id_rsa.pub /home/garrett/.ssh/authorized_keys

# Copy root ssh key into garrett folder
sudo mkdir -p /home/garrett/.ssh/.root
sudo cp root_id_rsa /home/garrett/.ssh/.root/.id_rsa

# Make 'garrett' owner of ssh folders
sudo chown garrett:garrett /home/garrett/.ssh
sudo chown garrett:garrett /home/garrett

# Copy root ssh key to root folder
sudo cp root_authorized_keys /root/.ssh/authorized_keys
sudo cp root_id_rsa /root/.ssh/id_rsa
sudo cp root_id_rsa.pub /root/.ssh/id_rsa.pub

# Copy 'garrett' flag
sudo cp user.txt /home/garrett/user.txt
sudo chown garrett:garrett /home/garrett/user.txt

# Copy 'root' flag
sudo cp root.txt /root/root.txt

# Enable firewall
sudo ufw enable

# Change 'ubuntu' user password
sudo echo 'ubuntu:P@$$w0rd_ubuntu' | sudo chpasswd

# Delete command history
unset HISTFILE

# Remove 'hq_admin' user
#sudo deluser hq_admin
#sudo delgroup hq_admin
