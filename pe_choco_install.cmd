rem Environment variables
set SOFTDIR=C:\software
set PE_INSTALL_DIR=C:\tools\Puppet
set PE_SERVER=usladpup03.chi.warranty.local


rem ** Shouldn't need to edit anything below this line **
set PE_FILE_NAME=puppet-agent-x64-latest.msi
set PE_DOWNLOAD_URL=https://downloads.puppetlabs.com/windows/%PE_FILE_NAME%
set PE_INSTALLER=%SOFTDIR%\%PE_FILE_NAME%
rem Choco download url must be quoted for PS to treat it as a string
set CHOCO_DOWNLOAD_URL='https://chocolatey.org/install.ps1'


rem Set execution policy to RemoteSigned for later PS1 scripts
@powershell Set-ExecutionPolicy RemoteSigned -Force

rem Download and install Puppet Agent
mkdir %SOFTDIR%
@powershell Invoke-WebRequest %PE_DOWNLOAD_URL% -OutFile %PE_INSTALLER%
msiexec /qn /norestart /i %PE_INSTALLER% /l*v %SOFTDIR%\pe_agent_install.log INSTALLDIR=%PE_INSTALL_DIR% PUPPET_MASTER_SERVER=%PE_SERVER%

rem Chocolatey installation - does not allow custom dir installation
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString(%CHOCO_DOWNLOAD_URL%))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

