# 03 — Outlook Troubleshooting

## 1. Overview

This document provides a structured troubleshooting procedure for common Microsoft Outlook issues in a Microsoft 365 environment.

The focus is on identifying whether an issue is related to the Outlook client, user account, network connectivity, Exchange Online, or Microsoft 365 service availability.

### Objectives

- Understand the relationship between Outlook Desktop, Outlook on the Web, and Exchange Online.
- Identify common Outlook connection states.
- Troubleshoot email sending and receiving failures.
- Use Outlook Safe Mode to investigate add-in issues.
- Understand when to investigate an Outlook profile or OST file.
- Follow a structured troubleshooting and escalation process.

---

## 2. Understanding the Outlook Environment

| Component | Description |
|---|---|
| Outlook Desktop | An email client installed on a user's computer |
| Outlook on the Web (OWA) | A browser-based interface for accessing the mailbox |
| Exchange Online | Microsoft's cloud-based email and calendaring service |
| Outlook Profile | Stores account and connection configuration used by Outlook |
| OST File | A local cached copy of mailbox data used by Outlook |
| PST File | A local Outlook data file that may store email and other Outlook items |
| Add-ins | Extensions that add functionality to Outlook |

### Important distinction

Outlook is a client application. Exchange Online is the cloud service that hosts the mailbox.

A problem with Outlook Desktop does not automatically mean that Exchange Online is unavailable.

Comparing Outlook Desktop with Outlook on the Web helps isolate client-side and service-side issues.

---

## 3. Outlook Connection Status

In Classic Outlook, check the connection status displayed in the Outlook status bar.

Common statuses include:

| Status | Meaning | Initial investigation |
|---|---|---|
| Connected | Outlook is connected to the mail service | Check the specific function that is failing |
| Disconnected | Outlook is not currently connected | Check network and connection settings |
| Working Offline | Outlook is configured to work offline | Check the Work Offline setting |
| Trying to connect | Outlook is attempting to establish a connection | Investigate network, authentication, client and service availability |

### Important notes

- Disconnected does not necessarily mean Exchange Online is unavailable.
- Working Offline is different from Disconnected.
- Connected does not guarantee that every email operation is successful.
- Always compare the user's experience with Outlook on the Web when possible.

---

![virtu switch config check](screenshot/outlook.png)

## 4. Standard Troubleshooting Procedure

Use the following process before applying changes.

### Step 1 — Identify the issue

Ask the user:

- What exactly is not working?
- When did the issue first occur?
- Is the problem intermittent or continuous?
- Is there an error message?
- Can the user access other Microsoft 365 services?

### Step 2 — Determine the scope

Establish whether the issue affects:

- One user or multiple users.
- One device or multiple devices.
- Outlook Desktop only or Outlook Desktop and Web.
- Sending, receiving, or both.

### Step 3 — Check Microsoft 365 service availability

Check Microsoft 365 Service Health if:

- Multiple users report the same issue.
- Outlook and Outlook on the Web are both affected.
- There are signs of an Exchange Online service incident.

Do not assume that every Outlook issue is a Microsoft service outage.

### Step 4 — Compare Outlook Desktop and Outlook on the Web

Ask the user to access their mailbox through Outlook on the Web.

| Result | Possible direction |
|---|---|
| Web works, Desktop fails | Investigate the local Outlook client |
| Web and Desktop both fail | Investigate account, mailbox, network or service availability |
| Both work, but one function fails | Investigate the specific email operation and relevant configuration |

These results help narrow the investigation but do not independently confirm the root cause.

### Step 5 — Investigate the relevant component

Depending on the symptoms, investigate:

- Outlook connection status.
- Work Offline setting.
- Network connectivity.
- Outlook add-ins.
- Outlook profile.
- Mailbox and account configuration.
- Exchange Online Service Health.
- Message Trace, when investigating email delivery.

### Step 6 — Verify and document

After applying an authorised fix:

1. Ask the user to repeat the original action.
2. Confirm that the expected result is achieved.
3. Record the troubleshooting steps and results.
4. Document the confirmed root cause, if known.
5. Escalate unresolved issues.

---

## 5. Common Outlook Troubleshooting Scenarios

### Scenario 1 — Outlook Cannot Open

**User report:**

> Outlook does not open when I click the application.

**Possible causes:**

