# Overview
This project creates an [Amazon Machine Image](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html) with
MongoDB pre-installed and ready to be joined to a replica set.

# Prerequisites
* a working [Packer](https://www.packer.io/) installation
* a working [Ansible](https://www.ansible.com/) installation
* a working [Bash](https://www.gnu.org/software/bash/) installation
* your AWS IAM keys exported to the environment
    * AWS_ACCESS_KEY_ID
    * AWS_SECRET_ACCESS_KEY
    * AWS_REGION

Testing was done under Ubuntu 16.04 Linux.

# Building

Typing `./build.sh` will run Packer and build out an AMI image which can be used in
[CloudFormation](https://aws.amazon.com/cloudformation/) templates.

Configurable values are located in `variables.json`.  You may edit these as need to customize the template.

# Installation

Other than the prerequisites, there is nothing to install.  The script will install into the region's AMI registry.

# Tips and Tricks

## Ansible Roles
The playbook reuses logic from [open source Ansible roles](https://galaxy.ansible.com/kurron/). Consult those
playbooks to learn exactly how certain aspects of the plays are configured.

# Troubleshooting

## Packer and Ansible Coordination
Creating the AMI requires that two different tools coordinate with each other.  In particular,
when creating and manipulating the EBS storage volumes.  Packer is where the volumes are created
and Ansible is where they are formatted.  You need to ensure that both the `mongodb.json` and
`playbook.yml` files are in harmony with each other or failures will occur.

## MongoDB Will Not Start
One place to look is to verify that `/var/run/mongodb` exists.  That is where MongoDB stores its PID
file and that directory does not exist on a new EC2 instance.  We have adjusted the systemd configuration
to recreate the directory prior to MongoDB starting.  If, for some reason, you need to run the steps by
hand, this is what the script does:

```
#!/bin/bash

mkdir -p /var/run/mongodb
chown mongod:mongod /var/run/mongodb
```

This should create the missing directory.

# License and Credits
This project is licensed under the [Apache License Version 2.0, January 2004](http://www.apache.org/licenses/).
