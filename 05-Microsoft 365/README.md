
# W7 – Microsoft 365

## Overview

This module covers the fundamentals of Microsoft 365 administration, licensing, Exchange Online, Outlook troubleshooting, OneDrive, SharePoint, and common Microsoft 365 support scenarios.

The goal is to develop practical knowledge and troubleshooting skills relevant to an IT Support / Service Desk role.

## Learning Objectives

By completing this module, I aimed to understand how to:

- Navigate the Microsoft 365 Admin Center.
- Manage users, groups, and licence assignments.
- Understand Microsoft 365 licences and service plans.
- Identify common Exchange Online mailbox concepts.
- Troubleshoot common Outlook issues.
- Understand OneDrive and SharePoint file sharing and synchronisation.
- Follow a structured troubleshooting process.
- Document technical findings in a professional support report.

## Learning Modules

| Day | Topic | Key Areas |
|---|---|---|
| W7D1 | Microsoft 365 Admin Center | Users, Licences, Groups, Service Health |
| W7D2 | Microsoft 365 Licensing | Product Licences, Service Plans, Licence Assignment |
| W7D3 | Outlook Troubleshooting | Email Sending Issues, Troubleshooting Workflow |
| W7D4 | Exchange Online | Mailboxes, Email Flow, Distribution Groups, Shared Mailboxes |
| W7D5 | OneDrive & SharePoint | File Sharing, Permissions, Synchronisation |
| W7D6 | Microsoft 365 Troubleshooting Project | Common Issues, Diagnostic Methods, Support Workflow |

## Practical Work

Practical exercises focused on understanding Microsoft 365 support workflows and performing local client-side diagnostics.

### Outlook Local Diagnostics

A hands-on troubleshooting exercise was conducted using a Windows 11 PC and Classic Outlook.

The investigation included:

- Checking Windows system information.
- Verifying whether the Outlook process was running.
- Checking DNS resolution.
- Testing TCP connectivity to Outlook over port 443.
- Reviewing Outlook Connection Status.
- Checking folder synchronisation status.
- Reviewing Send/Receive Progress.
- Investigating the Outbox and Sent Items.

**Important:** The Outlook test email remained in the Outbox and did not appear in Sent Items during the investigation. The root cause was not confirmed.

See:

`03-Outlook-Troubleshooting/01-Outlook-Local-Diagnostics/`

## Technical Environment

| Component | Environment |
|---|---|
| Operating System | Windows 11 Pro |
| OS Build | 26100 |
| Email Client | Classic Outlook |
| Additional Software | New Outlook package installed |
| Diagnostic Tools | PowerShell, Windows UI, Outlook |

## Skills Practised

### Microsoft 365 Administration
- User and group management concepts.
- Licence assignment and service plan concepts.
- Microsoft 365 Service Health awareness.

### Email Support
- Outlook client troubleshooting.
- Exchange Online mailbox concepts.
- DNS and network connectivity checks.
- Send/Receive and synchronisation checks.
- Outbox and Sent Items investigation.

### File Collaboration
- OneDrive synchronisation concepts.
- SharePoint permissions.
- File sharing and access troubleshooting.

### Service Desk Skills
- Gathering symptoms and technical evidence.
- Following a structured troubleshooting workflow.
- Distinguishing verified findings from assumptions.
- Recording unresolved issues accurately.
- Communicating diagnostic findings clearly.

## Lab Limitations

A dedicated Microsoft 365 test tenant was not available during this learning module.

Therefore:

- Microsoft 365 Admin Center and Exchange Online administration were studied as learning topics.
- Local Outlook diagnostics were performed on a real Windows PC.
- Tenant-level operations, such as creating users, changing licences, modifying Exchange Online mailbox settings, and administering SharePoint permissions, were not independently verified in a test tenant.

Local client-side connectivity tests should not be treated as proof that Exchange Online mailbox operations or recipient-side email delivery are working correctly.

## Repository Structure

```text
W7-Microsoft-365/
│
├── README.md
│
├── 01-Microsoft-365-Admin-Center/
│
├── 02-Licensing-and-Service-Plans/
│
├── 03-Outlook-Troubleshooting/
│
├── 04-Exchange-Online/
│
├── 05-OneDrive-SharePoint/
│
└── 06-Microsoft-365-Troubleshooting-Project/
```

## Learning Outcome

This module provided an introduction to Microsoft 365 support operations and common end-user issues.

The practical Outlook exercise helped develop a more structured approach to troubleshooting by separating:

1. Operating system and application checks.
2. DNS and network connectivity checks.
3. Outlook connection and synchronisation checks.
4. Email submission and delivery investigation.

Further hands-on practice with a Microsoft 365 test tenant would be required to demonstrate full tenant-level administration skills.