- Outlook process is unresponsive.
- Add-in conflict.
- Outlook profile issue.
- Office application problem.
- Local device issue.

**Troubleshooting steps:**

1. Confirm whether Outlook is already running in the background.
2. Check Task Manager for an unresponsive Outlook process.
3. Try opening Outlook in Safe Mode:

   `outlook.exe /safe`

4. If Outlook opens in Safe Mode, investigate installed add-ins.
5. If Outlook still fails, collect the error message and investigate the Outlook profile or Office installation.
6. Escalate if the issue remains unresolved or requires administrative changes.

**Verification:**

Confirm that Outlook opens normally and the mailbox is accessible.

---

### Scenario 2 — Outlook Desktop Cannot Connect

**User report:**

> Outlook keeps showing "Trying to connect".

**Possible causes:**

- Network connectivity issue.
- Work Offline enabled.
- Authentication issue.
- Outlook add-in conflict.
- Outlook profile issue.
- Exchange Online service incident.

**Troubleshooting steps:**

1. Confirm that the device has network connectivity.
2. Check Outlook's connection status.
3. Confirm that Work Offline is not enabled.
4. Test the mailbox through Outlook on the Web.
5. If Web works, investigate the local Outlook client.
6. Start Outlook in Safe Mode to investigate add-in conflicts.
7. If the issue affects multiple users, check Microsoft 365 Service Health.

**Verification:**

Confirm that Outlook displays Connected and the user can access their mailbox.

---

### Scenario 3 — User Can Receive Emails but Cannot Send

**User report:**

> I can receive emails, but I cannot send emails.

**Possible causes:**

- Email is stuck in the Outbox.
- Outlook is offline or disconnected.
- Incorrect recipient address.
- Attachment size or message restrictions.
- Mail flow or transport rule issue.
- Exchange Online service issue.

**Troubleshooting steps:**

1. Check whether Outlook is connected.
2. Confirm that Work Offline is not enabled.
3. Check whether messages are stuck in the Outbox.
4. Review any error message or Non-Delivery Report (NDR).
5. Verify the recipient address and attachment size.
6. Test sending an email through Outlook on the Web.
7. If the message was submitted but delivery failed, investigate Exchange Online Message Trace.
8. Escalate unresolved mail flow or organisation-level issues to the Exchange administrator.

**Useful diagnostic information:**

- Sender address.
- Recipient address.
- Approximate sending time.
- Email subject.
- Error message or NDR.
- Whether the message appears in Sent Items or remains in Outbox.

**Verification:**

Send a test email and confirm that the recipient receives it.

---

### Scenario 4 — User Cannot See New Emails

**User report:**

> I am not receiving new emails in Outlook.

**Possible causes:**

- Outlook synchronisation issue.
- Incorrect mailbox or folder.
- Inbox rules moving messages.
- Junk Email filtering.
- Exchange Online delivery issue.
- Outlook client issue.

**Troubleshooting steps:**

1. Confirm that the user is checking the correct mailbox.
2. Check whether the emails appear in Outlook on the Web.
3. Check Junk Email and other folders.
4. Review Inbox Rules.
5. Check Outlook connection and synchronisation status.
6. If the message is missing from the mailbox, investigate email delivery using Message Trace.
7. Escalate if the issue involves Exchange Online or mailbox configuration.

**Verification:**

Confirm that new emails appear in the correct mailbox and folder.

---

## 6. Outlook Safe Mode and Add-in Troubleshooting

Safe Mode starts Outlook with a limited set of features and disables add-ins.

Command:

`outlook.exe /safe`

### Diagnostic process

1. Close Outlook.
2. Open the Windows Run dialog.
3. Enter `outlook.exe /safe`.
4. Check whether Outlook opens successfully.
5. If Outlook works in Safe Mode, investigate add-ins.
6. Disable suspected add-ins one at a time, subject to user and organisational permissions.
7. Restart Outlook normally and test again.

### Interpretation

| Result | Possible conclusion |
|---|---|
| Outlook works in Safe Mode | An add-in or another normal-startup component may be involved |
| Outlook still fails | Investigate other causes, such as the profile, application or device |

Safe Mode is a diagnostic step, not proof that an add-in is the root cause.

---

## 7. Outlook Profile, OST and PST

### Outlook Profile

An Outlook profile contains account and connection configuration used by Outlook.

A damaged profile may cause connection or application problems.

