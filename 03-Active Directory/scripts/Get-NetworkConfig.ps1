# Get-NetworkConfig.ps1
# Purpose: Collect basic network configuration for IT Support troubleshooting.
# Scope: Read-only diagnostics. This script does not intentionally change settings.

Write-Output "=== Network Adapter Status ==="

Get-NetAdapter |
    Select-Object Name, InterfaceDescription, Status, LinkSpeed |
    Format-Table -AutoSize

Write-Output "`n=== IPv4 Configuration ==="

Get-NetIPConfiguration |
    Select-Object InterfaceAlias, IPv4Address, IPv4DefaultGateway, DNSServer |
    Format-List

Write-Output "`n=== DNS Server Configuration ==="

Get-DnsClientServerAddress -AddressFamily IPv4 |
    Select-Object InterfaceAlias, ServerAddresses |
    Format-Table -AutoSize
