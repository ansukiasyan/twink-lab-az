#!/bin/bash

# Disable Selinux
setenforce 0

# Stop and disable some services
systemctl stop postfix
systemctl disable postfix

systemctl stop rpcbind
systemctl disable rpcbind
systemctl mask rpcbind
systemctl stop rpcbind.socket
systemctl disable rpcbind.socket

systemctl stop NetworkManager
systemctl disable NetworkManager

# Clean yum database
yum clean all

# Update CentOS
#yum update -y

# Install some CentOS packages
yum install mc -y

# Base config CentOS
cd /
wget https://github.com/arabadj/twink-lab-az/raw/master/shellconfig/centos_files/base.tar.gz
tar -zxvf base.tar.gz
systemctl restart sshd

# Install EPEL repository
yum install epel-release -y

# Install some packages
yum install htop -y
yum install iftop -y
yum install nmon -y

#
