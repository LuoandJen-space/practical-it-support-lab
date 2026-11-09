# Incident Report – Conditional Access Policy Block

**Document Type:** IT Service Desk Incident Report  
**Classification:** Internal Use  
**Organisation:** Example Company  
**Service:** Microsoft Entra ID  
**Incident Reference:** INC-2026-002  
**Priority:** P2 – High  
**Status:** Pending – Escalated  
**Assignment Group:** IT Service Desk  

---

## 1. Incident Details

| Field | Details |
|---|---|
| Incident ID | INC-2026-002 |
| Reported Date | 09 November 2026 |
| Reported Time | 10:20 NZDT |
| Affected User | Sarah Wilson |
| Department | Human Resources |
| Affected Service | Internal HR Application |
| Category | Access / Conditional Access |
| Priority | P2 – High |
| Assigned Technician | Service Desk Analyst |
| Current Status | Pending – Escalated |

## 2. Incident Description

**User Report:**

The user reported that she could sign in to Microsoft 365 successfully but could not access the company's internal HR application.

The application displayed an access error during sign-in.

**Business Impact:**

The user was unable to access the HR application required for normal departmental activities.

**Affected Scope:**

One user account. The impact on other users has not yet been confirmed.

**Error Information:**

- Application: Internal HR Application
- Error Message: Access has been blocked by your organisation's access policy.
- Sign-in Result: Failure
- Conditional Access Result: Failure

## 3. Initial Investigation

The Service Desk analyst performed the following checks:

| Check | Result |
|---|---|
| User account | Confirmed correct |
| Account status | Account enabled |
| Microsoft 365 sign-in | Successful |
| HR application access | Failed |
| User group membership | Reviewed; membership requires further validation |
| Application assignment | Requires further investigation |
| Conditional Access | Policy failure recorded in sign-in logs |

**Initial Assessment:**

The user could successfully authenticate to Microsoft 365. However, access to the HR application was blocked.

The issue did not appear to be a general password authentication failure.

Further investigation was required to identify the exact Conditional Access policy and the condition that caused the block.

## 4. Technical Investigation Log

| Time | Investigation / Action | Result |
|---|---|---|
| 10:25 | Confirmed the user's identity and account status. | Account enabled. |
| 10:30 | Asked the user to confirm whether other Microsoft 365 services were accessible. | Other Microsoft 365 services accessible. |
| 10:35 | Reviewed the user's Entra ID sign-in logs. | HR application sign-in failed. |
| 10:40 | Reviewed the Conditional Access tab in the sign-in record. | Conditional Access evaluation showed a failed policy result. |
| 10:45 | Checked the policy evaluation details available to the analyst. | The sign-in was blocked by an organisational access policy. |
| 10:50 | Reviewed the available device and sign-in context. | The exact policy requirement and reason for failure require confirmation from the policy owner. |
| 11:00 | Escalated the incident to the Entra ID administration team. | Awaiting investigation by the responsible team. |

## 5. Microsoft Entra ID Diagnostic Results

### 5.1 Sign-in Log Details

| Field | Result |
|---|---|
| User | Sarah Wilson |
| Application | Internal HR Application |
| Authentication Result | Authentication completed |
| Application Access | Failed |
| Conditional Access Result | Failure |
| Error Code | To be confirmed from the sign-in record |
| Failure Reason | Access blocked by Conditional Access evaluation |
| Correlation ID | To be recorded from the original sign-in event |

### 5.2 Authentication and MFA

- The user could successfully sign in to Microsoft 365.
- The issue was isolated to access to the HR application.
- No confirmed evidence indicated an incorrect password.
- MFA status and any related authentication requirements must be checked against the original sign-in record.

### 5.3 Conditional Access

The sign-in record showed a failed Conditional Access evaluation.

However, the Service Desk analyst did not have sufficient evidence to confirm which policy condition caused the block.

The following items require further investigation by the Entra ID administration team:

- The specific Conditional Access policy involved.
- Whether the policy requires a compliant or managed device.
- Whether the user's device meets the policy requirements.
- Whether the policy applies to the user's account or group.
- Whether any additional authentication requirements were not satisfied.

### 5.4 Application Access

The user's ability to access other Microsoft 365 services does not prove that she has permission to access the HR application.

The following checks remain outstanding:

- HR application assignment.
- Required group membership.
- Application-specific permissions.
- Any additional access requirements configured by the application owner.

## 6. Root Cause Analysis

**Root Cause Status:** Under Investigation

**Current Finding:**

The sign-in log indicates that Conditional Access evaluation failed when the user attempted to access the HR application.

The exact policy condition responsible for the failure has not yet been confirmed.

**Available Evidence:**

- The user can access other Microsoft 365 services.
- The HR application sign-in failed.
- The sign-in record shows a failed Conditional Access result.

**Outstanding Investigation:**

The Entra ID administration team must review the policy evaluation details and confirm the specific blocking condition.

The possibility of an additional application assignment or authorisation issue also remains open.

## 7. Resolution and Recovery

**Resolution Status:** Not Resolved

**Actions Completed:**

1. Confirmed the affected user and application.
2. Verified that the user could access other Microsoft 365 services.
3. Reviewed the Entra ID sign-in record.
4. Identified a failed Conditional Access evaluation.
5. Escalated the incident to the Entra ID administration team.

**Actions Not Performed:**

- No Conditional Access policy was modified.
- No security requirement was bypassed.
- No user security setting was changed without authorisation.

**Reason for Non-Resolution:**

The Service Desk analyst did not have the required administrative authority or sufficient evidence to safely modify or exclude the user from the Conditional Access policy.

The incident remains open pending further investigation.

## 8. Incident Closure

| Field | Details |
|---|---|
| Resolution Code | Pending – No Resolution |
| Resolution Date | Not applicable |
| User Notified | Yes |
| User Confirmation | Access not restored |
| Final Status | Pending – Escalated |

**Closure Notes:**

The incident has not been resolved. The user was informed that the issue had been escalated to the Entra ID administration team.

The incident must remain open until the blocking condition is identified, an authorised corrective action is completed, and application access is verified.

## 9. Escalation History

| Time | Escalated To | Reason | Status |
|---|---|---|---|
| 11:00 NZDT | Entra ID Administration Team | Conditional Access policy evaluation requires administrative investigation. | Pending |

**Escalation Request:**

Please review the Conditional Access evaluation for the affected user's sign-in to the internal HR application.

Confirm the specific policy and condition responsible for the block. Please also verify whether the device meets the relevant access requirements and whether the user has the required application assignment and permissions.

No policy changes have been made by the Service Desk.

## 10. Supporting Evidence

- Original Entra ID sign-in log.
- Conditional Access evaluation result.
- User-reported application error.
- Incident escalation record.

**Outstanding Evidence:**

- Exact policy name and policy evaluation details.
- Device compliance status.
- Application assignment and permission verification.
- Correlation ID from the original sign-in event.

**Security Note:** Any screenshots or exported logs must be sanitised before being added to the portfolio. Do not include passwords, authentication codes, access tokens, or personal information.

## 11. Post-Incident Recommendations

Following investigation and resolution:

- Review whether the Conditional Access policy is functioning as intended.
- Confirm that the policy requirements are clearly communicated to affected users.
- Verify that authorised users have the correct application assignment.
- Document the confirmed root cause and corrective action.
- Monitor for similar access failures if multiple users are affected.

---

**Report Prepared By:** IT Service Desk Analyst  
**Report Date:** 09 November 2026  
**Document Version:** 1.0  
**Case Type:** Simulated Training Scenario
