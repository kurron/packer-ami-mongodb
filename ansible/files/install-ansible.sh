#!/bin/bash

set -x

# This installs Ansible in an RHEL 7 environment.  Has been tested in AWS.

# I see an error during update: https://access.redhat.com/articles/1320623
# sudo rm -fr /var/cache/yum/*
# sudo yum clean all

# Install the Extra Packages for Enterprise Linux (EPEL) repository
curl --output /tmp/epel-release-latest-7.noarch.rpm https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm
sudo rpm -i /tmp/epel-release-latest-7.noarch.rpm

# Install PIP and its requirements
sudo yum --assumeyes update
sudo yum --assumeyes install python-pip python-devel libffi-devel openssl-devel gcc redhat-rpm-config

# Install Ansible and the other Python packages it needs
sudo pip install --upgrade pip
sudo pip install --upgrade paramiko
sudo pip install --upgrade ansible
sudo pip install --upgrade boto
ansible --version
