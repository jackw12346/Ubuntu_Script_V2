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

# Enable block dangerous and deceptive content in Firefox
# TODO: Open Firefox and edit its settings

# Disable SSH root login
sudo vim /etc/ssh/sshd_config (set "PermitRootLogin no")

# Disable empty SSH passwords
sudo vim /etc/ssh/sshd_config (set "PermitEmptyPasswords no")

# Enable APT secure repository checks
# TODO: Ensure secure sources.list configuration

# Remove malicious script 'sabotage'
sudo rm /lib/.core/sabotage

# Remove malicious PAM backdoor
sudo vim /etc/pam.d/common-auth (Edit the file and remove suspicious entry)

# Configure account lockout policy
sudo vim /etc/pam.d/common-auth (Edit the file and configure faillock)

# Set a secure maximum password age
sudo vim /etc/login.defs (Edit the file and set PASS_MAX_

# Set a secure minimum password age
sudo vim /etc/login.defs (Edit the file and set PASS_MIN_DAYS)

# Set a minimum password length
sudo vim /etc/security/pwquality.conf (Edit the file and set minlen)

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

# Ask the user if Apache needs to be installed
echo "Do you want to install Apache? (y/n)"
read answer

if [[ "$answer" == "y" ]]; then
    apt-get install apache2
    apt-get upgrade apache2

    # Harden Apache
    # TODO: Add Apache hardening tasks here