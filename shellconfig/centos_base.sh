#!/bin/bash

#wget https://github.com/arabadj/twink-lab-az/raw/master/shellconfig/centos_files/base.tar.gz

setenforce 0

systemctl stop postfix
systemctl disable postfix

systemctl stop rpcbind
systemctl disable rpcbind
systemctl mask rpcbind
systemctl stop rpcbind.socket
systemctl disable rpcbind.socket

systemctl stop NetworkManager
systemctl disable NetworkManager

yum clean all
#yum update -y
yum install mc -y

yum install epel-release -y

yum install htop -y
yum install iftop -y
yum install nmon -y

#
