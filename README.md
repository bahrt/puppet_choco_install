# puppet_choco_install

#### Table of Contents

1. [Overview](#overview)
2. [Description](#module-description)
3. [Setup - The basics of getting started with pe_choco_install](#setup)
    * [What pe_choco_install affects](#what-pe_choco_install-affects)
    * [Setup requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Powershell user-data code to bootstrap a custom EC2 Windows instance


## Module Description

The script installs Chocolatey, which in turn installs Puppet Agent with the provided server address. 

## Setup

### What pe_choco_install affects

pe_choco_install will install Chocolatey with from its standard install command. Then will install Puppet Agent using `choco install` with a custom Puppet Server adress as parameter.

# Setup Requirements

You need a valid EC2 subscription, and obviously a Puppet Server to which the agent will report.
Even though I tested only 64 bits systems, it should work in 32 bits too.

## Usage

You'll need to edit the code and adjust the Puppet Server name.
Then inject the template from your Puppet AWS ec2_instance manifest: 
  `user_data => template('dir_name/pe_choco_template.ps1.erb'),`
and launch the instance. The user-data code will run during first boot, download Choco and then install Puppet Agent, which will register the node against Puppet Server during first run.

## Limitations

Tested on Windows 2008 R2 and 2012, both 64 bits.

## Development

Currently under heavy development.

