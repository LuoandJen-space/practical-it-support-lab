# Microsoft Entra ID – Fundamentals

## 1. Introduction to Microsoft Entra ID

### 1.1 What is Microsoft Entra ID?

Microsoft Entra ID is Microsoft's cloud-based identity and access management (IAM) service.

It helps organisations manage:
- User identities
- Groups and memberships
- Authentication
- Multi-Factor Authentication (MFA)
- Application access
- Administrative roles
- Conditional Access policies

It is commonly used to manage access to Microsoft 365, Azure, and other cloud applications.

### 1.2 Microsoft Entra ID vs Active Directory Domain Services

| Feature | Active Directory Domain Services (AD DS) | Microsoft Entra ID |
|---|---|---|
| Environment | On-premises | Cloud-based |
| Main purpose | Domain identity and resource management | Cloud identity and access management |
| Identity | Domain users and computers | Cloud users, groups and service identities |
| Authentication | Kerberos, NTLM, LDAP-related authentication workflows | Modern authentication protocols such as OAuth 2.0, OpenID Connect and SAML |
| Management | Active Directory Users and Computers, Group Policy | Microsoft Entra admin center |
| Device management | Domain join and Group Policy | Entra join and integration with Microsoft Intune |

**Important:**

Microsoft Entra ID is not simply a cloud version of traditional Active Directory. They use different identity and management architectures.

Organisations can integrate on-premises AD DS with Microsoft Entra ID using synchronisation tools such as Microsoft Entra Connect Sync or Cloud Sync.

Synchronisation does not automatically mean that every user, group, attribute, and membership is synchronised. The configuration and scope determine what is synchronised.

---

## 2. Tenant and Identity Fundamentals

### 2.1 What is a Tenant?

A tenant is a dedicated instance of Microsoft Entra ID representing an organisation.

A tenant contains identity objects and configuration such as:
- Users
- Groups
- Devices
- Applications
- Administrative role assignments
- Authentication methods
- Conditional Access policies

Each organisation manages its identities and access configuration within its tenant.

### 2.2 User Types

Microsoft Entra ID supports different user identity types.

| User Type | Description |
|---|---|
| Member | An internal organisational user, typically an employee or organisation member |
| Guest | An external user invited to collaborate with the organisation |
| Cloud-only user | An identity created and managed directly in Microsoft Entra ID |
| Synchronized user | An identity originating from an on-premises directory and synchronised to Entra ID |

**Important distinctions:**

- A guest account is not necessarily a user from a particular external organisation; it is an external collaboration identity.
- A synchronized user may have identity attributes managed on-premises.
- A cloud-only user is managed in the cloud and does not require an on-premises AD DS account.

### 2.3 Identity Lifecycle

Identity management generally involves:

1. Account creation
2. Assigning groups and access
3. Managing authentication methods
4. Updating permissions when responsibilities change
5. Disabling or removing access when the user leaves

**IT Support consideration:**

Before making changes, verify the user's identity, account status, source of authority, and approved access requirements.

---

## 3. Users and Groups

### 3.1 Users

A user object represents an identity in Microsoft Entra ID.

Common user attributes include:
- Display name
- User Principal Name (UPN)
- Email address
- Account status
- Department
- Job title
- Assigned groups

Example:

```text
Name: Jessie L
UPN: jessie@contoso.com
Department: IT
Account status: Enabled
```

A User Principal Name (UPN) is commonly used as the user's sign-in name.

It is not necessarily the same as the user's email address.

### 3.2 Groups

Groups organise users and other supported objects to simplify access management.

Two common group types are:

| Group Type | Main Purpose |
|---|---|
| Security Group | Manage access to resources and applications |
| Microsoft 365 Group | Support collaboration across Microsoft 365 services |

### 3.3 Group Membership Types

| Membership Type | Description |
|---|---|
| Assigned | Administrators manually add or remove members |
| Dynamic User | Membership is determined by rules based on user attributes |
| Dynamic Device | Membership is determined by rules based on device attributes |

Dynamic membership requires the appropriate Microsoft Entra licensing.

### 3.4 Group Owner vs Group Member

| Role | Responsibility |
|---|---|
| Owner | Manages the group and its membership, subject to permissions |
| Member | Belongs to the group and may receive access associated with it |

**Important:**

Being a group owner or member does not automatically grant Microsoft Entra administrative privileges.

Some specially configured role-assignable groups can be used to assign administrative roles, but ordinary group membership is not equivalent to an administrative role assignment.

---

## 4. Authentication and Authorization

These are two fundamental identity and access management concepts.

### 4.1 Authentication

Authentication verifies a user's identity.

It answers:

**Who are you?**

