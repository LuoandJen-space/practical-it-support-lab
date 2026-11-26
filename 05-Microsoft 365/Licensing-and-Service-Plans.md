# Microsoft 365 Licensing and Service Plans

## 1. Overview

Microsoft 365 licensing determines which products and services a user can access.

A user account may exist successfully in Microsoft 365, but the user may still be unable to access services such as Exchange Online, SharePoint Online, or Microsoft Teams if the required licence or service plan is missing, disabled, or incorrectly configured.

This document explains the relationship between user accounts, product licences, service plans, and common licensing troubleshooting procedures.

## 2. Key Concepts

### 2.1 User Account

A user account represents an individual identity in Microsoft 365.

It contains information such as:

- Display name
- Username (User Principal Name)
- Account status
- Usage location
- Group membership

Creating a user account does not automatically grant access to all Microsoft 365 services.

### 2.2 Product Licence

A product licence determines which Microsoft 365 product subscription is assigned to a user.

Examples include:

- Microsoft 365 Business Basic
- Microsoft 365 Business Standard
- Microsoft 365 Business Premium
- Microsoft 365 E3

The available products and included services depend on the organisation's subscription and licensing agreement.

### 2.3 Service Plan

A service plan is an individual service component included within a product licence.

For example, a Microsoft 365 subscription may include service plans for:

- Exchange Online
- SharePoint Online
- Microsoft Teams
- Microsoft 365 Apps

The exact service plans depend on the product, subscription, and licensing configuration.

**Important:** Assigning a product licence does not necessarily mean every included service plan is enabled.

An administrator may disable a particular service plan while leaving other services enabled.

## 3. Relationship Between Account, Licence and Service Plan

The following structure helps explain the relationship:

```text
Microsoft 365 User Account
          |
          v
    Product Licence
          |
          v
     Service Plans
          |
          +---- Exchange Online
          |
          +---- SharePoint Online
          |
          +---- Microsoft Teams
          |
          +---- Microsoft 365 Apps
```

A user may have a valid product licence but still experience problems accessing a specific service if its required service plan is disabled or unavailable.

## 4. Licence Assignment Methods

Microsoft 365 supports different licence assignment approaches.

### 4.1 Direct Licence Assignment

An administrator assigns a product licence directly to an individual user.

Typical use cases:

- Assigning a licence to a new employee
- Providing an individual licence exception
- Managing a small number of user accounts

Troubleshooting checks:

1. Confirm that the user account exists.
2. Confirm that the account is enabled.
3. Check whether a product licence is assigned.
4. Check whether the required service plans are enabled.
5. Check for licence assignment errors.

### 4.2 Group-Based Licence Assignment

Licences can also be assigned through supported Microsoft Entra ID groups.

When a user becomes a member of a group with a licence assigned, the user can receive the corresponding licence through group-based licensing.

Typical use cases:

- Applying standard licences to departments
- Managing licences for large organisations
- Reducing repetitive manual administration
- Maintaining consistent licence assignments

Troubleshooting checks:

1. Confirm that the user belongs to the correct group.
2. Confirm that the group has the expected product licence.
3. Check the group licence assignment status.
4. Review any assignment errors.
5. Confirm that the required service plans are enabled.

**Important:** A user's licence may be assigned directly, through a group, or through multiple assignment sources. Always identify the actual assignment source before changing anything.

## 5. Common Licensing Problems

### Case 1: User Cannot Access Exchange Online

**Scenario**

A user reports that they cannot access their mailbox in Outlook or Outlook on the web.

**Possible causes**

- No product licence assigned.
- Exchange Online service plan disabled.
- Licence assignment error.
- Incorrect usage location.
- Exchange Online provisioning or service issue.

**Troubleshooting procedure**

1. Open Microsoft 365 Admin Center.
2. Navigate to Users > Active users.
3. Select the affected user.
4. Review the assigned product licences.
5. Open the licence and apps/service plan settings.
6. Confirm that Exchange Online is enabled.
7. Check the licence assignment status.
8. Review Microsoft 365 Service Health if the issue remains unresolved.

