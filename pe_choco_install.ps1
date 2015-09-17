# Powershell script to bootstrap a default Windows instance
###
# Launched during first boot, sets default PS ExecutionPolicy, installs PE
# Agent 64 bits reporting to its PE Server. Chocolatey is installed directly 
# from the user-data template.
#
# EC2 user-data taken from:
# https://github.com/bahrt/puppet_choco_install/blob/master/pe_choco_template.ps1.erb
#

# Environment variables
$SOFTDIR="C:\software"
$PE_INSTALL_DIR="C:\tools\Puppet"
$PE_SERVER="usladpup03.chi.warranty.local"


# ** Should not need to edit anything below this line **
$PE_FILE_NAME="puppet-agent-x64-latest.msi"
$PE_DOWNLOAD_URL="https://downloads.puppetlabs.com/windows/${PE_FILE_NAME}"
$PE_INSTALLER=${SOFTDIR}+"\"+${PE_FILE_NAME}

# ***** TEMPORARY ***** Add Puppet server to etc\hosts
Add-Content C:\Windows\system32\drivers\etc\hosts "`n10.20.64.49`t $PE_SERVER"
# ***** TEMPORARY *****

# Set execution policy to RemoteSigned for later PS1 scripts
Set-ExecutionPolicy RemoteSigned -Force

# Download and install Puppet Agent
New-Item -Force -ItemType dir $SOFTDIR
Invoke-WebRequest $PE_DOWNLOAD_URL -OutFile $PE_INSTALLER
iex "msiexec /qn /norestart /i ${PE_INSTALLER} /l*v $SOFTDIR\pe_agent_install.log INSTALLDIR=$PE_INSTALL_DIR PUPPET_MASTER_SERVER=$PE_SERVER"

