#!/bin/bash

cd /
rm -f base.tar.gz
tar -czpf base.tar.gz \
	/etc/selinux/config \
	/etc/ssh/sshd_config \
	/etc/sysconfig/network-scripts/ifcfg-eth0 \
	/root/.ssh/authorized_keys \
	/root/.config/mc/ini \
	/root/.config/mc/panels.ini



