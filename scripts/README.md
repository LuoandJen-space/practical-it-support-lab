# PowerShell Diagnostic Scripts

## Purpose

This directory contains PowerShell tools developed for the Practical IT Support Lab.

The scripts support structured troubleshooting across Windows desktop systems, networking, Active Directory, and file access.

The initial scripts are designed to collect diagnostic information without intentionally changing system configuration.

## Script Index

| Script | Purpose | Intended Run Location | Planned Status |
|---|---|---|---|
| `Get-WorkstationHealth.ps1` | Collect basic Windows, service, and disk health information | Windows client | Planned |
| `Get-NetworkConfig.ps1` | Inspect network adapters, IPv4 configuration, gateways, and DNS servers | Windows client or server | Planned |
| `Test-DnsResolution.ps1` | Test hostname and DNS record resolution | Windows client or server | Planned |
| `Test-NetworkPath.ps1` | Check selected connectivity targets and TCP ports | Windows client or server | Planned |
| `Test-DomainControllerDiscovery.ps1` | Investigate domain controller discovery and related DNS records | Domain-joined Windows client | Planned |
| `Get-ADUserStatus.ps1` | Inspect selected Active Directory user account properties | Domain administration system | Planned |
| `Get-ADGroupMembership.ps1` | Inspect group membership for a specified user | Domain administration system | Planned |
| `Get-SharePermissions.ps1` | Inspect SMB share permissions and folder permissions | File server or authorised admin system | Planned |
| `Collect-TicketEvidence.ps1` | Gather selected diagnostic results into a support report | Windows client or authorised admin system | Planned |

## Script Documentation Standard

Each script will document:

- Purpose and intended use
- Supported environment and prerequisites
- Required permissions
- Exact command examples
- Expected output and interpretation
- Common errors and limitations
- Related lab and troubleshooting workflow
- Safety considerations

## Safe Usage

- Read the script before running it.
- Use only on systems you own or are authorised to support.
- Prefer read-only diagnostic operations.
- Confirm the target computer, user, domain, or resource before running a command.
- Do not include passwords, tokens, recovery keys, or unnecessary personal data in reports.
- Review generated output before publishing it.

Some diagnostic commands require elevated permissions or Active Directory tools. The requirements will be documented in each script.

## Development Status

All scripts are planned until their code, usage instructions, and expected results have been reviewed and tested.

A script will be marked as verified only after it has been tested in the documented lab environment.