Examples:
- Entering a username and password
- Using Microsoft Authenticator
- Completing an MFA challenge
- Using a supported passwordless authentication method

### 4.2 Authorization

Authorization determines what an authenticated identity is allowed to access or perform.

It answers:

**What are you allowed to do?**

Examples:
- Accessing a Microsoft 365 application
- Viewing a department's SharePoint site
- Managing users in Microsoft Entra ID
- Accessing an authorised business application

### 4.3 Authentication vs Authorization

| Authentication | Authorization |
|---|---|
| Verifies identity | Determines permissions |
| Checks whether the user is who they claim to be | Checks whether the user has permission |
| Password and MFA | Roles, group membership and application permissions |
| Sign-in verification | Access control |

**Example:**

A user successfully signs in to Microsoft 365 and completes MFA but receives an Access Denied message when opening a department application.

Possible causes include:
- Missing application assignment
- Incorrect group membership
- Insufficient application permissions
- Application-specific authorization restrictions

Successful authentication does not guarantee application access.

---

## 5. Multi-Factor Authentication (MFA)

### 5.1 What is MFA?

Multi-Factor Authentication adds additional identity verification beyond a single authentication factor.

It uses two or more different categories of authentication factors.

| Factor | Description | Example |
|---|---|---|
| Something you know | Information the user knows | Password |
| Something you have | A physical or registered device | Authenticator app or security key |
| Something you are | A biometric characteristic | Fingerprint or facial recognition |

Two passwords do not count as two different authentication factors.

### 5.2 Common MFA Methods

Examples of authentication methods include:

- Microsoft Authenticator
- SMS verification
- Voice call
- FIDO2 security keys
- Passkeys
- Certificate-based authentication

Available methods depend on organisational configuration and Microsoft Entra policies.

### 5.3 MFA Registration vs MFA Verification

These are different processes.

| Process | Meaning |
|---|---|
| MFA Registration | The user sets up an authentication method |
| MFA Verification | The user completes an authentication challenge during sign-in |

**Example:**

A user registers Microsoft Authenticator on their phone.

Later, when signing in, they receive an authentication request and must complete the verification.

Registering an authentication method does not mean that every future MFA request has already been completed.

### 5.4 Common MFA Problems

Examples include:

- User changes to a new phone.
- Authenticator notifications are not received.
- The registered authentication method is unavailable.
- The user cannot complete the MFA challenge.
- The user receives an unexpected authentication request.

**Security consideration:**

If a user receives an MFA request they did not initiate, they should not approve it. They should reject the request and report it through the organisation's security process.

---

## 6. Conditional Access

### 6.1 What is Conditional Access?

Conditional Access is an identity-based access control capability in Microsoft Entra ID.

It evaluates configured conditions and applies access controls when users attempt to access resources.

It can consider factors such as:

- User or group
- Target application
- Location
- Device state
- Sign-in risk
- User risk
- Client application

### 6.2 Common Conditional Access Controls

| Control | Description |
|---|---|
| Require MFA | Require additional authentication |
| Require compliant device | Require a device that meets the organisation's compliance requirements |
| Block access | Deny access when the policy conditions are met |
| Require approved authentication strength | Require an authentication method that meets the configured strength |

Actual controls depend on the organisation's licensing and policy configuration.

### 6.3 Conditional Access vs MFA

| MFA | Conditional Access |
|---|---|
| Verifies identity using additional authentication | Evaluates access conditions and applies configured controls |
| Focuses on authentication verification | Focuses on access decisions |
| Can be required by Conditional Access | Can require MFA as one of its controls |

**Important:**

Conditional Access and MFA are related but are not the same feature.

A user may successfully enter their password but still be blocked by a Conditional Access policy.

---

## 7. Microsoft Entra Administrative Roles

### 7.1 What are Administrative Roles?

Administrative roles define what administrative actions an assigned identity can perform in Microsoft Entra ID.

They support Role-Based Access Control (RBAC).

Examples:

| Role | Main Responsibility |
|---|---|
| Global Administrator | Broad administrative control over the tenant |
| User Administrator | Manage users and certain user-related settings |
| Helpdesk Administrator | Perform supported helpdesk tasks, including certain password resets |
| Groups Administrator | Manage groups and related settings |
| Authentication Administrator | Manage supported authentication methods and settings |
| Security Administrator | Manage supported security-related settings |

Actual permissions depend on the role's defined permissions, scope, and applicable restrictions.

### 7.2 Role Assignment

A role assignment gives an identity administrative permissions.

Common assignment concepts include:

