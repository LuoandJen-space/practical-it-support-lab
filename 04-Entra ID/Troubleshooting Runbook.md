# Microsoft Entra ID – Troubleshooting Runbook

## 1. Purpose

This runbook provides a structured approach to investigating common Microsoft Entra ID identity and access issues.

It is designed for IT Support and Systems Support scenarios involving:

- Microsoft 365 sign-in failures
- Password authentication issues
- Multi-Factor Authentication (MFA) failures
- Conditional Access restrictions
- Application access problems
- User and group membership issues
- Administrative permission problems

The objective is to identify the failure stage, collect relevant evidence, take approved actions, and escalate issues when necessary.

## 2. Troubleshooting Principles

Before investigating an identity or access issue, follow these principles:

1. Verify the user's identity using the organisation's approved procedure.
2. Confirm the exact problem and affected application.
3. Identify when the issue started and whether it affects one or multiple users.
4. Use available sign-in logs and error details as evidence.
5. Distinguish authentication failures from authorization failures.
6. Do not change security policies or administrative permissions without approval.
7. Record investigation findings and actions in the ticket.

### 2.1 Identity and Access Troubleshooting Model

Use the following model to organise the investigation:

| Stage | Investigation Area | Key Question |
|---|---|---|
| 1 | Identity | Is this the correct user account? |
| 2 | Account Status | Is the account enabled and usable? |
| 3 | Authentication | Did the user successfully authenticate? |
| 4 | MFA | Was the required verification completed? |
| 5 | Conditional Access | Did the sign-in satisfy applicable policies? |
| 6 | Application Access | Is the user assigned and authorised to access the application? |
| 7 | Administrative Permissions | Does the administrator have the required role to perform the requested action? |

This is a diagnostic framework, not a mandatory sequence. Use the evidence to determine which area requires investigation.

---

## 3. Initial User Assessment

### Step 1 – Understand the Reported Problem

**User communication:**

> Could you describe what happens when you try to sign in?

> Which application are you trying to access?

> When did the issue first occur?

> Are you the only user experiencing this issue?

**Actions:**

Collect the following information:

- User's name and account identifier
- Application name
- Exact error message
- Date and time of the failed attempt
- Device and browser used
- Whether the issue is consistent or intermittent
- Whether other users are affected

**Why this matters:**

Different applications and failure stages can produce similar user-facing symptoms.

For example, a user reporting that they cannot access Microsoft 365 may be experiencing:

- Incorrect credentials
- MFA failure
- Conditional Access restrictions
- Application-specific authorization problems

**Expected outcome:**

A clear problem description and sufficient information to begin the investigation.

---

## 4. Check User Identity and Account Status

### Step 2 – Locate the User Account

**Actions:**

1. Open the Microsoft Entra admin center.
2. Navigate to **Identity > Users > All users**.
3. Search for the user using their UPN or another reliable identifier.
4. Open the user profile.
5. Review relevant account information.

**Check:**

- Display name
- User Principal Name (UPN)
- Account enabled or disabled status
- User type (Member or Guest)
- Whether the account is cloud-only or synchronized, where visible

**Why this matters:**

The issue may be related to an incorrect account, a disabled account, or an account lifecycle change.

**Interpretation:**

| Finding | Possible Meaning | Next Step |
|---|---|---|
| User account not found | Incorrect identifier, wrong tenant, or account not provisioned | Verify the account details and tenant |
| Account disabled | Sign-in may be blocked because the account is disabled | Confirm the reason and follow the approved account process |
| Account enabled | The account is not disabled | Continue investigating authentication and access |
| Guest account | The user is accessing the organisation as an external identity | Check guest access and invitation status where relevant |

**Important:**

Do not enable a disabled account simply to test whether sign-in works. Confirm the reason for the disabled status and obtain the required approval.

---

## 5. Investigate Sign-in Logs

### Step 3 – Locate the Relevant Sign-in Event

**Actions:**

1. Open the Microsoft Entra admin center.
2. Navigate to **Identity > Monitoring & health > Sign-in logs**.
3. Filter by the affected user.
4. Select the relevant date and time range.
5. Identify the sign-in event associated with the reported application.
6. Open the event and review its details.

The exact navigation labels may vary with portal updates and available permissions.

**User communication:**

> I'll review the sign-in logs to identify where the authentication process is failing.

### 5.1 Information to Review

