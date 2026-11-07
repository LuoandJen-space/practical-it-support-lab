# INCIDENT CASE REPORT: WIN-01

## 1. Case Metadata & Overview

| Header | Details |
|---|---|
| **Case ID** | WIN-01 |
| **Ticket Status** | Open (Pending Infrastructure & In-Depth Diagnostic) |
| **Severity Level** | Low / Medium (Intermittent User Experience Impact) |
| **Category** | Windows Desktop Support / Performance Degradation |
| **Affected Endpoint** | Windows 11 Workstation (16 GB RAM, SSD Storage) |
| **Reported Issue** | Intermittent system responsiveness degradation during task switching |
| **Technician / Handler** | IT Support Specialist |
| **Date / Time Reported** | 20 October 2026, 04:30 PM |

---

## 2. Investigation & Action Log

### 2.1 Static Baseline Resource Inspection

* **Action Taken:** Launched Task Manager during static idle state to establish baseline resource utilization metrics.
* **Observed Output:**
  ```text
  CPU Utilization. . . . . . . . . : 2–4% (Idle)
  Memory Utilization . . . . . . . : 9.7 GB / 16 GB (60.6%)
  Disk Active Time . . . . . . . . : 0–3%
  ```
* **Analysis:** 
  Baseline shows negligible CPU and Disk activity. While RAM utilization stands at 60.6% (9.7 GB), static observation without active slowdown cannot confirm a hardware bottleneck.

---

### 2.2 Workload Monitoring (Application Execution)

* **Action Taken:** Captured system metrics while operating web browser (Firefox, 5 active tabs) alongside standard background tasks.
* **Observed Output:**
  ```text
  CPU Utilization. . . . . . . . . : 0.1–0.4%
  Memory Utilization . . . . . . . : 11.1 GB / 16 GB (69.3%)
  Disk Active Time . . . . . . . . : [No data retained / Inconclusive]
  ```
* **Analysis:**
  Memory usage increased from 9.7 GB to 11.1 GB. However, CPU activity remained low, and lack of real-time Disk I/O telemetry prevents attributing the reported lag directly to browser memory consumption.

---

### 2.3 Process & System Event Snapshot

* **Action Taken:** Inspected process-level CPU/RAM distribution and system event logs during a recorded load spike.
* **Observed Output:**
  * **Resource Metrics:** CPU spiked to ~31%; RAM utilization recorded at ~63%; Disk active time at 0%.
  * **Active Processes:** 'PowerShell.exe', 'Chrome.exe', and 'dwm.exe' (Desktop Window Manager) identified among top resource consumers.
  * **Startup Impact Check:** 'OneDrive' and 'Microsoft Edge' flagged as High Impact in Startup configuration.
* **Analysis:**
  A 31% CPU spike is non-sustained and insufficient to independently confirm a CPU bottleneck. Disk activity remained at 0% during, ruling out continuous storage saturation during this specific sample. Process logs provide diagnostic leads rather than conclusive root causes.

---

## 3. Diagnostic Summary & Evidence Matrix

| Diagnostic Step | Command / Artifact | Observed Result | Case Assessment |
|---|---|---|---|
| **Baseline Check** | Task Manager | CPU 2-4%, RAM 60.6%, Disk 0-3% | Baseline metrics within expected operating parameters. |
| **Workload Test** | Browser Workload | RAM increased to 11.1 GB | RAM utilization elevated, but no direct lag reproduced. |
| **Process Inspection** | `Get-Process` / Event Viewer | CPU spiked to 31% (`dwm`, `Chrome`) | Transient spike; insufficient to confirm hardware bottleneck. |
| **Startup Analysis** | Task Manager Startup | High-impact startup apps identified | Potential background overhead; connection to symptom unverified. |

---

## 4. Findings & Current Case Status

### 4.1 Technical Finding
Initial diagnostic observations show variable resource utilization across idle and active workloads. However, current evidence fails to correlate CPU, RAM, or Disk activity with the user-reported lag events.

### 4.2 Root Cause Analysis (RCA)
**Status: Unconfirmed / Investigation Ongoing**  
The underlying root cause remains **unestablished**. Available client-side data lacks time-series correlation between resource spikes and user-visible UI degradation. 

**Hypotheses Under Investigation:**
1. **Thermal / Hardware Throttling:** Unmonitored CPU clock frequency drop under load.
2. **Background Process Spikes:** Intermittent background tasks (e.g., Windows Update, Antivirus scanning) running outside observation windows.
3. **Storage I/O Latency:** Sporadic high disk queue length or bad sectors on storage drive not captured in static 0% disk snapshots.

### 4.3 Recommended Next Steps & Remediation Plan
* [ ] Deploy Performance Monitor (`perfmon`) to capture background time-series logs (CPU, RAM, Disk Queue Length) during actual user operations.
* [ ] Inspect Windows Event Logs (`System` and `Application` logs) for Event ID 1001 (Crash), Event ID 129 (Disk Reset), or Thermal Throttling events via PowerShell:
  `Get-WinEvent -LogName System | Where-Object {$_.LevelDisplayName -eq "Error"}`
* [ ] Run hardware diagnostic suite (`chkdsk /f`, SSD SMART health check) to rule out storage degradation.
* [ ] Temporarily perform a Clean Boot (`msconfig`) to isolate high-impact startup items (`OneDrive`, third-party services) from core OS processes.

---

### 5. Sign-off & Record

* **Incident Reported By:** User / Field Lab
* **Documented By:** Helpdesk Tier 1 / Tier 2 Support
* **Ticket Resolution State:** **Unresolved (Pending Time-Series Telemetry & Further Diagnostics)**
