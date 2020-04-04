#!/bin/bash
useradd origin
echo -e "PASSWORD\nPASSWORD\n" | passwd origin
echo -e 'Defaults:origin !requiretty\norigin ALL = (root) NOPASSWD:ALL' | tee /etc/sudoers.d/openshift
chmod 440 /etc/sudoers.d/openshift
yum -y install centos-release-openshift-origin311 git pyOpenSSL