| Assignment Type | Description |
|---|---|
| Permanent | The role assignment remains in place until changed or removed |
| Eligible | The user can activate the role when required, subject to configured conditions |
| Active | The administrative role is currently activated |

Microsoft Entra Privileged Identity Management (PIM) can be used to manage eligible and time-limited privileged access, subject to licensing and configuration.

### 7.3 Least Privilege

Least Privilege means giving users only the permissions required to perform their responsibilities.

Example:

A Service Desk technician who only needs to perform supported password-reset tasks should not automatically receive the Global Administrator role.

**Benefits:**
- Reduces unnecessary administrative access.
- Limits the potential impact of compromised accounts.
- Improves accountability.
- Supports security and access governance.

---

## 8. Sign-in Logs

### 8.1 What are Sign-in Logs?

Microsoft Entra sign-in logs record sign-in activities and provide information that can help administrators investigate authentication and access issues.

They are available through the Microsoft Entra admin center, subject to permissions and licensing.

### 8.2 Important Log Information

| Field | Description |
|---|---|
| User | Identity attempting to sign in |
| Application | Application the user is accessing |
| Date and Time | When the sign-in occurred |
| Status | Success, failure, or other recorded status |
| IP Address | Source IP address associated with the sign-in |
| Device | Device information, when available |
| Location | Approximate location derived from sign-in information |
| Error Code | Error identifier associated with the event |
| Failure Reason | Explanation of why the sign-in failed |
| Conditional Access | Information about applicable Conditional Access policies |
| Correlation ID | Identifier useful for tracing related events |

### 8.3 Authentication and Sign-in Status

A sign-in investigation should distinguish between:

- Password authentication failure
- MFA failure
- Conditional Access failure
- Successful authentication but denied application access

A failed sign-in does not always mean that the password was incorrect.

The failure stage and detailed log information must be examined.

### 8.4 Error Code Investigation

Error codes can provide useful diagnostic clues.

However, an error code should not be interpreted in isolation.

Always review:
- Status
- Failure reason
- Additional details
- Authentication details
- Conditional Access results
- Relevant sign-in context

The exact failure information is more useful than relying on the error code alone.

---

## 9. Application Access and Permissions

Successful sign-in does not necessarily mean that a user can access every application.

Application access may depend on several independent controls.

### 9.1 Common Access Requirements

| Component | Purpose |
|---|---|
| Authentication | Verifies the user's identity |
| Conditional Access | Evaluates access conditions |
| Application Assignment | Determines whether the user or group is assigned to the application, where assignment is required |
| Group Membership | May provide access through configured group-based assignments or permissions |
| Application Authorization | Determines what the user can do inside the application |

### 9.2 Example

A user can successfully sign in to Microsoft 365 but cannot open a department application.

Possible investigation areas:

1. Confirm the user's identity.
2. Check whether authentication succeeded.
3. Review Conditional Access results.
4. Check application assignment requirements.
5. Verify relevant group membership.
6. Check application-specific permissions.

**Important:**

Not every application uses the same access model. Some applications manage their own permissions independently of Microsoft Entra ID.

---

## 10. Core Concepts Summary

| Concept | Key Question |
|---|---|
| Tenant | Which organisation's identity environment is being used? |
| User | Who is the identity? |
| Group | Which users or objects belong together? |
| Role | What administrative permissions are assigned? |
| Authentication | Has the user's identity been verified? |
| MFA | Has additional authentication been completed? |
| Conditional Access | Do the sign-in conditions satisfy the configured policies? |
| Authorization | Is the user allowed to access the resource or perform the action? |
| Sign-in Logs | What happened during the sign-in attempt? |
| Least Privilege | Does the user have only the permissions required? |

## 11. Microsoft Documentation

Official Microsoft Learn resources:

- [What is Microsoft Entra ID?](https://learn.microsoft.com/en-us/entra/fundamentals/whatis)
- [Microsoft Entra Users](https://learn.microsoft.com/en-us/entra/fundamentals/how-to-create-delete-users)
- [Groups in Microsoft Entra ID](https://learn.microsoft.com/en-us/entra/fundamentals/concept-learn-about-groups)
- [Understand Microsoft Entra Roles](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/concept-understand-roles)
- [How Microsoft Entra MFA Works](https://learn.microsoft.com/en-us/entra/identity/authentication/concept-mfa-howitworks)
- [Conditional Access Overview](https://learn.microsoft.com/en-us/entra/identity/conditional-access/overview)
- [Sign-in Logs in Microsoft Entra ID](https://learn.microsoft.com/en-us/entra/identity/monitoring-health/concept-sign-ins)

---

*Document purpose: Learning reference for Microsoft Entra ID fundamentals and IT Support / Systems Support troubleshooting preparation.*
