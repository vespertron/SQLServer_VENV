# configure_vm.ps1

# Define log function
function Log-And-Print {
    param([string]$message)
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    $logEntry = "$timestamp`t$message"
    Write-Host $message
    Add-Content -Path ".\logs\configure_vm.log" -Value $logEntry
}

# Log header
Log-And-Print "----- VM Configuration Script Started -----"

# Load config
$configPath = ".\config\vm_metadata.json"
if (-Not (Test-Path $configPath)) {
    Log-And-Print "ERROR: Configuration file not found at $configPath"
    exit 1
}

Log-And-Print "Loading configuration from $configPath"
$config = Get-Content $configPath | ConvertFrom-Json

# Extract config values
$hostname     = $config.ComputerName
$ip           = $config.Network.IPAddress
$subnet       = $config.Network.Subnet
$gateway      = $config.Network.Gateway
$dns          = $config.Network.DNS
$roles        = $config.Roles
$environment  = $config.Environment

# Rename computer
Log-And-
