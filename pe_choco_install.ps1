# EC2 user-data:
# <powershell>Start-Process powershell -Verb RunAs "iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/bahrt/puppet_choco_install/master/pe_choco_install.ps1'))"</powershell>

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

# Chocolatey installation - does not allow custom dir installation
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

# Download and install Puppet Agent
New-Item -Force -ItemType dir $SOFTDIR
Invoke-WebRequest $PE_DOWNLOAD_URL -OutFile $PE_INSTALLER
iex "msiexec /qn /norestart /i ${PE_INSTALLER} /l*v $SOFTDIR\pe_agent_install.log INSTALLDIR=$PE_INSTALL_DIR PUPPET_MASTER_SERVER=$PE_SERVER"

