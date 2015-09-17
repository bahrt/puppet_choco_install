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

Powershell script to bootstrap a custom EC2 Windows instance


## Module Description

The script installs Puppet Agent for Windows and Chocolatey 64 bits and registers it against a Puppet Server. 

## Setup

### What pe_choco_install affects

pe_choco_install will install puppet-agent-x64-latest.msi from Puppet Windows downloads and then run the standard Chocolatey install PS command, which downloads the latest version and installs it.

### Setup Requirements

Both packages would support 32 bits systems, but at the time of writing, Puppet will download the 64 bits distribution without checking, so 32 bits is not supported.

## Usage

You'll need to edit the ps1 script and adjust the env variables to your needs prior to first run.
Then inject the template from your Puppet AWS ec2_instance manifest: 
  `user_data => template('dir_name/pe_choco_template.ps1.erb'),`
and launch the instance. The user-data code will run during first boot, download Puppet and Choco, install them, and then register the node against Puppet Server.

## Limitations

Tested on Windows 2008 R2 and 2012, both 64 bits.

## Development

Currently under heavy development.




