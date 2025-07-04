# Module to gather system information on Windows using PowerShell
# Requires -Version 5.1 +

# CPU info
Get-CimInstance -ClassName Win32_Processor | Select-Object Name, NumberOfCores, NumberOfLogicalProcessors

# RAM
Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum | 
    ForEach-Object { "{0:N2} GB" -f ($_.Sum / 1GB) }

# BIOS info
Get-CimInstance -ClassName Win32_BIOS | Select-Object Manufacturer, SMBIOSBIOSVersion, ReleaseDate

# OS info
Get-CimInstance Win32_OperatingSystem | Select Caption, Version, BuildNumber

# Check if virtualization is enabled
Get-CimInstance Win32_ComputerSystem | Select HypervisorPresent

# NICs
Get-NetAdapter | Select Name, InterfaceDescription, Status, LinkSpeed
