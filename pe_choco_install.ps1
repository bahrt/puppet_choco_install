# Run this: 
# @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/bahrt/puppet_choco_install/master/pe_choco_install.cmd'))"

# Environment variables
$SOFTDIR=C:\software
$PE_INSTALL_DIR=C:\tools\Puppet
$PE_SERVER=usladpup03.chi.warranty.local


# ** Should not need to edit anything below this line **
$PE_FILE_NAME=puppet-agent-x64-latest.msi
$PE_DOWNLOAD_URL=https://downloads.puppetlabs.com/windows/$PE_FILE_NAME
$PE_INSTALLER=$SOFTDIR\$PE_FILE_NAME


# Set execution policy to RemoteSigned for later PS1 scripts
Set-ExecutionPolicy RemoteSigned -Force

# Download and install Puppet Agent
mkdir $SOFTDIR
Invoke-WebRequest $PE_DOWNLOAD_URL -OutFile $PE_INSTALLER
cmd /C "msiexec /qn /norestart /i ${PE_INSTALLER}/l*v $SOFTDIR\pe_agent_install.log INSTALLDIR=$PE_INSTALL_DIRPUPPET_MASTER_SERVER=$PE_SERVER"

# Chocolatey installation - does not allow custom dir installation
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
