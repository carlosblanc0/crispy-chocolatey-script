#Requires -RunAsAdministrator

<#

    Workstation Configuration

    Uses chocolately to install a standard set of software used regularly

    view log: C:\ProgramData\chocolatey\logs\chocolatey.log
    
    ## view installed apps
    choco list --local-only
    
    ## run updates on all software
    choco upgrade all 
    
  
#>

############################################################
# Install Chocolatey
############################################################
if (!(Get-Package -Name *choco*))
{
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

## choco search
    # choco search chef

############################################################
# Install Scoop
############################################################

Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

############################################################
## Windows 10 Config
############################################################

Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

# Get-WindowsCapability -Online | ? name -like *OpenSSH.Server*
Add-WindowsCapability -Name OpenSSH.Server~~~~0.0.1.0 -Online

Set-Service sshd -StartupType Automatic
Set-Service ssh-agent -StartupType Automatic

Start-Service sshd
Start-Service ssh-agent

Get-Service -Name *ssh* | select DisplayName, Status, StartType

#####################
##  General Tools  ##
#####################
choco install adobereader -y
choco install visualstudiocode -y
choco install putty -y
choco install whatsapp -y
chocho install thunderbird -y
chocho install openoffice -y

