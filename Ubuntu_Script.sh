#!/bin/bash

# Set screen timeout policy
gsettings set org.gnome.desktop.session idle-delay 300

# Enable automatic screen lock
gsettings set org.gnome.desktop.screensaver lock-enabled true

# Enable automatic updates
# TODO: Use GUI for auto updates

# Disable automatic login
sudo sed -i 's/AutomaticLoginEnable=True/AutomaticLoginEnable=False/' /etc/gdm3/custom.conf

# Lock the root account
sudo passwd -l root

# Remove prohibited MP3 files
locate *.mp3 | xargs sudo rm -f

# Enable UFW firewall
sudo ufw enable

# Disable NFS
sudo systemctl stop nfs-kernel-server nfs-server nfsdcld nfs-mountd nfs-idmapd nfs-blkmap
sudo systemctl disable nfs-kernel-server nfs-server nfsdcld nfs-mountd nfs-idmapd nfs-blkmap

# Disable Nginx
sudo systemctl stop nginx
sudo systemctl disable nginx

# Enable Apache
sudo systemctl enable apache2

# Configure UFW for Apache
sudo ufw app update Apache
sudo ufw allow 'Apache Secure'

# Start the SSH server
sudo systemctl start ssh
sudo systemctl enable ssh

# Enable IPv4 TIME-WAIT ASSASSINATION
echo "net.ipv4.tcp_rfc1337 = 1" | sudo tee -a /etc/sysctl.conf

# Enable IPv4 TCP SYN cookies
echo "net.ipv4.tcp_syncookies = 1" | sudo tee -a /etc/sysctl.conf

# Disable IPv4 forwarding
sudo sysctl -w net.ipv4.ip_forward=0

# Disable IPv4 source routing
echo "net.ipv4.conf.all.send_redirects = 0" | sudo tee -a /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_source_route = 0" | sudo tee -a /etc/sysctl.conf

# Enable Martian packet logging
echo "net.ipv4.conf.all.log_martians = 1" | sudo tee -a /etc/sysctl.conf

# Update the Linux kernel
# TODO: Check if update is needed
sudo apt update
sudo apt upgrade

# Enable source address verification
echo "net.ipv4.conf.default.rp_filter = 1" | sudo tee -a /etc/sysctl.conf
echo "net.ipv4.conf.all.rp_filter = 1" | sudo tee -a /etc/sysctl.conf

# Disable ICMP redirect acceptance
echo "net.ipv4.conf.all.accept_redirects = 0" | sudo tee -a /etc/sysctl.conf
echo "net.ipv6.conf.all.accept_redirects = 0" | sudo tee -a /etc/sysctl.conf

# Remove prohibited software
sudo apt-get remove ophcrack
sudo apt-get remove hydra
sudo apt-get remove john
sudo apt-get remove nmap
sudo apt-get remove snort
sudo apt-get remove wireshark

# Enable APT secure repository checks
# TODO: Ensure secure sources.list configuration

# Remove malicious script 'sabotage'
sudo rm /lib/.core/sabotage

# Set screen timeout policy
gsettings set org.gnome.desktop.session idle-delay 300

# Enable automatic screen lock
gsettings set org.gnome.desktop.screensaver lock-enabled true

# Enable automatic updates
# TODO: Use GUI for auto updates

# Disable automatic login
sudo sed -i 's/AutomaticLoginEnable=True/AutomaticLoginEnable=False/' /etc/gdm3/custom.conf

# Lock the root account
sudo passwd -l root

# Remove prohibited MP3 files
locate *.mp3 | xargs sudo rm -f

# Enable UFW firewall
sudo ufw enable

# Disable NFS
sudo systemctl stop nfs-kernel-server nfs-server nfsdcld nfs-mountd nfs-idmapd nfs-blkmap
sudo systemctl disable nfs-kernel-server nfs-server nfsdcld nfs-mountd nfs-idmapd nfs-blkmap

# Disable Nginx
sudo systemctl stop nginx
sudo systemctl disable nginx

# Install clamtk
apt-get install clamtk

# Run the ClamAV scan
freshclam

# Set automatic updates
System settings>software & updates>Updates
Automatically check for updates
Important security updates

# Search for all prohibited files
find / -name “*.{extension}” –type f

# Configure the firewall
apt-get install ufw / yum install ufw
ufw enable
ufw status

# Edit the lightdm.conf file
Ubuntu 
Edit /etc/lightdm/lightdm.conf or /usr/share/lightdm/lightdm.conf/50-ubuntu.conf
allow-guest=false
greeter0hide-users=true
greeter-show-manual-login=true
autologin-user=none

# Updates

sudo apt update 
sudo apt upgrade 

# Get all users from the sudoers file
users=$(grep -v '^#' /etc/sudoers | awk '{print $1}')

# Write the users to a file called sudo_users.txt
echo "$users" > sudo_users.txt

# Get all users on the system
users=$(getent passwd | cut -d':' -f1)

# Write the users to a file called all_users.txt
echo "$users" > all_users.txt

# Get all groups on the system
groups=$(getent group | cut -d ':' -f1)

# Create a file to store the output
output_file="group_members.txt"

# Write the header row to the file
echo "Group:Members" > $output_file

# Iterate through all groups and write the members to the file
for group in $groups; do
  # Get the members of the group
  members=$(getent group $group | cut -d ':' -f4)

  # Write the group and its members to the file
  echo "$group:$members" >> $output_file
done