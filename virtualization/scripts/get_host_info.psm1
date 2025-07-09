# Module to gather system information on Windows using PowerShell
# Requires -Version 5.1 +


# system information
# Host Name
$env:COMPUTERNAME


# System Manufacturer and Model
Get-CimInstance Win32_ComputerSystem


# CPU info
Get-CimInstance -ClassName Win32_Processor | Select-Object Name, NumberOfCores, NumberOfLogicalProcessors


# Virtualization Enabled?
Get-CimInstance Win32_ComputerSystem | Select HypervisorPresent

systeminfo


# BIOS info
Get-CimInstance -ClassName Win32_BIOS | Select-Object Manufacturer, SMBIOSBIOSVersion, ReleaseDate

# Secure Boot Enabled?
Confirm-SecureBootUEFI

# RAM
Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum | 
    ForEach-Object { "{0:N2} GB" -f ($_.Sum / 1GB) }

systeminfo


# OS info
Get-CimInstance Win32_OperatingSystem | Select Caption, Version, BuildNumber

# OS Version
Get-CimInstance Win32_OperatingSystem

# OS Edition
Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion'

# OS License Key Activation Status
slmgr /xpr

# Storage
# Primary Disk
Get-PhysicalDisk

# NICs
Get-NetAdapter |
Where-Object { $_.Status -eq 'Up' -and $_.InterfaceDescription -notmatch 'Bluetooth' } |
Select-Object Name, InterfaceDescription, Status, LinkSpeed,
@{Name='Speed (Gbps)'; Expression = {
    if ($_.LinkSpeed -match '(\d+)\s*Mbps') {
        [math]::Round($matches[1] / 1000, 2)
    } elseif ($_.LinkSpeed -match '(\d+)\s*Gbps') {
        [math]::Round($matches[1], 2)
    } else {
        "Unknown"
    }
}}

# Check Available Space for VMs
Get-PSDrive -PSProvider 'FileSystem' |
Select-Object Name, @{Name="Total(GB)";Expression={[math]::Round($_.Used/1GB + $_.Free/1GB,2)}},
                      @{Name="Used(GB)";Expression={[math]::Round($_.Used/1GB,2)}},
                      @{Name="Free(GB)";Expression={[math]::Round($_.Free/1GB,2)}},
                      @{Name="Buffer(GB)";Expression={[math]::Round($_.Free/1GB * 0.2,2)}},
                      @{Name="Available for VMs (GB)";Expression={[math]::Round($_.Free/1GB * 0.8,2)}}

