#!/bin/bash

Loc_Random="xxxxxxxxxx"
Loc_StorAcc=$Loc_Random"zzcommon"

# BASE

Loc_Tarball_Base=$Loc_Random"_base.tar.gz"
Loc_Tarball_Base_Link="https://"$Loc_StorAcc".blob.core.windows.net/tarballs/"$Loc_Tarball_Base

cd /
wget $Loc_Tarball_Base_Link

setenforce 0

cd /
tar -zxvf /$Loc_Tarball_Base etc/selinux/config

cd /
tar -zxvf /$Loc_Tarball_Base root/.ssh
tar -zxvf /$Loc_Tarball_Base root/.config/mc

cd /
tar -zxvf /$Loc_Tarball_Base etc/ssh/sshd_config
systemctl restart sshd

systemctl stop postfix
systemctl disable postfix

systemctl stop rpcbind
systemctl disable rpcbind
systemctl mask rpcbind
systemctl stop rpcbind.socket
systemctl disable rpcbind.socket

systemctl stop NetworkManager
systemctl disable NetworkManager

cd /
tar -zxvf /$Loc_Tarball_Base etc/sysconfig/network-scripts/ifcfg-eth0

yum clean all
yum install mc -y

yum install epel-release -y

yum install htop -y
yum install iftop -y
yum install nmon -y

rm -f /$Loc_Tarball_Base

#