| Field | What to Check |
|---|---|
| User | Is this the correct account? |
| Application | Does it match the application reported by the user? |
| Date and Time | Does the event match the reported incident? |
| Status | Was the sign-in successful or unsuccessful? |
| Error Code | Is an error associated with the event? |
| Failure Reason | What reason does Microsoft Entra provide? |
| Additional Details | Is there more information about the failure? |
| Authentication Details | Which authentication steps succeeded or failed? |
| Conditional Access | Were policies applied, satisfied, or blocking access? |
| IP Address | Is the source IP relevant to the reported sign-in? |
| Device Information | Is the device information consistent with the user's report? |
| Correlation ID | Can the event be referenced during escalation? |

### 5.2 Identify the Failure Stage

Use the sign-in evidence to determine which part of the process requires investigation.

| Evidence | Investigation Area |
|---|---|
| Password authentication failed | Credentials and account authentication |
| Password succeeded, MFA failed | MFA method and verification |
| Authentication succeeded, Conditional Access failed | Conditional Access policy |
| Sign-in succeeded, application access denied | Application assignment or authorization |
| No matching event found | Confirm time range, tenant, application and sign-in type |

**Important:**

Do not assume that the absence of a matching event proves that no sign-in attempt occurred. Check the correct tenant, time range, log category and available log retention.

A sign-in error code should not be interpreted by itself. Review the failure reason, additional details and authentication steps.

---

## 6. Troubleshoot Password Authentication

### Scenario: User Cannot Sign In

**Reported problem:**

The user enters their username and password but cannot sign in.

### Step 1 – Confirm the Account

**User communication:**

> Could you confirm the username or email address you are using to sign in?

**Actions:**

- Verify the user's UPN.
- Confirm the correct tenant and sign-in page.
- Check whether the account is enabled.

### Step 2 – Review the Sign-in Event

**Actions:**

- Locate the relevant sign-in event.
- Review the status and failure reason.
- Check authentication details.

**Interpretation:**

If the password authentication step failed, investigate the reported authentication failure rather than immediately changing the user's account.

Possible areas include:

- Incorrect username
- Incorrect password
- Account restrictions
- Authentication configuration
- Other identity-related conditions

### Step 3 – Take Approved Action

Depending on the evidence and organisation policy:

- Guide the user through the approved password recovery process.
- Verify account status.
- Refer synchronized account issues to the team responsible for the on-premises identity source.
- Escalate unresolved authentication problems.

**Security consideration:**

Never ask the user to disclose their password. Do not record passwords in tickets.

---

## 7. Troubleshoot MFA

### Scenario: Password Accepted but MFA Fails

**Reported problem:**

The user enters the correct password but cannot complete MFA.

### Step 1 – Confirm the MFA Experience

**User communication:**

> Could you confirm whether you've received an MFA notification on your phone?

> Are you using the Microsoft Authenticator app, SMS, or another authentication method?

> Do you see an error message when you try to complete the verification?

**Actions:**

Establish:

- Whether the notification was received
- Which authentication method was used
- Whether the user changed phones
- Whether the user can access their registered authentication method
- Whether an error appeared during verification

### Step 2 – Review Authentication Details

**Actions:**

1. Open the relevant sign-in event.
2. Review the Authentication Details tab.
3. Identify which authentication step failed.
4. Review the failure reason and additional details.

**Interpretation:**

| Finding | Possible Cause | Next Step |
|---|---|---|
| Notification not received | Device, network, app or notification issue | Check the registered method and approved troubleshooting guidance |
| User changed phones | New device may not have the required method registered | Follow the approved authentication method recovery process |
| User cannot access registered method | Authentication method unavailable | Follow the approved identity verification and recovery process |
| User did not complete MFA | Verification was not completed | Confirm what happened during the challenge |
| User receives an unexpected MFA request | Possible suspicious sign-in attempt | Do not approve; follow the security reporting process |

### Step 3 – Apply Approved Recovery

If the user cannot access their registered authentication method:

- Verify the user's identity.
- Check the organisation's MFA recovery procedure.
- Use only authorised administrative actions.
- Escalate if the required permissions or approval are unavailable.

**Important security rule:**

If the user did not initiate the sign-in, they must not approve the MFA request.

**Service Desk response:**

> If you did not initiate this sign-in, please do not approve the notification. Reject the request and report it to us so we can follow the security incident process.

---

## 8. Troubleshoot Conditional Access

### Scenario: User Completes Authentication but Access Is Blocked

**Reported problem:**

The user enters their password and completes MFA but still cannot access the application.

### Step 1 – Confirm Authentication Results

**Actions:**

- Open the relevant sign-in event.
- Review authentication details.
- Confirm whether the required authentication steps succeeded.

### Step 2 – Review Conditional Access Results

**Actions:**

