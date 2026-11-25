
# 01 – Microsoft 365 Admin Center

## 1. Overview

Microsoft 365 Admin Center is the central web-based administration portal used by IT administrators to manage Microsoft 365 services and users within an organisation.

For IT Support and Service Desk roles, it is important to understand how to locate user accounts, check licence assignments, review groups, and monitor Microsoft 365 service health.

**Portal:** https://admin.microsoft.com/

## 2. Learning Objectives

After completing this section, I should be able to:

- Understand the main areas of Microsoft 365 Admin Center.
- Locate and review user accounts.
- Understand the purpose of licence management.
- Identify different types of groups.
- Check Microsoft 365 service health.
- Recognise common user access and service-related issues.
- Follow a basic troubleshooting workflow.

## 3. Main Areas of Microsoft 365 Admin Center

| Area | Purpose | Common IT Support Tasks |
|---|---|---|
| Users | Manage organisation user accounts | Find users, review account details |
| Teams & Groups | Manage groups and membership | Check group membership |
| Billing / Licences | Manage subscriptions and licences | Check licence availability and assignment |
| Health | Monitor Microsoft 365 services | Check service incidents and advisories |
| Reports | Review usage and service reports | Investigate usage-related questions |
| Settings | Configure organisation-level settings | Review relevant service settings |

*Note: The exact menu names and layout may vary depending on administrator permissions and Microsoft 365 portal updates.*

## 4. User Management

User management is one of the most common tasks in an IT Support environment.

### 4.1 Common User Account Information

When investigating a user-related issue, check:

- Display name
- Username / User Principal Name (UPN)
- Account status
- Assigned licences
- Group memberships
- Usage location

### 4.2 Common Service Desk Scenarios

| Scenario | Initial Checks |
|---|---|
| User cannot sign in | Check account status and sign-in details |
| User cannot access Outlook | Check licence and Exchange Online service plan |
| User cannot access Teams | Check licence and Teams service availability |
| New employee cannot access services | Check account creation, licence and group membership |
| User has lost access to a resource | Check relevant group membership and permissions |

### 4.3 Example Troubleshooting Workflow

**Scenario:** A user reports that they cannot access Microsoft 365 services.

1. Identify the affected user.
2. Confirm the correct username and account.
3. Check whether the account is enabled.
4. Review assigned product licences.
5. Check whether the required service plans are enabled.
6. Review relevant group memberships.
7. Check Microsoft 365 Service Health.
8. Record findings and escalate if necessary.

## 5. Licence Management

Microsoft 365 licences determine which services and applications a user can access.

Examples of services that may be included in a subscription:

- Exchange Online
- Microsoft Teams
- SharePoint Online
- OneDrive
- Microsoft 365 Apps

### Important Concepts

| Term | Explanation |
|---|---|
| User Account | The identity used to sign in |
| Product Licence | The subscription assigned to a user |
| Service Plan | An individual service included within a product licence |
| Licence Assignment | The process of assigning a product licence to a user |
| Usage Location | The country or region associated with a user for licensing purposes |

**Important:** Having a user account does not automatically mean that the user has access to every Microsoft 365 service.

A user may have a product licence assigned while a particular service plan is disabled.

See the separate licensing notes:

`02-Licensing-and-Service-Plans.md`

## 6. Groups

Groups help administrators manage users and access more efficiently.

Common group types include:

| Group Type | Purpose |
|---|---|
| Microsoft 365 Group | Supports collaboration across services such as Outlook and SharePoint |
| Security Group | Used to manage access to resources |
| Distribution List | Used to distribute email to multiple recipients |

### Common Support Scenarios

**Scenario 1: User cannot access a shared resource.**

Initial checks:

1. Confirm the user's identity.
2. Identify the resource they are trying to access.
3. Check the relevant group membership.
4. Verify whether the group grants the required access.
5. Escalate permission changes if outside the Service Desk role.

**Scenario 2: User is not receiving group emails.**

Initial checks:

1. Confirm the distribution list address.
2. Check whether the user is a member.
3. Confirm whether the sender used the correct address.
4. Check for relevant mail flow or delivery issues.

**Important:** The initial checks are not step by step is depends on what exactly issue are you experience. 

## 7. Service Health

Service Health helps administrators identify known Microsoft 365 service incidents and advisories.

It is particularly useful when multiple users report similar problems.

### What to Check

- Active incidents
- Service advisories
- Affected services
- Incident descriptions
- User impact
- Microsoft updates and resolution status

### Example Scenario

**Reported issue:** Multiple users cannot access Outlook.

A structured investigation:

1. Confirm whether the issue affects one user or multiple users.
2. Identify the affected service.
3. Check Microsoft 365 Service Health.
4. Look for incidents involving Exchange Online or Outlook.
5. Compare the reported symptoms with the incident description.
6. Communicate any confirmed service impact to users.
7. Monitor the incident until Microsoft provides an update.

## 8. Common Troubleshooting Scenarios

| Issue | Possible Area to Investigate |
|---|---|
| User cannot sign in | Account status, credentials, authentication |
| Outlook unavailable | Licence, Exchange Online, service health |
| Teams unavailable | Licence, Teams service plan, service health |
| User cannot access SharePoint | Group membership, permissions, service health |
| User cannot access OneDrive | Licence, account, service availability |
| Multiple users affected | Service Health, wider service incident |

These are initial investigation areas, not confirmed root causes. Further diagnostic Correlate are required before identifying the cause.

## 9. Service Desk Troubleshooting Workflow

```text
User reports an issue
        |
        v
Identify affected user
        |
        v
Determine scope
(Single user or multiple users?)
        |
        v
Check account status
        |
        v
Check licence and service plans
        |
        v
Check group membership
        |
        v
Check Microsoft 365 Service Health
        |
        v
Record findings
        |
        v
Resolve or escalate
```

## 10. Key Takeaways

- Microsoft 365 Admin Center is a central portal for organisation-level administration.
- User accounts, licences and groups are closely related to user access.
- Product licences and service plans are different concepts.
- Service Health should be checked when multiple users report similar issues.
- A structured troubleshooting process helps avoid assumptions.
- IT Support staff should document findings before escalating an issue.

## 11. Practical Experience and Limitations

During this learning module, I studied the main Microsoft 365 Admin Center functions and common support workflows.

A dedicated Microsoft 365 test tenant was not available.

Therefore, this section documents the concepts and troubleshooting procedures studied. It does not claim that tenant-level user creation, licence assignment, group modification or organisation-wide configuration changes were performed in a live environment.

Further hands-on practice in a Microsoft 365 test tenant would be required to demonstrate these administrative tasks.

## 12. Related Documentation
https://learn.microsoft.com/en-us/microsoft-365/admin/?view=o365-worldwide
https://learn.microsoft.com/en-us/training/modules/introduction-microsoft-365-core-services-admin-control/