Creating a new profile can help determine whether the issue is related to the existing profile.

### OST File

An OST file is a local cached copy of mailbox data.

For an Exchange Online mailbox, the cloud mailbox is generally the primary mailbox copy, while Outlook uses the OST for local caching.

Before removing or rebuilding an OST file:

- Confirm that the mailbox is accessible through Outlook on the Web.
- Check that important changes have synchronised.
- Protect any unsynchronised local data.
- Follow organisational procedures and obtain authorisation.

### PST File

A PST file may contain locally stored email or other Outlook data.

Do not assume that all Outlook data is stored in Exchange Online. Check whether the user has local PST files before profile or data-file changes.

### Important safety principle

Do not immediately delete OST/PST files or recreate Outlook profiles without first investigating the issue and checking for unsynchronised or locally stored data.

---

## 8. Outlook Troubleshooting Decision Tree

```text
User reports an Outlook issue
          |
          v
Identify the symptom
          |
          v
Is the issue affecting one or multiple users?
          |
     +----+----------+
     |               |
   One user      Multiple users
     |               |
     v               v
Check local      Check Microsoft 365
client and       Service Health and
account          organisation impact
     |
     v
Can the user access Outlook on the Web?
     |
 +---+----------------+
 |                    |
Yes                  No
 |                    |
 v                    v
Investigate     Investigate account,
Outlook         mailbox, network and
Desktop         Exchange Online
 |
 v
Check connection status
and Work Offline
 |
 v
Test Safe Mode and add-ins
 |
 v
Investigate profile if necessary
 |
 v
Apply an authorised fix
 |
 v
Verify with the user
 |
 v
Document or escalate
```

---

## 9. Escalation Criteria

Escalate the incident when:

- Multiple users are affected by the same issue.
- Exchange Online Service Health reports a relevant incident.
- Message Trace indicates a mail flow problem that requires administrator investigation.
- The issue involves organisation-level mail flow rules or configuration.
- Authentication or security policies require administrator access.
- Profile or data-file recovery could risk unsynchronised user data.
- The issue remains unresolved after the authorised troubleshooting steps.

### Information to include when escalating

- Affected user and mailbox.
- Description of the issue.
- Date and time the issue started.
- Error messages and screenshots, with sensitive information removed.
- Whether Outlook on the Web works.
- Connection status.
- Troubleshooting steps performed.
- Results of each step.
- Business impact.

---

## 10. Incident Documentation Example

**Example scenario:** A user can receive emails but cannot send emails.

| Field | Example |
|---|---|
| Issue | User cannot send emails through Outlook Desktop |
| Impact | One user |
| Initial observation | Incoming emails work |
| Checks performed | Connection status, Work Offline, Outbox, error messages |
| Additional test | Outlook on the Web |
| Root cause | Not confirmed until investigation is complete |
| Resolution | Record the confirmed action taken |
| Verification | User successfully sends a test email |

Do not mark an incident as resolved until the user-facing function has been tested successfully.

---

## 11. Key Technical Knowledge

| Concept | What I should understand |
|---|---|
| Outlook Desktop | Local email client |
| Outlook on the Web | Browser-based mailbox access |
| Exchange Online | Cloud email service |
| Connected | Outlook has an active connection |
| Disconnected | Outlook is not connected |
| Working Offline | Outlook is configured to work offline |
| Safe Mode | Helps investigate add-in and startup issues |
| OST | Local cached mailbox data |
| PST | Local Outlook data file |
| Message Trace | Investigates Exchange Online email delivery |

---

## 12. Learning Evidence and Limitations

This document represents structured learning and troubleshooting practice for Microsoft 365 support scenarios.

Practical checks should be labelled according to how they were performed:

- **Completed Lab:** A check was actually performed and the result was recorded.
- **Simulated Scenario:** A scenario was analysed without access to a live Microsoft 365 tenant.
- **Knowledge Review:** Technical concepts and troubleshooting procedures were studied.

Do not describe simulated troubleshooting as production support experience.

---

## References

- Microsoft Learn — [Outlook troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/exchange/outlook-issues/outlook-connection-issues)
- Microsoft Learn — [Exchange Online troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/exchange/)
- Microsoft Learn — [Email delivery issues](https://learn.microsoft.com/en-us/troubleshoot/exchange/email-delivery/email-delivery-issues)