1. Open the sign-in event.
2. Review the Conditional Access tab.
3. Identify policies applied to the sign-in.
4. Review each relevant policy result.
5. Check the failure reason and grant controls.

**Possible policy requirements:**

- Require MFA
- Require a compliant device
- Require an approved authentication strength
- Block access under specified conditions

### Step 3 – Identify the Policy Requirement

| Finding | Possible Meaning | Next Step |
|---|---|---|
| MFA requirement not satisfied | Required authentication was not completed | Investigate authentication details |
| Device compliance requirement not satisfied | Device may not meet the organisation's compliance requirement | Refer to the device management process |
| Access blocked | A policy explicitly denied the sign-in | Review the policy result and escalate if needed |
| No relevant policy failure | The issue may be elsewhere | Investigate application assignment and authorization |

**Important:**

A Conditional Access result must be interpreted in the context of the actual policy and sign-in event.

Do not disable a Conditional Access policy or create an exception simply to make a user's sign-in succeed.

### Step 4 – Escalation

If the policy requires administrative review:

- Record the policy name and result.
- Record the relevant sign-in event and Correlation ID.
- Explain which requirement was not satisfied.
- Escalate to the authorised Entra or Security Administrator.

**Service Desk communication:**

> Your sign-in was authenticated, but an access policy appears to be preventing access. I'll review the policy result and escalate this to the appropriate team if an administrative change is required.

---

## 9. Troubleshoot Application Access

### Scenario: User Can Sign In but Receives Access Denied

**Reported problem:**

The user successfully signs in and completes MFA but cannot access a specific application.

### Step 1 – Confirm the Application

**User communication:**

> Could you confirm the name of the application and the exact error message you receive?

> Are other users in your department able to access the application?

### Step 2 – Confirm Sign-in Status

**Actions:**

- Locate the relevant sign-in event.
- Confirm whether authentication succeeded.
- Review Conditional Access results.
- Confirm that the event relates to the affected application.

**Interpretation:**

If authentication succeeded and no relevant Conditional Access failure is identified, investigate application access and authorization.

### Step 3 – Check Application Assignment

**Actions:**

1. Open **Identity > Applications > Enterprise applications**.
2. Search for the affected application.
3. Review the application's properties.
4. Check whether user assignment is required.
5. If applicable, verify whether the user or their group is assigned.

**Possible findings:**

- The user is not assigned to the application.
- The user belongs to a group that is not assigned.
- The application requires an additional access approval.
- Application assignment is already correct.

### Step 4 – Check Group Membership

**Actions:**

- Open the user's profile.
- Review relevant group memberships.
- Confirm the required access group.
- Check whether group-based assignment is configured for the application.

**Important:**

Being a member of a group does not automatically grant access to every application. The group must be connected to the relevant access configuration.

### Step 5 – Consider Application-Specific Authorization

Some applications manage their own permissions separately from Microsoft Entra ID.

If the user is correctly assigned but still receives Access Denied:

- Check whether the application has its own roles or permissions.
- Confirm whether the user has the required application-level access.
- Refer the issue to the application owner when necessary.

**Service Desk communication:**

> Your sign-in was successful. I'll check whether your account has been assigned to the application and whether any additional application permissions are required.

---

## 10. Troubleshoot Administrative Permission Issues

### Scenario: Administrator Cannot Perform a Management Task

**Reported problem:**

An administrator can access the Microsoft Entra admin center but cannot perform a task such as resetting a password or managing groups.

### Step 1 – Identify the Requested Action

**User communication:**

> Could you confirm which administrative task you are trying to perform and what error message you receive?

### Step 2 – Check Administrative Role

**Actions:**

1. Identify the administrator's account.
2. Review assigned Microsoft Entra roles.
3. Check whether the relevant role is active.
4. Review the role's scope and applicable restrictions.

### Step 3 – Compare the Role with the Requested Task

| Situation | Investigation |
|---|---|
| No relevant role assigned | Check whether the user requires an administrative role |
| Role is eligible but not active | Check the approved role activation process |
| Role is active but action is denied | Review role permissions, scope and restrictions |
| Role appears sufficient | Investigate other applicable access restrictions |

**Important:**

Access to the Entra admin center does not mean the user has permission to perform every administrative action.

### Step 4 – Follow Least Privilege

If additional permissions are required:

- Confirm the business justification.
- Obtain the appropriate approval.
- Request the minimum required role.
- Use eligible or time-limited access where supported and appropriate.

Do not assign Global Administrator simply to resolve an isolated permission issue.

---

## 11. Documentation and Ticket Updates

Every investigation should include clear and factual ticket notes.

### 11.1 Minimum Ticket Information

Record:

