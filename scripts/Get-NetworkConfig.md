# Get-NetworkConfig.ps1 — Usage Guide

## 1. Purpose

This script collects basic network adapter and IP configuration information to support Windows networking troubleshooting.

It is intended as an initial diagnostic step, not as proof that the entire network is working correctly.

## 2. Environment

- **Primary system:** CLIENT01
- **Operating system:** Windows 11 Pro
- **Shell:** Windows PowerShell
- **Network:** The authorised AD-Lab-Private practice network

The script may also be useful on other supported Windows systems with the required networking cmdlets.

## 3. Prerequisites

- PowerShell with the required NetTCPIP and NetAdapter cmdlets available
- Access to the script file
- Permission to run scripts under the current PowerShell execution policy

The script is designed for read-only diagnostics and does not intentionally modify network configuration.

## 4. How to Run

1. Obtain the script from this repository.
2. Review the script contents before running it.
3. Open PowerShell on CLIENT01.
4. Change to the directory containing the downloaded script.
5. Run:

   `.\Get-NetworkConfig.ps1`

If script execution is blocked, review the actual error and the current execution policy. Do not disable security controls globally just to run this script.

## 5. What the Output Shows

### Network Adapter Status

Displays adapter names, descriptions, connection status, and link speed.

An adapter status of `Up` indicates that the adapter is operational at the link level. It does not by itself prove that DNS, routing, or access to a remote service is working.

### IPv4 Configuration

Displays interface aliases, IPv4 addresses, default gateways, and DNS server information.

Compare the output with the documented network design for the lab.

### DNS Server Configuration

Lists DNS servers configured for IPv4 DNS clients on the system.

For the planned lab, CLIENT01 should use the lab domain controller's DNS server address when configured for domain operations.

## 6. Lab Validation Checklist

- [ ] The script runs without unexpected errors.
- [ ] The expected network adapter is identified.
- [ ] The IPv4 address matches the current lab configuration.
- [ ] The DNS server address matches the current lab design.
- [ ] The output is reviewed for unexpected adapters or configurations.
- [ ] Any evidence is checked for sensitive information before publication.

## 7. Troubleshooting

**The script cannot be found**

Confirm that the current directory contains the script and that the filename is correct.

**A command is not recognised**

Confirm that the command is available on the operating system and in the current PowerShell session.

**The output includes multiple adapters**

Identify which adapter is connected to the practice network. Virtual, disconnected, and other adapters may also appear.

**The displayed IP or DNS server is unexpected**

Compare the result with the lab network configuration and investigate the relevant adapter before making changes.

## 8. Limitations

- This script reports configuration; it does not verify end-to-end connectivity.
- It does not prove that a DNS server can resolve a particular name.
- It does not verify domain controller discovery or file-share access.
- Results must be interpreted in the context of the affected system and reported symptom.

## 9. Evidence Record

Record the test date, operating system, observed adapter, relevant configuration, and any unexpected errors.

Do not publish passwords, tokens, personal information, or unrelated network details.

## 10. Related Resources

- [Lab Environment Setup](../01-build-the-lab/README.md)
- [PowerShell Scripts Index](README.md)

## 11. Test Status

**Status:** Tested in the documented lab environment.

### Test Environment

- **System:** CLIENT01
- **Operating system:** Windows 11 Pro
- **Shell:** Windows PowerShell
- **Script path:** `C:\github\Get-NetworkConfig.ps1`
- **Initial execution policy:** `Restricted`
- **Test execution policy:** `RemoteSigned`, applied to the current PowerShell process only

### Observed Results

- The script executed successfully without unexpected errors.
- The network adapter `Ethernet` was identified with status `Up`.
- The observed IPv4 address was `192.168.50.20`.
- No default gateway was configured on the lab interface.
- The configured IPv4 DNS server was `192.168.50.10`.
- All three output sections were displayed.

### Notes and Limitations

The DNS information displayed by `Get-NetIPConfiguration` included object details rather than directly presenting the DNS server IP address. The separate DNS configuration section displayed the server address clearly.

The successful run confirms that the script executed in this lab environment. It does not establish compatibility with every supported Windows configuration or verify end-to-end network connectivity.

### Security Note

The execution policy was changed only for the current PowerShell process during testing. No persistent execution policy change was made.

### Follow-up Improvement

Consider improving the IPv4 configuration output so that DNS server addresses are displayed directly and consistently.
