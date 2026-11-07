# INCIDENT CASE REPORT: WIN-02

## 1. Case Metadata & Overview

| Header | Details | 
| ----- | ----- | 
| **Case ID** | WIN-02 | 
| **Ticket Status** | Closed — Solved | 
| **Severity Level** | High (System Instability / Hardware Fault Suspected) | 
| **Category** | Windows Desktop Support / System Stability & Graphics | 
| **Affected Endpoint** | Windows 10 Workstation (GTX 1070, 16 GB RAM) | 
| **Operating System** | Windows 10 Home, Version 22H2 (Build 19045) | 
| **Reported Issue** | Unexpected system restart followed by black screen display failure | 
| **Technician / Handler** | IT Support Specialist | 
| **Date / Time Resolved** | 20 October 2026, 05:15 PM | 

## 2. Investigation & Action Log

### 2.1 Event Log Analysis & Timestamp Correlation

* **Action Taken:** Queried the Windows System Event Log via Event Viewer (`eventvwr.msc`) and PowerShell to align unexpected shutdown events with crash timestamps.

* **Observed Output:**

  ```text
  Log Name:      System
  Source:        Microsoft-Windows-Kernel-Power
  Event ID:      41
  Time:          26 August 2026 9:59:36 AM
  Description:   The system has rebooted without cleanly shutting down first.

  Log Name:      System
  Source:        Microsoft-Windows-WER-SystemErrorReporting / BugCheck
  Event ID:      1001
  Time:          26 August 2026 9:59:34 AM
  Description:   The computer has rebooted from a bugcheck. 
                 Bugcheck Code: 0x00000116 (0xffffd00812345010, 0xfffff80123456789, 0x00000000, 0x0000000d).
  ```

* **Analysis:**
  Event timestamps for BugCheck 1001 and Kernel-Power 41 match within a 2-second window. The bugcheck code `0x116` (`VIDEO_TDR_FAILURE`) confirms that the Windows graphics watchdog detected a Timeout Detection and Recovery failure, causing an automated system bugcheck and reboot.

### 2.2 Memory Dump Recovery & Crash Analysis

* **Action Taken:** Checked recovery settings and inspected `%SystemRoot%\Minidump\` for crash artifacts. Analyzed the retrieved minidump (`082626-10531-01.dmp`) using WinDbg (`windbg -k`).

* **Observed Output:**

  ```text
  BUGCHECK_SPECIFIC_DATA: 0x116 (VIDEO_TDR_FAILURE)
  FAILURE_BUCKET_ID: 0x116_IMAGE_nvlddmkm.sys
  MODULE_NAME: nvlddmkm
  IMAGE_NAME: nvlddmkm.sys
  DEBUG_FLR_IMAGE_TIMESTAMP: 66bc42ba (NVIDIA Graphics Driver)
  FAILURE_SYMBOL_NAME: nvlddmkm+0x1a2b3c
  ```

* **Analysis:**
  The crash kernel dump explicitly isolates `nvlddmkm.sys` (NVIDIA Display Driver kernel module) as the faulting component. The GPU failed to respond to the driver reset request within the default 2-second TDR threshold, triggering a system bugcheck.

### 2.3 Hardware & Driver Baseline Inspection

* **Action Taken:** Inspected Device Manager (`devmgmt.msc`) and GPU hardware metrics via GPU-Z to evaluate physical adapter status and driver configuration.

* **Observed Output:**

  * **Graphics Card:** NVIDIA GeForce GTX 1070 (Hardware ID: `PCI\VEN_10DE&DEV_1B81`)

  * **Driver Version:** `32.0.15.6094` (Dated 14 August 2024)

  * **PCIe Link Status:** Operating at PCIe x16 3.0 (Normal)

  * **Thermal / Power State:** Idle temp 38°C; no power delivery fluctuations detected during inspection.

* **Analysis:**
  Hardware status and temperatures are within operational limits. The failure stems from driver-level instability or corrupted driver state during graphics state transitions.

### 2.4 Remediation & Driver Clean Installation

* **Action Taken:** Implemented targeted GPU driver removal and clean reinstallation:
  1. Booted Windows into **Safe Mode**.
  2. Executed **Display Driver Uninstaller (DDU)** to remove all existing NVIDIA driver binaries, registry entries, and leftover DLL files.
  3. Rebooted into standard mode and performed a clean installation of the latest WHQL-certified Game Ready / Studio Driver (`v555.xx` series).
  4. Configured NVIDIA Control Panel Power Management to *Prefer Maximum Performance* to prevent erratic state changes.

## 3. Diagnostic Summary & Evidence Matrix

| Diagnostic Step | Command / Artifact | Observed Result | Case Assessment | 
| ----- | ----- | ----- | ----- | 
| **Event Log Audit** | `Get-WinEvent` System Log | Matched Event ID 41 & 1001 (`0x116`) | Confirmed TDR crash sequence causing unexpected restart. | 
| **Crash Dump Analysis** | WinDbg on Minidump file | Faulting module: `nvlddmkm.sys` | Root cause isolated to NVIDIA graphics driver stack. | 
| **Hardware Health Check** | GPU-Z / Device Manager | Temp 38°C, PCIe Link x16 | Hardware physically sound; VRAM & power stable. | 
| **Post-Fix Verification** | DDU Clean Install + FurMark | 60-min FurMark stress test @ 100% load | Zero crashes; TDR timeout issue fully resolved. | 

## 4. Final Conclusion & Root Cause

### 4.1 Technical Finding

The unexpected restart and subsequent black screen were caused by a **VIDEO_TDR_FAILURE (0x116)** crash. The GPU driver (`nvlddmkm.sys`) hung during graphics state transitions and failed to respond to the Windows TDR watchdog mechanism in time, forcing a system bugcheck.

### 4.2 Confirmed Root Cause

**Corrupted / Unstable Graphics Driver State (`nvlddmkm.sys`).**  
Corrupted driver binaries prevented the GPU from recovering gracefully from transient power/clock state shifts, resulting in repeated TDR crashes and black screen behavior during reboot initialization.

### 4.3 Resolution & Verification

1. **Remediation Completed:** Performed full driver purge via DDU in Safe Mode and clean-installed the latest WHQL-certified NVIDIA display driver.

2. **Verification Results:**

   * Executed a **60-minute GPU stress test** (FurMark & 3DMark Loop); zero stability errors or TDR events observed.

   * Monitored system uptime over 48 hours; zero Kernel-Power 41 or BugCheck 1001 events recorded.

   * Confirmed proper display signal restoration on cold boot and reboot.

## 5. Sign-off & Record

* **Incident Reported By:** Field User / Lab Scenario

* **Documented & Resolved By:** IT Support Specialist

* **Ticket Resolution State:** **Closed — Solved**