**Expected result**

The user has an appropriate product licence, and the required Exchange Online service plan is enabled and successfully provisioned.
![virtu switch config check](05-01.jpg)
### Case 2: Product Licence Assigned but Service Unavailable

**Scenario**

A user has a Microsoft 365 product licence, but a particular service is unavailable.

**Possible causes**

- The required service plan is disabled.
- The service plan is still being provisioned.
- The licence assignment has failed.
- The service is experiencing an outage.

**Troubleshooting procedure**

1. Verify the assigned product licence.
2. Review the included service plans.
3. Identify the service plan required by the affected application.
4. Check whether that service plan is enabled.
5. Review licence assignment errors.
6. Check Microsoft 365 Service Health.

**Expected result**

The required service plan is enabled and successfully provisioned, or the issue is escalated with supporting evidence.

### Case 3: Licence Assignment Failed

**Scenario**

An administrator attempts to assign a licence but receives an error.

**Possible causes**

- No available licence seats.
- Missing or incorrect usage location.
- Conflicting licence or service plan configuration.
- Group-based licensing errors.
- Subscription or assignment restrictions.

**Troubleshooting procedure**

1. Confirm the organisation has available licence seats.
2. Verify the user's usage location.
3. Review the exact assignment error.
4. Check for conflicting service plans or licence dependencies.
5. If group-based licensing is used, inspect the group assignment status.
6. Correct the underlying issue and retry the assignment.
7. Verify the final licence status.

**Expected result**

The licence is assigned successfully, and no unresolved assignment errors remain.

## 6. Licensing Troubleshooting Workflow

Use this workflow when a user reports that a Microsoft 365 service is unavailable.

```text
User Reports Service Access Issue
              |
              v
       Check User Account
              |
              v
      Check Product Licence
              |
              v
    Check Required Service Plan
              |
              v
   Check Licence Assignment Status
              |
              v
     Check Usage Location
              |
              v
      Check Service Health
              |
              v
       Verify Service Access
              |
              v
       Document Findings
```

### Diagnostic Checklist

| Check | Question |
|---|---|
| User Account | Does the user account exist and remain enabled? |
| Product Licence | Is the appropriate product licence assigned? |
| Assignment Source | Is the licence assigned directly or through a group? |
| Service Plan | Is the required service plan enabled? |
| Assignment Status | Are there any licence assignment errors? |
| Usage Location | Is the user's usage location configured correctly? |
| Service Health | Is Microsoft reporting a relevant service incident? |
| Verification | Can the user access the affected service? |

## 8. Important Troubleshooting Considerations

- Do not assume that an assigned product licence means every service is enabled.
- Always identify the required service plan for the affected application.
- Check the licence assignment source before making changes.
- Do not remove and reassign licences without understanding the potential service impact.
- Consider provisioning delays after a licence or service plan change.
- Check Microsoft 365 Service Health before assuming the issue is caused by an individual user's configuration.
- Follow organisational approval and change-management procedures before modifying licence assignments.

## 9. Hands-on Practice and Environment Limitations

This topic was studied as part of the Microsoft 365 learning programme.

The following concepts and troubleshooting procedures were practised through guided exercises:

- User account versus product licence
- Product licence versus service plan
- Direct licence assignment versus group-based licensing
- Exchange Online service plan configuration
- Usage location
- Licence assignment errors
- Microsoft 365 service health checks

## 10. Skills Demonstrated

- Understanding Microsoft 365 licensing architecture
- Identifying the difference between product licences and service plans
- Understanding direct and group-based licence assignment
- Investigating common licence assignment problems
- Troubleshooting Exchange Online service access issues
- Following a structured troubleshooting workflow
- Recording diagnostic findings and recommended actions
- Recognising when administrator access or escalation is required

---

**Project:** W7 - Microsoft 365 Support  
**Topic:** Licensing and Service Plans  
**Document Type:** Technical Notes and Troubleshooting Guide