- User and affected application
- Reported problem
- Date and time of the issue
- Error message
- Relevant sign-in log findings
- Authentication result
- MFA result, where relevant
- Conditional Access result, where relevant
- Application assignment and permission findings
- Actions taken
- Current status
- Escalation details, if applicable

### 11.2 Example Ticket Notes

**Issue:**

User cannot access a department application.

**Investigation:**

- Confirmed the user's account is enabled.
- Reviewed the relevant sign-in event.
- Confirmed authentication and MFA succeeded.
- Reviewed Conditional Access results.
- Checked application assignment and relevant group membership.

**Findings:**

The user successfully authenticated. Further investigation is required into application-level authorization.

**Action:**

Referred the issue to the application owner for permission verification.

**Status:**

Pending application owner investigation.

**Important:**

Only record checks and actions that were actually completed. Do not state that a setting was verified if it was not inspected.

---

## 12. Escalation Guidelines

Escalate when:

- The issue requires permissions beyond the Service Desk role.
- A Conditional Access policy change is required.
- MFA recovery requires an authorised administrator.
- A synchronized identity issue requires on-premises AD investigation.
- An application owner must review application-specific permissions.
- Suspicious sign-in activity or unexpected MFA requests are reported.
- The issue affects multiple users or appears to be a wider service incident.

### 12.1 Escalation Information

Provide:

- A concise problem summary
- Affected user and application
- Date and time of the incident
- Relevant sign-in log details
- Error code and failure reason, if available
- Correlation ID
- Authentication and Conditional Access results
- Checks already completed
- Reason for escalation

Do not send passwords, authentication codes, or unnecessary personal information.

---

## 13. Troubleshooting Quick Reference

| Reported Problem | First Investigation Area | Evidence to Review |
|---|---|---|
| Cannot sign in | Identity and authentication | Account status, sign-in status, failure reason |
| Password accepted but MFA fails | MFA | Authentication Details, registered methods, failure reason |
| MFA succeeds but access is blocked | Conditional Access | Conditional Access tab and policy results |
| Can sign in but cannot open an application | Application access | Sign-in logs, application assignment, group membership |
| Can open admin center but cannot manage users | Administrative permissions | Assigned roles, active status, scope |
| Unexpected MFA notification | Security investigation | User confirmation and relevant sign-in activity |

---

## 14. Key Service Desk Communication Phrases

### Confirming the Issue

- "Could you describe what happens when you try to sign in?"
- "Which application are you trying to access?"
- "When did the issue first occur?"

### Investigating

- "I'll check your account status and review the sign-in logs."
- "I'll investigate which stage of the authentication process is failing."
- "Could you confirm whether you've received the MFA notification?"

### Explaining the Result

- "Your authentication was successful, but access to the application appears to be restricted."
- "The sign-in logs indicate that the MFA verification was not completed."
- "The access policy appears to be preventing the sign-in."

### Escalating

- "I'll escalate this to the appropriate administrator for further investigation."
- "The issue requires additional permission checks from the application owner."
- "I've recorded the investigation findings and will update the ticket."

---

## 15. Final Troubleshooting Checklist

Before closing or escalating an identity and access ticket, confirm:

- [ ] The correct user account was identified.
- [ ] The reported application and problem were confirmed.
- [ ] The relevant sign-in event was located, where available.
- [ ] The failure stage was identified or documented as unknown.
- [ ] Authentication and MFA results were reviewed, where relevant.
- [ ] Conditional Access results were reviewed, where relevant.
- [ ] Application assignment and authorization were considered, where relevant.
- [ ] Only approved actions were performed.
- [ ] Investigation findings were recorded accurately.
- [ ] The ticket was resolved or escalated to the appropriate team.

---

## 16. Official Microsoft Documentation

- [Microsoft Entra Sign-in Logs](https://learn.microsoft.com/en-us/entra/identity/monitoring-health/concept-sign-ins)
- [Troubleshoot Sign-in Problems](https://learn.microsoft.com/en-us/entra/identity/monitoring-health/howto-troubleshoot-sign-in-errors)
- [Conditional Access Overview](https://learn.microsoft.com/en-us/entra/identity/conditional-access/overview)
- [Microsoft Entra MFA](https://learn.microsoft.com/en-us/entra/identity/authentication/concept-mfa-howitworks)
- [Microsoft Entra Role-Based Access Control](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/concept-understand-roles)
- [Enterprise Applications](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/what-is-application-management)

---

*Document purpose: Practical troubleshooting reference for Microsoft Entra ID identity, authentication, and application access issues. Follow the organisation's security policies, permissions and escalation procedures when performing administrative actions.*
