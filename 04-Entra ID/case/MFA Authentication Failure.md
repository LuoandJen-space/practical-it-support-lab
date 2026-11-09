# Incident Report – MFA Authentication Failure

**Document Type:** IT Service Desk Incident Report  
**Classification:** Internal Use  
**Organisation:** Example Company  
**Service:** Microsoft Entra ID  
**Incident Reference:** INC-2026-001  
**Priority:** P3 – Medium  
**Status:** Resolved  
**Assignment Group:** IT Service Desk  

---

## 1. Incident Details

| Field | Details |
|---|---|
| Incident ID | INC-2026-001 |
| Reported Date | 09 November 2026 |
| Reported Time | 09:15 NZDT |
| Affected User | Alex Chen |
| Department | Finance |
| Affected Service | Microsoft 365 Sign-in |
| Category | Authentication / MFA |
| Priority | P3 – Medium |
| Assigned Technician | Service Desk Analyst |
| Current Status | Resolved |

## 2. Incident Description

**User Report:**

The user reported being unable to sign in to Microsoft 365. After entering the correct password, the sign-in process requested MFA verification. However, the user did not receive an approval notification from the Microsoft Authenticator app.

**Business Impact:**

The user was temporarily unable to access Microsoft 365 services required for daily work.

**Affected Scope:**

One user account. No other users reported the same issue.

**Error Information:**

- Error Code: 500121
- Failure Reason: Strong authentication request failed
- Additional Details: User did not complete MFA

## 3. Initial Investigation

The Service Desk analyst performed the following checks:

| Check | Result |
|---|---|
| User account | Confirmed correct |
| Account status | Account enabled |
| Username | Verified with user |
| Password authentication | Successful |
| MFA requirement | MFA verification requested |
| Other users affected | No |

**Initial Assessment:**

The sign-in log indicated that primary authentication was successful, but the sign-in process failed during MFA verification.

The issue appeared to be related to MFA completion rather than an incorrect password.

## 4. Technical Investigation Log

| Time | Investigation / Action | Result |
|---|---|---|
| 09:20 | Reviewed the user's sign-in logs in Microsoft Entra admin center. | Primary authentication succeeded; MFA failed. |
| 09:25 | Checked the failure reason and additional details. | User did not complete the MFA request. |
| 09:30 | Contacted the user to confirm whether an MFA notification was received. | User confirmed no notification appeared. |
| 09:35 | Asked the user to open Microsoft Authenticator and check the registered account and notification status. | User confirmed the account was present in the app. |
| 09:40 | Asked the user to initiate a new sign-in and check the Authenticator app again. | New MFA notification received. |
| 09:45 | User approved the sign-in request they had initiated. | MFA completed successfully. |

## 5. Microsoft Entra ID Diagnostic Results

### 5.1 Sign-in Log Details

| Field | Result |
|---|---|
| User | Alex Chen |
| Application | Microsoft 365 |
| Authentication Result | Primary authentication successful |
| MFA Result | Failed initially |
| Error Code | 500121 |
| Failure Reason | Strong authentication request failed |
| Additional Details | User did not complete MFA |

### 5.2 Authentication and MFA

- Password authentication was successful.
- MFA verification was required.
- The initial MFA request was not completed.
- A subsequent MFA request was successfully received and approved by the user.

### 5.3 Conditional Access

No evidence from the reviewed sign-in record indicated that Conditional Access was the cause of this incident.

## 6. Root Cause Analysis

**Confirmed Root Cause:**

The initial MFA request was not completed because the user did not receive or respond to the Authenticator notification at the time of sign-in.

**Supporting Evidence:**

- Sign-in logs showed successful primary authentication.
- The failure occurred during MFA verification.
- The user confirmed that the initial notification was not received.
- A subsequent MFA request was successfully completed.

**Contributing Factors:**

The initial notification may have been delayed or not displayed by the mobile application.

The exact technical reason for the missing notification was not independently confirmed.

## 7. Resolution and Recovery

**Corrective Actions:**

1. Confirmed the user's identity and account details.
2. Reviewed the Entra ID sign-in logs.
3. Confirmed that the failure occurred during MFA verification.
4. Guided the user to check Microsoft Authenticator.
5. Asked the user to initiate a new sign-in.
6. Confirmed that the user received and approved the new MFA request.

**Resolution Summary:**

The user successfully completed MFA verification and regained access to Microsoft 365.

**Service Recovery Verification:**

The user confirmed successful sign-in and access to Microsoft 365.

## 8. Incident Closure

| Field | Details |
|---|---|
| Resolution Code | Resolved – Authentication |
| Resolution Date | 09 November 2026 |
| Resolution Time | 09:45 NZDT |
| User Notified | Yes |
| User Confirmation | Access restored |
| Final Status | Closed |

**Closure Notes:**

The incident was resolved after the user successfully completed a new MFA request. No changes to authentication policies or user security settings were required.

## 9. Escalation History

No escalation required.

## 10. Supporting Evidence

- Microsoft Entra ID sign-in log details.
- MFA failure reason and error code.
- User confirmation of successful sign-in.

**Security Note:** Any screenshots or exported logs must be sanitised before being added to the portfolio. Do not include passwords, authentication codes, access tokens, or personal information.

## 11. Post-Incident Recommendations

- Advise users to keep Microsoft Authenticator updated.
- Remind users to check their registered authentication methods.
- Encourage users to report repeated MFA notification failures.

---

**Report Prepared By:** IT Service Desk Analyst  
**Report Date:** 09 November 2026  
**Document Version:** 1.0  
**Case Type:** Simulated Training Scenario
